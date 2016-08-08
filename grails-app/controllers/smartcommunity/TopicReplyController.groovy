package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TopicReplyController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TopicReply.list(params), model:[topicReplyInstanceCount: TopicReply.count()]
    }

    def show(TopicReply topicReplyInstance) {
        respond topicReplyInstance
    }

    def create() {
        respond new TopicReply(params)
    }

    @Transactional
    def save(TopicReply topicReplyInstance) {
        if (topicReplyInstance == null) {
            notFound()
            return
        }

        if (topicReplyInstance.hasErrors()) {
            respond topicReplyInstance.errors, view:'create'
            return
        }

        topicReplyInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'topicReply.label', default: 'TopicReply'), topicReplyInstance.id])
                redirect topicReplyInstance
            }
            '*' { respond topicReplyInstance, [status: CREATED] }
        }
    }

    def edit(TopicReply topicReplyInstance) {
        respond topicReplyInstance
    }

    @Transactional
    def update(TopicReply topicReplyInstance) {
        if (topicReplyInstance == null) {
            notFound()
            return
        }

//        if (topicReplyInstance.hasErrors()) {
//            respond topicReplyInstance.errors, view:'edit'
//            return
//        }
        topicReplyInstance.status = params.status? params.int("status"):topicReplyInstance.status
        topicReplyInstance.errors.each {err->
            println err
        }

        if(topicReplyInstance.save(flush:true)){
            redirect(controller: 'topic',action: 'show',id:topicReplyInstance.topic.id)
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TopicReply.label', default: 'TopicReply'), topicReplyInstance.id])
                redirect topicReplyInstance
            }
            '*'{ respond topicReplyInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TopicReply topicReplyInstance) {

        if (topicReplyInstance == null) {
            notFound()
            return
        }

        topicReplyInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TopicReply.label', default: 'TopicReply'), topicReplyInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'topicReply.label', default: 'TopicReply'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
