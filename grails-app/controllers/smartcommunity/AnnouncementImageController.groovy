package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AnnouncementImageController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AnnouncementImage.list(params), model:[announcementImageInstanceCount: AnnouncementImage.count()]
    }

    def show(AnnouncementImage announcementImageInstance) {
        respond announcementImageInstance
    }

    def create() {
        respond new AnnouncementImage(params)
    }

    @Transactional
    def save(AnnouncementImage announcementImageInstance) {
        if (announcementImageInstance == null) {
            notFound()
            return
        }

        if (announcementImageInstance.hasErrors()) {
            respond announcementImageInstance.errors, view:'create'
            return
        }

        announcementImageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'announcementImage.label', default: 'AnnouncementImage'), announcementImageInstance.id])
                redirect announcementImageInstance
            }
            '*' { respond announcementImageInstance, [status: CREATED] }
        }
    }

    def edit(AnnouncementImage announcementImageInstance) {
        respond announcementImageInstance
    }

    @Transactional
    def update(AnnouncementImage announcementImageInstance) {
        if (announcementImageInstance == null) {
            notFound()
            return
        }

        if (announcementImageInstance.hasErrors()) {
            respond announcementImageInstance.errors, view:'edit'
            return
        }

        announcementImageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AnnouncementImage.label', default: 'AnnouncementImage'), announcementImageInstance.id])
                redirect announcementImageInstance
            }
            '*'{ respond announcementImageInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AnnouncementImage announcementImageInstance) {

        if (announcementImageInstance == null) {
            notFound()
            return
        }

        announcementImageInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AnnouncementImage.label', default: 'AnnouncementImage'), announcementImageInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'announcementImage.label', default: 'AnnouncementImage'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
