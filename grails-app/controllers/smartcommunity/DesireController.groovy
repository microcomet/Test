package smartcommunity

import org.springframework.web.multipart.MultipartHttpServletRequest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DesireController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def imageService

    def index(Integer max) {

        def desc = params.description
        def requester = params.requester
        def status = params.status

        def query = {

//            createAlias("helper", "helper")
            if (status) {
                eq("status", Integer.parseInt(status))
            }
            if (desc) {
                like("description", "%" + desc + "%")
            }

            if (requester) {
                createAlias("requester", "requester")
                like("requester.name", "%" + requester + "%")
            }



            order("create_time", (params.order == 0 ? "asc" : "desc"))
        }
        params.max = Math.min(max ?: 10, 100)

        def total = Desire.createCriteria().count(query)

        def list = Desire.createCriteria().list(query, offset: params.offset, max: params.max)

        def publishCount = 0
        def progressCount = 0
        def helperConfirmCount = 0
        def finishedCount = 0
        def deletedCount = 0

        def it = list.iterator()
        it.each { tinyWish ->
            switch (tinyWish.status) {
                case 1:
                    publishCount++
                    break
                case 2:
                    progressCount++
                    break
                case 3:
                    helperConfirmCount++
                    break
                case 5:
                    finishedCount++
                    break
                case 6:
                    deletedCount++
                    break
                default:
                    break
            }
        }

        respond list, model: [
                desireInstanceCount: total,
                published          : publishCount,
                progressing        : progressCount,
                helperConfirmed    : helperConfirmCount,
                finished           : finishedCount,
                deleted            : deletedCount
        ]
    }

    def show(Desire desireInstance) {
        def imageList = DesireImage.findAllByDesireAndStatus(desireInstance, 1)
        desireInstance.image_ids = []
        imageList.each { image ->
            desireInstance.image_ids.add(image.image.id)
        }

        respond desireInstance
    }

    def create() {
        respond new Desire(params)
    }

    @Transactional
    def save(Desire desireInstance) {
        if (desireInstance == null) {
            notFound()
            return
        }

        if (desireInstance.hasErrors()) {
            respond desireInstance.errors, view: 'create'
            return
        }

        def current_user = (User) session.getAttribute('user')
        if (!current_user) {
            flash.message = message(code: 'desire.message.user.nologin', default: 'Errors')
            respond desireInstance, view: 'create'
            return
        }

        desireInstance.score = desireInstance.score ?: Score.findByType(2).score
        desireInstance.requester = desireInstance.requester ?: current_user
        desireInstance.community = desireInstance.community ?: current_user.community
        desireInstance.status = 1
        desireInstance.create_time = new Date()
        desireInstance.update_time = new Date()
        desireInstance.save flush: true

        if (params.files.size != 0 && request instanceof MultipartHttpServletRequest) {
            def default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            def files = request.getFiles("files")
            files.each { file ->
                def ret = imageService.saveImage(file, "${default_image_location}${current_user.name}")
                if (ret != -1) {
                    Image imageInstance = new Image([
                            name       : ret,
                            storage_url: "${default_image_location}${current_user.name}/${ret}",
                            uploader   : current_user,
                            upload_time: new Date(),
                            status     : 1,
                            create_time: new Date(),
                            update_time: new Date()
                    ])
                    imageInstance.save(flush: true)

                    DesireImage desireImage = new DesireImage([
                            desire: desireInstance,
                            image : imageInstance,
                            status: 1
                    ])
                    desireImage.save(flush: true)
                }
            }
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'desire.label', default: 'Desire'), desireInstance.id])
                redirect desireInstance
            }
            '*' { respond desireInstance, [status: CREATED] }
        }
    }

    def edit(Desire desireInstance) {
        respond desireInstance
    }

    @Transactional
    def update(Desire desireInstance) {
        if (desireInstance == null) {
            notFound()
            return
        }

        if (desireInstance.hasErrors()) {
            respond desireInstance.errors, view: 'edit'
            return
        }

        desireInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Desire.label', default: 'Desire'), desireInstance.id])
                redirect desireInstance
            }
            '*' { respond desireInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Desire desireInstance) {

        if (desireInstance == null) {
            notFound()
            return
        }

        desireInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Desire.label', default: 'Desire'), desireInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'desire.label', default: 'Desire'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
