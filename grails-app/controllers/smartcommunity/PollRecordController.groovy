package smartcommunity



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PollRecordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PollRecord.list(params), model:[pollRecordInstanceCount: PollRecord.count()]
    }

    def show(PollRecord pollRecordInstance) {
        respond pollRecordInstance
    }

    def create() {
        respond new PollRecord(params)
    }

    //投票
    def addPollRecord(){
        def input = request.JSON
        def user_id = input['userId']
        def poll_id = input['voteId']
        def pollOption_id = input['selected']
        PollRecord pollRecord = new PollRecord()
        pollRecord.pollOption = PollOption.findById(pollOption_id)
        pollRecord.voter = User.findById(user_id)
        pollRecord.poll = Poll.findById(poll_id)
        pollRecord.score = pollRecord.poll.score
        pollRecord.status = 1
        pollRecord.create_time = new Date()
        pollRecord.update_time = new Date()
        pollRecord.vote_time = new Date()
        pollRecord.save flush:true
    }

    @Transactional
    def save(PollRecord pollRecordInstance) {
        if (pollRecordInstance == null) {
            notFound()
            return
        }

        if (pollRecordInstance.hasErrors()) {
            respond pollRecordInstance.errors, view:'create'
            return
        }

        pollRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pollRecord.label', default: 'PollRecord'), pollRecordInstance.id])
                redirect pollRecordInstance
            }
            '*' { respond pollRecordInstance, [status: CREATED] }
        }
    }

    def edit(PollRecord pollRecordInstance) {
        respond pollRecordInstance
    }

    @Transactional
    def update(PollRecord pollRecordInstance) {
        if (pollRecordInstance == null) {
            notFound()
            return
        }

        if (pollRecordInstance.hasErrors()) {
            respond pollRecordInstance.errors, view:'edit'
            return
        }

        pollRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PollRecord.label', default: 'PollRecord'), pollRecordInstance.id])
                redirect pollRecordInstance
            }
            '*'{ respond pollRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PollRecord pollRecordInstance) {

        if (pollRecordInstance == null) {
            notFound()
            return
        }

        pollRecordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PollRecord.label', default: 'PollRecord'), pollRecordInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pollRecord.label', default: 'PollRecord'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
