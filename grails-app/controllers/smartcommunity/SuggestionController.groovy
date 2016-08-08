package smartcommunity

import user.UserInfo

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SuggestionController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    //获取意见列表
    def indexOpining(Integer max) {

        def name = params.name == null ? null : params.name.trim()
        def streetId = params.streetId?params.int('streetId'):null
        def communityId = params.communityId?params.int('communityId'):null
//        def publisherId = params.publisherId
        def title = params.title
        def status = params.status=="选择状态"?null:params.status

        if (status) status = status.trim().length() == 0 ? null : status

        def query = {
            createAlias("publisher","user")
            if (streetId) {
                eq("street", Street.get(streetId))
            }

            if (communityId) {
                eq("community", Community.get(communityId))
            }

            if (name) {
                like("user.name",  "%" + name + "%")
            }

            if (title) {
                like("title", "%" + title + "%")
            }


            if (status) {
                eq("status", Integer.valueOf(status))
            }

            order("create_time", (params.order == 0 ? "asc" : "desc"))
        }

        params.max = Math.min(max ?: 10, 100)

        def total = Suggestion.createCriteria().count(query)
        def list = Suggestion.createCriteria().list (query, offset: params.offset, max: params.max)

        respond list, model: [suggestCount: total]
    }

    //获取意见详情
    def showOpining(Suggestion suggestion) {

        def imageList = SuggestionImage.findAllBySuggestion(suggestion)

        if (imageList){
            suggestion.image_ids = []

            imageList.each { image ->
                suggestion.image_ids.add(image.image.id)
            }
        }


        respond suggestion
    }

    //关闭意见
    @Transactional
    def closeOpining(Suggestion suggestion) {
        if (suggestion == null) {
            notFound()
            return
        }

        if (suggestion.hasErrors()) {
            respond suggestion.errors, view:'edit'
            return
        }

        def current_user = (UserInfo)session.getAttribute('user')
        if (!current_user) {
            flash.message = message(code:'user.message.no_login', default:'Errors')
            respond suggestion, view: 'indexOpining'
            return
        }

        if (current_user.role_role < 6) {
            flash.message = message(code:'user.message.role.no.permission', default:'Errors')
            respond suggestion, view: 'indexOpining'
            return
        }

        suggestion.closer = User.get(current_user.user_id)
        suggestion.close_time = new Date()
        suggestion.status = 2

        suggestion.save flush:true

//        respond suggestion, view: 'indexOpining'
        redirect(controller: "suggestion", action: "indexOpining")
    }

//
//
//    def index(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        respond Suggestion.list(params), model:[suggestionInstanceCount: Suggestion.count()]
//    }
//
//    def show(Suggestion suggestionInstance) {
//        respond suggestionInstance
//    }
//
//    def create() {
//        respond new Suggestion(params)
//    }
//
//    @Transactional
//    def save(Suggestion suggestionInstance) {
//        if (suggestionInstance == null) {
//            notFound()
//            return
//        }
//
//        if (suggestionInstance.hasErrors()) {
//            respond suggestionInstance.errors, view:'create'
//            return
//        }
//
//        suggestionInstance.save flush:true
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'suggestion.label', default: 'Suggestion'), suggestionInstance.id])
//                redirect suggestionInstance
//            }
//            '*' { respond suggestionInstance, [status: CREATED] }
//        }
//    }
//
//    def edit(Suggestion suggestionInstance) {
//        respond suggestionInstance
//    }
//
//    @Transactional
//    def update(Suggestion suggestionInstance) {
//        if (suggestionInstance == null) {
//            notFound()
//            return
//        }
//
//        if (suggestionInstance.hasErrors()) {
//            respond suggestionInstance.errors, view:'edit'
//            return
//        }
//
//        suggestionInstance.save flush:true
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'Suggestion.label', default: 'Suggestion'), suggestionInstance.id])
//                redirect suggestionInstance
//            }
//            '*'{ respond suggestionInstance, [status: OK] }
//        }
//    }
//
//    @Transactional
//    def delete(Suggestion suggestionInstance) {
//
//        if (suggestionInstance == null) {
//            notFound()
//            return
//        }
//
//        suggestionInstance.delete flush:true
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Suggestion.label', default: 'Suggestion'), suggestionInstance.id])
//                redirect action:"index", method:"GET"
//            }
//            '*'{ render status: NO_CONTENT }
//        }
//    }
//
//    protected void notFound() {
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.not.found.message', args: [message(code: 'suggestion.label', default: 'Suggestion'), params.id])
//                redirect action: "index", method: "GET"
//            }
//            '*'{ render status: NOT_FOUND }
//        }
//    }
}
