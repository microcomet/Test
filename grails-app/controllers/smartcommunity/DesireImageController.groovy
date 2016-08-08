package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DesireImageController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DesireImage.list(params), model:[desireImageInstanceCount: DesireImage.count()]
    }

    def show(DesireImage desireImageInstance) {
        respond desireImageInstance
    }

    def create() {
        respond new DesireImage(params)
    }

    @Transactional
    def save(DesireImage desireImageInstance) {
        if (desireImageInstance == null) {
            notFound()
            return
        }

        if (desireImageInstance.hasErrors()) {
            respond desireImageInstance.errors, view:'create'
            return
        }

        desireImageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'desireImage.label', default: 'DesireImage'), desireImageInstance.id])
                redirect desireImageInstance
            }
            '*' { respond desireImageInstance, [status: CREATED] }
        }
    }

    def edit(DesireImage desireImageInstance) {
        respond desireImageInstance
    }

    @Transactional
    def update(DesireImage desireImageInstance) {
        if (desireImageInstance == null) {
            notFound()
            return
        }

        if (desireImageInstance.hasErrors()) {
            respond desireImageInstance.errors, view:'edit'
            return
        }

        desireImageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DesireImage.label', default: 'DesireImage'), desireImageInstance.id])
                redirect desireImageInstance
            }
            '*'{ respond desireImageInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DesireImage desireImageInstance) {

        if (desireImageInstance == null) {
            notFound()
            return
        }

        desireImageInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DesireImage.label', default: 'DesireImage'), desireImageInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'desireImage.label', default: 'DesireImage'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
