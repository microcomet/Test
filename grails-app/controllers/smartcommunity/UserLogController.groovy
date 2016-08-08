package smartcommunity

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserLogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

        def simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd")

        def query = {
            if (params.userId) {
                eq("operator", User.get(Long.valueOf(params.userId)))
            }

            if (params.start_time) {
                ge("operate_time", simpleDateFormat.parse(String.valueOf(params.start_time)))
            }

            if (params.end_time) {
                le("operate_time", simpleDateFormat.parse(String.valueOf(params.end_time)))
            }
        }

        params.max = Math.min(max ?: 10, 100)

        def total = UserLog.createCriteria().count(query)
        def list = UserLog.createCriteria().list (query, offset: params.offset, max: params.max)


        respond list, model:[userLogInstanceCount: total]
    }

    def show(UserLog userLogInstance) {
        respond userLogInstance
    }

    def create() {
        respond new UserLog(params)
    }

    @Transactional
    def save(UserLog userLogInstance) {
        if (userLogInstance == null) {
            notFound()
            return
        }

        if (userLogInstance.hasErrors()) {
            respond userLogInstance.errors, view:'create'
            return
        }

        userLogInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userLog.label', default: 'UserLog'), userLogInstance.id])
                redirect userLogInstance
            }
            '*' { respond userLogInstance, [status: CREATED] }
        }
    }

    def edit(UserLog userLogInstance) {
        respond userLogInstance
    }

    @Transactional
    def update(UserLog userLogInstance) {
        if (userLogInstance == null) {
            notFound()
            return
        }

        if (userLogInstance.hasErrors()) {
            respond userLogInstance.errors, view:'edit'
            return
        }

        userLogInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'UserLog.label', default: 'UserLog'), userLogInstance.id])
                redirect userLogInstance
            }
            '*'{ respond userLogInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(UserLog userLogInstance) {

        if (userLogInstance == null) {
            notFound()
            return
        }

        userLogInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserLog.label', default: 'UserLog'), userLogInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userLog.label', default: 'UserLog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
