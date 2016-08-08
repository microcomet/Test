package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class StreetController {


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Street.list(params), model:[streetInstanceCount: Street.count()]
    }

    def show(Street streetInstance) {
        respond streetInstance
    }

    def create() {
        def street = new Street(params)
        respond street
    }

    @Transactional
    def save(Street streetInstance) {
        if (streetInstance == null) {
            notFound()
            return
        }

        if (streetInstance.hasErrors()) {
            respond streetInstance.errors, view:'create'
            return
        }

        def exist_streets = Street.findAllByName(streetInstance.name)
        if (!exist_streets.empty) {
            flash.message = message(code:'street.message.duplicate.create', default:'Street duplicate create')
            respond streetInstance, view:'create'
            return
        }

        streetInstance.create_time = streetInstance.create_time ?: new Date()
        streetInstance.update_time = streetInstance.update_time ?: new Date()
        streetInstance.charger = streetInstance.charger ?: 1

        if(streetInstance.save(flush:true)){
            redirect(action: "index")
            return
        }else{
            redirect streetInstance
            '*' { respond streetInstance, [status: CREATED] }
            return
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'street.label', default: 'Street'), streetInstance.id])
                redirect streetInstance
            }
            '*' { respond streetInstance, [status: CREATED] }
        }
    }

    def edit(Street streetInstance) {
        respond streetInstance
    }

    @Transactional
    def update(Street streetInstance) {
        if (streetInstance == null) {
            notFound()
            return
        }

        if (streetInstance.hasErrors()) {
            respond streetInstance.errors, view:'edit'
            return
        }

        if(streetInstance.save(flush:true)){
            redirect(controller: 'street',action: 'index')
        }


//
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'street.label', default: 'Street'), streetInstance.id])
//                redirect streetInstance
//            }
//            '*'{ respond streetInstance, [status: OK] }
//        }
    }

    @Transactional
    def delete(Street streetInstance) {

        if (streetInstance == null) {
            notFound()
            return
        }

        streetInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'street.label', default: 'Street'), streetInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'street.label', default: 'Street'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
