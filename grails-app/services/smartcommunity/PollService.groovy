package smartcommunity

import grails.transaction.Transactional

@Transactional
class PollService {

    static scope = 'request'

    /*
    *获取投票列表
    * */
    def getVoteList(Long user_id, Integer page_num, Integer page_size){
        def user = User.get(user_id)
        if (user == null) return null

        page_size = page_size ?: 10
        page_num = page_num ?: 1

//        def pollQuery = Poll.createCriteria()
        def query = {
            or {
                eq('community', user.community)
                eq('street', user.community.street)
            }
            eq('status', 1)
            order('create_time', 'asc')
        }
        println Poll.createCriteria().count(query)
        return Poll.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1)*page_size) : 0, max: page_size)
    }

    /*
    *创建投票
    * */
    def createVote(Poll poll, List<PollOption> optionList){
        def now = new Date()
        poll.max_select_num = 0
        poll.create_time = now
        poll.update_time = now
        poll.status = poll.start_time <= now ? 1 : 2
        poll.start_time = poll.start_time ?: new Date()
        poll.save flush:true

        optionList.each {option ->
            option.id = poll.id
            option.create_time = now
            option.update_time = now
            option.save flush: true
        }
    }

    /*
    *投票
    * */
    def voting(Long user_id, Long vote_id, String selected){
        println(selected)

        if (user_id == null || vote_id == null || selected == null) return [code: 'poll.message.user_or_poll.empty']
        def now = new Date()
        def user = User.findById(user_id)
        def vote = Poll.findById(vote_id)
        if (user == null || vote == null) return [code: 'poll.message.user_or_poll.empty']

        def pollRecordList = PollRecord.findAllByVoterAndPoll(user, vote)
        if (pollRecordList.size() > 0) return [code: 'poll.message.vote.repeat']

        def selectList = selected.split('&')
        if (selectList.length > 1 && vote.rule == 1) return [code: 'poll.message.vote.params.error']

        if (selectList.length > vote.max_select_num && vote.rule == 2) return [code: 'poll.message.vote.selected.more']

        selectList.each { select ->
            def option = PollOption.findById(select)
            if (option != null) {
                PollRecord pollRecord = new PollRecord([
                        poll: vote,
                        voter: user,
                        vote_time: now,
                        pollOption: option,
                        score: vote.score,
                        status: 1,
                        create_time: now,
                        update_time: now
                ])

                pollRecord.save(flush: true)
            }
        }
        return [code: '200']
    }

    /*
    *获取投票记录服务
    * */
    def voteDetail(Long poll_id){
        return PollRecord.findAllByPoll(Poll.findById(poll_id))
    }

    /*
    *投票统计
    * */
    def voteStatistics(Long poll_id){
        //查询有效投票记录总数
        def count = PollRecord.countByPollAndStatus(Poll.findById(poll_id), 1)
        return count
    }

    /*
    *收藏投票
    * */
    def collectVote(Long user_id, Long vote_id){
        def user = User.get(user_id)
        if (user == null) return [code: 'poll.message.user_or_poll.empty']
        def vote = Poll.get(vote_id)
        if (vote == null) return [code: 'poll.message.user_or_poll.empty']

        def res = UserCollection.findByCollectorAndPollAndStatus(user, vote, 1);

        if (res != null) return [code: 'topic.message.collection.repeat']

        res = UserCollection.findByCollectorAndPollAndStatus(user, vote, 2)
        if (res != null) {
            res.status = 1
            res.update_time = new Date()
            res.save(flush: true)
            return [code: '200']
        }

        UserCollection userCollection = new UserCollection([
                collector: user,
                type: 2,
                poll: vote,
                topic: null,
                status: 1,
                create_time: new Date(),
                update_time: new Date()
        ])

        userCollection.save(flush: true)
        return [code: '200']
    }

    /*
    *取消投票收藏
    * */
    def cancelCollectVote(Long user_id, Long vote_id){
        def user = User.get(user_id)
        if (user == null) return [code: 'poll.message.user_or_poll.empty']
        def vote = Poll.get(vote_id)
        if (vote == null) return [code: 'poll.message.user_or_poll.empty']

        def res = UserCollection.findAllByCollectorAndPoll(user, vote)
        res.each {collection ->
            collection.status = 2
            collection.save(flush: true)
        }
        return [code: '200']
    }

    /*
    *获取话题收藏
    * */
    def getVoteCollect(Long user_id, Long vote_id, Integer page_num, Integer page_size){

        def res = null
        def user = User.get(user_id)
        if (user == null) return null
        def vote = Poll.get(vote_id)
        def ret = []

        def query = {
            eq('collector', user)
            eq('status', 1)
            eq('type', 2)
        }

        if (vote == null) {
            res = UserCollection.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)
        }
        else {
            res = UserCollection.findAllByCollectorAndPollAndStatus(user, vote, 1)
        }

        res.each { collection ->
            def optionList = PollOption.findAllByPoll(collection.poll)

            def recordList = PollRecord.createCriteria().list {
                eq('poll', collection.poll)
                projections {
                    distinct(['voter', 'poll'])
                }
            }

            def ele = [
                    vote: collection.poll,
                    voteUserCount: recordList.size(),
                    options: optionList
            ]
            ret.add(ele)
        }

        return ret

    }
}
