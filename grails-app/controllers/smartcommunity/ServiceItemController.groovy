package smartcommunity

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ServiceItemController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ServiceItem.findAllByDepartment(ServiceDepartment.get(params.int("id"))), model:[serviceItemInstanceCount: ServiceItem.countByDepartment(ServiceDepartment.get(params.int("id")))]
    }

    def show(ServiceItem serviceItemInstance) {
        respond serviceItemInstance
    }

    def create() {
        def serviceItemInstance= new ServiceItem(params)
        if(params.did){
            serviceItemInstance.department = ServiceDepartment.get(params.int("did"))
        }

        respond serviceItemInstance
    }

    @Transactional
    def save(ServiceItem serviceItemInstance) {
        if (serviceItemInstance == null) {
            notFound()
            return
        }

        if (serviceItemInstance.hasErrors()) {
            respond serviceItemInstance.errors, view:'create'
            return
        }

        def now = new Date()
        serviceItemInstance.create_time = serviceItemInstance.create_time ?: now
        serviceItemInstance.update_time = serviceItemInstance.update_time ?: now
        serviceItemInstance.detail = serviceItemInstance.detail ?: ''
        serviceItemInstance.status = serviceItemInstance.status ?: 1

        serviceItemInstance.save flush:true
        redirect(action: "index",id:serviceItemInstance.department.id)
        return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'serviceItem.label', default: 'ServiceItem'), serviceItemInstance.id])
                redirect serviceItemInstance
            }
            '*' { respond serviceItemInstance, [status: CREATED] }
        }
    }

    def edit(ServiceItem serviceItemInstance) {
        respond serviceItemInstance
    }

    @Transactional
    def update(ServiceItem serviceItemInstance) {
        if (serviceItemInstance == null) {
            notFound()
            return
        }

        if (serviceItemInstance.hasErrors()) {
            respond serviceItemInstance.errors, view:'edit'
            return
        }

        if(params.status){
            serviceItemInstance.status = params.int("status")
        }

        serviceItemInstance.update_time = serviceItemInstance.update_time ?: new Date()

        serviceItemInstance.save flush:true
        redirect(action: "index",id:serviceItemInstance.department.id)
        return
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ServiceItem.label', default: 'ServiceItem'), serviceItemInstance.id])
                redirect serviceItemInstance
            }
            '*'{ respond serviceItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ServiceItem serviceItemInstance) {

        if (serviceItemInstance == null) {
            notFound()
            return
        }

        serviceItemInstance.delete flush:true
        redirect(action: "index",id:serviceItemInstance.department.id)
        return
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ServiceItem.label', default: 'ServiceItem'), serviceItemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'serviceItem.label', default: 'ServiceItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
