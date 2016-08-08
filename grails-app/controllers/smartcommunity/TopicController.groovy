package smartcommunity

import user.UserInfo

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TopicController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

        def title = params.title
        def status = params.status?params.int('status'):null
        def creator = params.promoter

        def query = {
            createAlias("promoter","promoter")
            if (title) {
                like ("title", "%" + title + "%")
            }


            if (status) {
                eq("status", status)
            }

            if (creator) {
                or{
                    like("promoter.nick_name", "%" + creator + "%")
                    like("promoter.name", "%" + creator + "%")
                }
            }

            order("create_time", (params.order == 0 ? "asc" : "desc"))

        }

        params.max = Math.min(max ?: 10, 100)

        def total = Topic.createCriteria().count(query)

        def list = Topic.createCriteria().list(query, offset: params.offset, max: params.max)

        respond list, model:[topicInstanceCount: total]
    }

    def show(Topic topicInstance) {
        def replyList = TopicReply.findAllByTopic(topicInstance)
        respond topicInstance, model: [replyList: replyList]
    }

    def create() {
        respond new Topic(params)
    }

    @Transactional
    def save(Topic topicInstance) {
        if (topicInstance == null) {
            notFound()
            return
        }

        if (topicInstance.hasErrors()) {
            respond topicInstance.errors, view:'create'
            return
        }

        def current_user = (UserInfo)session.getAttribute('user')
        if (!current_user) {
            flash.message = message(code:'topic.message.user.nologin', default:'Errors')
            respond topicInstance, view: 'create'
            return
        }

        topicInstance.create_time = new Date()
        topicInstance.update_time = new Date()
        topicInstance.status = 2
        topicInstance.promoter = User.get(current_user.user_id)

        topicInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
                redirect topicInstance
            }
            '*' { respond topicInstance, [status: CREATED] }
        }
    }

    def edit(Topic topicInstance) {
        respond topicInstance
    }

    @Transactional
    def update(Topic topicInstance) {
        if (topicInstance == null) {
            notFound()
            return
        }
        topicInstance.status = params.status?params.int("status"):topicInstance.status

        if (topicInstance.hasErrors()) {
            respond topicInstance.errors, view:'edit'
            return
        }



        if (topicInstance.status == 4) {

            def current_user = (UserInfo)session.getAttribute('user')


            topicInstance.close_time = new Date()
            topicInstance.closer = User.get(current_user.user_id)
        }

        if (topicInstance.status == 3) {
            topicInstance.auditing_time = new Date()
            topicInstance.auditing_desc = topicInstance.auditing_desc ?: ''
        }

        topicInstance.update_time = new Date()

        topicInstance.save flush:true

        redirect(controller: 'topic',action: 'show',id:topicInstance.id)
        return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Topic.label', default: 'Topic'), topicInstance.id])
                redirect topicInstance
            }
            '*'{ respond topicInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Topic topicInstance) {

        if (topicInstance == null) {
            notFound()
            return
        }

        topicInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Topic.label', default: 'Topic'), topicInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
