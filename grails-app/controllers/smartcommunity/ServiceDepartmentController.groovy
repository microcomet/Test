package smartcommunity

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ServiceDepartmentController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ServiceDepartment.list(params), model:[serviceDepartmentInstanceCount: ServiceDepartment.count()]
    }

    def show(ServiceDepartment serviceDepartmentInstance) {
        respond serviceDepartmentInstance
    }

    def create() {
        respond new ServiceDepartment(params)
    }

    @Transactional
    def save(ServiceDepartment serviceDepartmentInstance) {
        if (serviceDepartmentInstance == null) {
            notFound()
            return
        }

        if (serviceDepartmentInstance.hasErrors()) {
            respond serviceDepartmentInstance.errors, view:'create'
            return
        }

        def now = new Date()
        serviceDepartmentInstance.description = serviceDepartmentInstance.description ?: ''
        serviceDepartmentInstance.address = serviceDepartmentInstance.address ?: ''
        serviceDepartmentInstance.create_time = now
        serviceDepartmentInstance.update_time = now

        serviceDepartmentInstance.save flush:true
        redirect(action: "index")
        return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'serviceDepartment.label', default: 'ServiceDepartment'), serviceDepartmentInstance.id])
                redirect serviceDepartmentInstance
            }
            '*' { respond serviceDepartmentInstance, [status: CREATED] }
        }
    }

    def edit(ServiceDepartment serviceDepartmentInstance) {
        respond serviceDepartmentInstance
    }

    @Transactional
    def update(ServiceDepartment serviceDepartmentInstance) {
        if (serviceDepartmentInstance == null) {
            notFound()
            return
        }

        if (serviceDepartmentInstance.hasErrors()) {
            respond serviceDepartmentInstance.errors, view:'edit'
            return
        }

        serviceDepartmentInstance.update_time = serviceDepartmentInstance.update_time ?: new Date()
        serviceDepartmentInstance.save flush:true
        redirect(action: "index")
        return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ServiceDepartment.label', default: 'ServiceDepartment'), serviceDepartmentInstance.id])
                redirect serviceDepartmentInstance
            }
            '*'{ respond serviceDepartmentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ServiceDepartment serviceDepartmentInstance) {

        if (serviceDepartmentInstance == null) {
            notFound()
            return
        }

        serviceDepartmentInstance.delete flush:true
        redirect(action: "index")
        return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ServiceDepartment.label', default: 'ServiceDepartment'), serviceDepartmentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'serviceDepartment.label', default: 'ServiceDepartment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
