package smartcommunity

import user.UserInfo

import java.text.NumberFormat
import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PollController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

        def title = params.title
        def rule = params.rule
        def status = params.status?params.int("status"):null

        def query = {
            if (title) {
                like("title", "%" + title + "%")
            }

            if (rule) {
                eq("rule", rule)
            }

            if (status) {
                eq("status", status)
            }

            order("create_time", (params.order == 0 ? "asc" : "desc"))
        }

        params.max = Math.min(max ?: 10, 100)

        def total = Poll.createCriteria().count(query)
        def list = Poll.createCriteria().list (query, offset: params.offset, max: params.max)

        respond list, model: [pollInstanceCount: total]
    }

    def show(Poll pollInstance) {
        def options = PollOption.findAllByPoll(pollInstance)
        if (options == null) {
            flash.message = message(code: 'poll.message.options.empty', default: '投票选项为空')
            respond pollInstance
            return
        }

        def getVoterList = { pollRecordList ->
            def result = []
            for (def x in pollRecordList) {
                result.add(x.voter)
            }
            return result
        }

        def optionList = []
        def pollTotal = PollRecord.countByPoll(pollInstance)
        NumberFormat numberFormat = NumberFormat.getInstance();

        options.each { option ->
            def optionVoteNum = PollRecord.countByPollAndPollOption(pollInstance, option)
            def optionEle = [:]
            optionEle['option'] = option
            optionEle['optionVoteNum'] = optionVoteNum
            String result = pollTotal == 0 ? 0 : numberFormat.format(optionVoteNum / pollTotal * 100);

            optionEle['optionVotePercentage'] = result

            optionEle['recordList'] = PollRecord.findAllByPollAndPollOption(pollInstance, option)
            optionList.add(optionEle)
        }

        respond pollInstance, model: [optionList: optionList, pollTotal: pollTotal]
    }


    def create() {
        respond new Poll(params)
    }

    @Transactional
    def save(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }

        def current_user = (UserInfo) session.getAttribute('user')

        def simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd")

        if (pollInstance.end_time == null) {
            pollInstance.end_time = simpleDateFormat.parse(String.valueOf(params.end_time))
        }

        if (pollInstance.start_time == null) {
            pollInstance.start_time = simpleDateFormat.parse(String.valueOf(params.start_time))
        }

        pollInstance.clearErrors()

        if (pollInstance.end_time.time - pollInstance.start_time.time < 0) {
            flash.message = message(code: 'poll.message.time.seq.error', default: 'Errors')
            respond pollInstance, view: 'create'
            return
        }

        //如果开始时间和结束时间相等，结束时间加24小时
        if (pollInstance.end_time.time - pollInstance.start_time.time == 0) {
            pollInstance.end_time = pollInstance.end_time.plus(1)
        }

        def now = new Date()


        if (now.time > pollInstance.start_time.time && now.time < pollInstance.end_time.time) {
            //进行中
            pollInstance.status = 1
        }

        if (now.time < pollInstance.start_time.time) {
            //未开始
            pollInstance.status = 2
        }

        if (now.time > pollInstance.end_time.time) {
            //已结束
            pollInstance.status = 3
        }

        def user = User.get(current_user.user_id)

        def street = null
        def community = null
        if (user.role.role == 8) {
            street = user.street
        } else if (user.role.role == 6) {
            street = user.street
            community = user.community
        }

        pollInstance.score = pollInstance.score ?: Score.findByType(4)
        pollInstance.street = pollInstance.street ?: street
        pollInstance.community = pollInstance.community ?: community
        pollInstance.creator = User.get(current_user.user_id)
        pollInstance.create_time = new Date()
        pollInstance.update_time = new Date()
        println "=====>" + pollInstance.status
        if (pollInstance.hasErrors()) {
            println pollInstance.errors
            respond pollInstance.errors, view: 'create'
            return
        }
        pollInstance.save flush: true

        if (params.options == null) {
            flash.message = message(code: 'poll.message.options.empty', default: '投票选项为空')
            respond pollInstance, view: 'create'
            return
        }

        def optionList = params.options.split('/')
        optionList.each { option ->
            PollOption pollOption = new PollOption([
                    poll       : pollInstance,
                    option_text: option,
                    option_desc: option,
                    create_time: new Date(),
                    update_time: new Date()
            ])
            println pollOption.errors

            pollOption.save(flush: true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.id])
                redirect pollInstance
            }
            '*' { respond pollInstance, [status: CREATED] }
        }
    }

    def edit(Poll pollInstance) {
        respond pollInstance
    }

    @Transactional
    def update(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }
        println pollInstance.status
        if(params.status){
            pollInstance.status = params.int("status")
        }
        println pollInstance.status

        if (pollInstance.hasErrors()) {
            println pollInstance.errors()
            redirect(controller: 'poll',action: 'index')
            return
        }
        pollInstance.errors.each {e->
            println e
        }

        if(pollInstance.save(flush: true)){
        }else{
            pollInstance.errors.each {e->
                println e
            }
            println "fuck"
        }

        redirect(controller: 'poll',action: 'index')
        return



        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Poll.label', default: 'Poll'), pollInstance.id])
                redirect pollInstance
            }
            '*' { respond pollInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Poll pollInstance) {

        if (pollInstance == null) {
            notFound()
            return
        }

        pollInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Poll.label', default: 'Poll'), pollInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'poll.label', default: 'Poll'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
