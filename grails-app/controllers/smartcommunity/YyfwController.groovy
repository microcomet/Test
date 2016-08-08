package smartcommunity


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class YyfwController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

        def reserve_person = params.reserve_person
        def fwmc = params.fwmc
        def status = params.status

        def query = {

            if (status) {
                eq("status", status)
            }
            if (reserve_person) {
                createAlias("reservePerson", "user")
                like("user.name", "%" + reserve_person + "%")
            }

            if (fwmc) {
                like("fwmc", "%" + fwmc + "%")
            }




            order("createTime", "desc")
        }

        params.max = Math.min(max ?: 10, 100)

        def total = Yyfw.createCriteria().count(query)
        def list = Yyfw.createCriteria().list(query, offset: params.offset, max: params.max)

        respond list, model: [yyfwInstanceCount: total]





//
//
//        params.max = Math.min(max ?: 10, 100)
//        respond Yyfw.list(params), model: [yyfwInstanceCount: Yyfw.count()]
    }

    def show(Yyfw yyfwInstance) {
        respond yyfwInstance
    }

    def create() {
        respond new Yyfw(params)
    }

    @Transactional
    def save(Yyfw yyfwInstance) {
        if (yyfwInstance == null) {
            notFound()
            return
        }

        if (yyfwInstance.hasErrors()) {
            respond yyfwInstance.errors, view: 'create'
            return
        }

        yyfwInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'yyfw.label', default: 'Yyfw'), yyfwInstance.id])
                redirect yyfwInstance
            }
            '*' { respond yyfwInstance, [status: CREATED] }
        }
    }

    def edit(Yyfw yyfwInstance) {
        respond yyfwInstance
    }

    @Transactional
    def update(Yyfw yyfwInstance) {
        if (yyfwInstance == null) {
            notFound()
            return
        }

        if (yyfwInstance.hasErrors()) {
            respond yyfwInstance.errors, view: 'edit'
            return
        }

        if(yyfwInstance.save(flush: true)){
            redirect(controller: 'yyfw',action: 'index')
            return
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Yyfw.label', default: 'Yyfw'), yyfwInstance.id])
                redirect yyfwInstance
            }
            '*' { respond yyfwInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Yyfw yyfwInstance) {

        if (yyfwInstance == null) {
            notFound()
            return
        }

        yyfwInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Yyfw.label', default: 'Yyfw'), yyfwInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'yyfw.label', default: 'Yyfw'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
