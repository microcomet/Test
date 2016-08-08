package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PollOptionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PollOption.list(params), model:[pollOptionInstanceCount: PollOption.count()]
    }

    def show(PollOption pollOptionInstance) {
        respond pollOptionInstance
    }

    def create() {
        respond new PollOption(params)
    }

    @Transactional
    def save(PollOption pollOptionInstance) {
        if (pollOptionInstance == null) {
            notFound()
            return
        }

        if (pollOptionInstance.hasErrors()) {
            respond pollOptionInstance.errors, view:'create'
            return
        }

        pollOptionInstance.create_time = new Date()
        pollOptionInstance.update_time = new Date()

        pollOptionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pollOption.label', default: 'PollOption'), pollOptionInstance.id])
                redirect pollOptionInstance
            }
            '*' { respond pollOptionInstance, [status: CREATED] }
        }
    }

    def edit(PollOption pollOptionInstance) {
        respond pollOptionInstance
    }

    @Transactional
    def update(PollOption pollOptionInstance) {
        if (pollOptionInstance == null) {
            notFound()
            return
        }

        if (pollOptionInstance.hasErrors()) {
            respond pollOptionInstance.errors, view:'edit'
            return
        }

        pollOptionInstance.update_time = new Date()

        pollOptionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PollOption.label', default: 'PollOption'), pollOptionInstance.id])
                redirect pollOptionInstance
            }
            '*'{ respond pollOptionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PollOption pollOptionInstance) {

        if (pollOptionInstance == null) {
            notFound()
            return
        }

        pollOptionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PollOption.label', default: 'PollOption'), pollOptionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pollOption.label', default: 'PollOption'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
