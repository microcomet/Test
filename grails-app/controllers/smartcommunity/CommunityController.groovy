package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommunityController {


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def street = Street.get(Long.valueOf(params.sid == null ? params.id : params.sid))
        def communityList = Community.findAllByStreet(street)
        respond communityList, model:[communityInstanceCount: communityList.size(),street: street]
    }

    def show(Community communityInstance) {
        respond communityInstance
    }

    def create() {
        respond new Community(params),model: [sid:params.sid]
    }

    @Transactional
    def save(Community communityInstance) {
        if (communityInstance == null) {
            notFound()
            return
        }

        if (communityInstance.hasErrors()) {
            respond communityInstance.errors, view:'create'
            return
        }
        def sameCommunity = Community.findAllByNameAndStreet(communityInstance.name, communityInstance.street)
        if (!sameCommunity.empty){
            flash.message = message(code: 'community.message.duplicate.create', default: 'Errors')
            respond communityInstance, view:'create'
            return
        }

        communityInstance.create_time = communityInstance.create_time ?: new Date()
        communityInstance.update_time = communityInstance.update_time ?: new Date()
        communityInstance.charger = communityInstance.charger ?: 1

        if(communityInstance.save(flush:true)){
            redirect(action: 'index',params: [sid:communityInstance.street?.id])
            return
        }else{
            respond communityInstance, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'community.label', default: 'Community'), communityInstance.id])
                redirect communityInstance
            }
            '*' { respond communityInstance, [status: CREATED] }
        }
    }

    def edit(Community communityInstance) {
        respond communityInstance,model: [sid:communityInstance.street.id]
    }

    @Transactional
    def update(Community communityInstance) {
        if (communityInstance == null) {
            notFound()
            return
        }

        if (communityInstance.hasErrors()) {
            respond communityInstance.errors, view:'edit'
            return
        }

        if(communityInstance.save(flush:true)){
            redirect(controller: 'community',action: 'index',id:communityInstance.street.id)
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Community.label', default: 'Community'), communityInstance.id])
                redirect communityInstance
            }
            '*'{ respond communityInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Community communityInstance) {

        if (communityInstance == null) {
            notFound()
            return
        }

        communityInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Community.label', default: 'Community'), communityInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'community.label', default: 'Community'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
