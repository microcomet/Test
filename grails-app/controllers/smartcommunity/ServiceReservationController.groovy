package smartcommunity

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ServiceReservationController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        def serviceItemId = params.serviceItemId
        def reserve_person = params.reserve_person
        def status = params.status

        def query = {
            createAlias("reserve_person", "reserve_person")
            if (serviceItemId) {
                eq("serviceItem.id", serviceItemId)
            }

            if (reserve_person) {
                eq("reserve_person.name", "%" + reserve_person + "%")
            }


            if (status) {
                eq("status", status)
            }

            order("create_time", (params.order == 0 ? "asc" : "desc"))
        }

        params.max = Math.min(max ?: 10, 100)

        def total = ServiceReservation.createCriteria().count(query)

        def list = ServiceReservation.createCriteria().list(query, offset: params.offset, max: params.max)


        respond list, model: [serviceReservationInstanceCount: total]
    }

    def show(ServiceReservation serviceReservationInstance) {
        respond serviceReservationInstance
    }

    def create() {
        respond new ServiceReservation(params)
    }

    @Transactional
    def save(ServiceReservation serviceReservationInstance) {
        if (serviceReservationInstance == null) {
            notFound()
            return
        }

        if (serviceReservationInstance.hasErrors()) {
            respond serviceReservationInstance.errors, view: 'create'
            return
        }

        def current_user = (User) session.getAttribute('user')
        if (!current_user) {
            flash.message = message(code: 'serviceReservation.message.user.nologin', default: 'Errors')
            respond serviceReservationInstance, view: 'create'
            return
        }

        def now = new Date()
        serviceReservationInstance.reserve_person = serviceReservationInstance.reserve_person ?: current_user
//        serviceReservation.serviceItem = ServiceItem.findById(service_id)
        serviceReservationInstance.status = 1
        serviceReservationInstance.create_time = now
        serviceReservationInstance.update_time = now

        serviceReservationInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'serviceReservation.label', default: 'ServiceReservation'), serviceReservationInstance.id])
                redirect serviceReservationInstance
            }
            '*' { respond serviceReservationInstance, [status: CREATED] }
        }
    }

    def edit(ServiceReservation serviceReservationInstance) {
        respond serviceReservationInstance
    }

    @Transactional
    def update(ServiceReservation serviceReservationInstance) {
        if (serviceReservationInstance == null) {
            notFound()
            return
        }

        if (serviceReservationInstance.hasErrors()) {
            respond serviceReservationInstance.errors, view: 'edit'
            return
        }

        serviceReservationInstance.update_time = serviceReservationInstance.update_time ?: new Date()
        serviceReservationInstance.save flush: true
        redirect(controller: "serviceReservation", action: "index")
        return


//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'ServiceReservation.label', default: 'ServiceReservation'), serviceReservationInstance.id])
//                redirect serviceReservationInstance
//            }
//            '*' { respond serviceReservationInstance, [status: OK] }
//        }
    }

    @Transactional
    def delete(ServiceReservation serviceReservationInstance) {

        if (serviceReservationInstance == null) {
            notFound()
            return
        }

        serviceReservationInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ServiceReservation.label', default: 'ServiceReservation'), serviceReservationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'serviceReservation.label', default: 'ServiceReservation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
