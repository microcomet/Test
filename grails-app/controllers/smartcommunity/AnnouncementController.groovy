package smartcommunity

import org.springframework.web.multipart.MultipartHttpServletRequest
import user.UserInfo

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AnnouncementController {

    def imageService

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

        def streetId = params.streetId?params.int('streetId'):null
        def communityId = params.communityId?params.int('communityId'):null
        def title = params.title
        def status = params.status
        def closerId = params.closerId

        def query = {
            if (streetId) {
                eq("street", Street.get(streetId))
            }

            if (communityId) {
                eq("community", Community.get(communityId))
            }


            if (title) {
                like("title", "%" + title + "%")
            }


            if (status) {
                eq("status", status)
            }

//            if (closerId) {
//                eq("closer.id", closerId)
//            }

            order("create_time", (params.order == 0 ? "asc" : "desc"))
        }

        params.max = Math.min(max ?: 10, 100)

        def total = Announcement.createCriteria().count(query)
        def list = Announcement.createCriteria().list (query, offset: params.offset, max: params.max)

        respond list, model: [announcementInstanceCount: total]

    }

    def show(Announcement announcementInstance) {
        def imageList = AnnouncementImage.findAllByAnnouncementAndStatus(announcementInstance, 1)
        announcementInstance.image_ids = []
        imageList.each { image ->
            announcementInstance.image_ids.add(image.image.id)
        }

        respond announcementInstance
    }

    def create() {
        respond new Announcement(params)
    }

    @Transactional
    def save(Announcement announcementInstance) {
        if (announcementInstance == null) {
            notFound()
            return
        }

        if (announcementInstance.hasErrors()) {
            respond announcementInstance.errors, view:'create'
            return
        }

        def current_user = (UserInfo)session.getAttribute('user')
        if (!current_user) {
            flash.message = message(code:'announcement.message.user.nologin', default:'Errors')
            respond announcementInstance, view: 'create'
            return
        }
        announcementInstance.street = announcementInstance.street ?: Street.get(current_user.street_id)
        announcementInstance.community = announcementInstance.community ?: Community.get(current_user.community_id)
        announcementInstance.status = 1
        announcementInstance.publisher = User.get(current_user.user_id)
        announcementInstance.create_time = new Date()
        announcementInstance.update_time = new Date()
        announcementInstance.save(flush:true)

        if(params.files != null && request instanceof MultipartHttpServletRequest){
            def default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            def files = request.getFiles("files")
            files.each {file ->
                def ret = imageService.saveImage(file, "${default_image_location}${current_user.name}")
                if(ret != -1){
                    Image imageInstance = new Image([
                            name: ret,
                            storage_url: "${default_image_location}${current_user.name}/${ret}",
                            uploader: User.get(current_user.user_id),
                            upload_time: new Date(),
                            status: 1,
                            create_time: new Date(),
                            update_time: new Date()
                    ])
                    println imageInstance.errors
                    imageInstance.save(flush: true)

                    AnnouncementImage announcementImage = new AnnouncementImage([
                            announcement: announcementInstance,
                            image: imageInstance,
                            status: 1
                    ])

                    println announcementImage.errors
                    announcementImage.save(flush: true)
                }
            }
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'announcement.label', default: 'Announcement'), announcementInstance.id])
                redirect announcementInstance
            }
            '*' { respond announcementInstance, [status: CREATED] }
        }
    }

    def edit(Announcement announcementInstance) {
        def imageList = AnnouncementImage.findAllByAnnouncementAndStatus(announcementInstance, 1)
        announcementInstance.image_ids = []
        imageList.each { image ->
            announcementInstance.image_ids.add(image.image.id)
        }
        respond announcementInstance
    }

    @Transactional
    def update(Announcement announcementInstance) {
        if (announcementInstance == null) {
            notFound()
            return
        }

        if (announcementInstance.hasErrors()) {
            respond announcementInstance.errors, view:'edit'
            return
        }
        println announcementInstance.errors

        def current_user = (UserInfo)session.getAttribute('user')
        if (!current_user) {
            flash.message = message(code:'announcement.message.user.nologin', default:'Errors')
            respond announcementInstance, view: 'create'
            return
        }

        if(params.status){
            announcementInstance.status = params.int("status")
        }

        if (announcementInstance.status == 2) {
            announcementInstance.closer = User.get(current_user.user_id)
            announcementInstance.close_time = new Date()
            announcementInstance.update_time = new Date()
        }

        announcementInstance.save(flush:true)


        if(params.files != null && params.files.size > 0 && request instanceof MultipartHttpServletRequest){
            def priorImageList = AnnouncementImage.findAllByAnnouncementAndStatus(announcementInstance, 1)
            priorImageList.each {image ->
                image.status = 2
                image.save(flush: true)
            }

            def default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            def files = request.getFiles("files")

            files.each {file ->
                def ret = imageService.saveImage(file, "${default_image_location}${current_user.name}")
                if(ret != -1){
                    Image imageInstance = new Image([
                            name: ret,
                            storage_url: "${default_image_location}${current_user.name}/${ret}",
                            uploader: User.get(current_user.user_id),
                            upload_time: new Date(),
                            status: 1,
                            create_time: new Date(),
                            update_time: new Date()
                    ])
                    imageInstance.save(flush: true)

                    AnnouncementImage announcementImage = new AnnouncementImage([
                            announcement: announcementInstance,
                            image: imageInstance,
                            status: 1
                    ])

                    announcementImage.save(flush: true)
                }
            }
        }
        redirect(controller: 'announcement', action: 'index')
        return


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Announcement.label', default: 'Announcement'), announcementInstance.id])
                redirect announcementInstance
            }
            '*'{ respond announcementInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Announcement announcementInstance) {

        if (announcementInstance == null) {
            notFound()
            return
        }

        def imageList = AnnouncementImage.findAllByAnnouncement(announcementInstance)
        imageList.each { image ->
            image.delete(flush: true)
        }

        announcementInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Announcement.label', default: 'Announcement'), announcementInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'announcement.label', default: 'Announcement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
