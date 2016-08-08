package smartcommunity

import grails.transaction.Transactional

@Transactional
class TopicService {

    static scope = 'request'
    def serviceMethod() {

    }

    /*
    *获取当前用户所在社区中所有用户发起的话题列表
    * */
    def getTopicListByUser(Long user_id){
        return Topic.findAllByPromoterInList(User.findAllByCommunity(User.findById(user_id).community))
    }

    /*
    *获取社区下话题列表
    * */
    def getTopicByCommunity(Long community_id, Long user_id, Integer page_num, Integer page_size, Integer in_order){
        in_order = in_order ?: 1

        page_size = page_size ?: 10
        page_num = page_num ?: 1

        def query = {
            or {
                and {
                    eq("status", 1)
                    eq("promoter", User.get(user_id))
                }
                eq("status", 2)
            }
            eq("community",Community.get(community_id))
            order("create_time", in_order == 1 ? "desc" : "asc")
        }

        def topicList = Topic.createCriteria().list(query, offset: page_num>1?((page_num-1)*page_size):0, max: page_size)

        return topicList
    }

    /*
    *获取所有话题列表
    * */
    def getAllTopic() {
        return Topic.findAll()
    }

    /*
    *获取话题详情
    * */
    def getTopicDetail(Long topic_id){
        return Topic.findById(topic_id)
    }

    /*
    *获取话题回复
    * */
    def getTopicReply(Long topic_id, Integer page_num, Integer page_size){

        page_size = page_size ?: 10
        page_num = page_num ?: 1

        def query = {
            eq("status", 1)
            eq("topic", Topic.get(topic_id))
            order("create_time", "desc")
        }


        def replyList = TopicReply.createCriteria().list(query, offset: page_num>1?((page_num-1)*page_size):0, max: page_size)

        return replyList
    }

    /*
    *新建话题
    * */
    def createTopic(Long user_id, String title, String content){
        def user = User.findById(user_id)
        if (user == null || title == null || content == null
        || title.trim().size() == 0 || content.trim().size() == 0)
            return [code: 'topic.message.create.params']

        def now = new Date()
        Topic topic = new Topic()
        topic.create_time = now
        topic.update_time = now
        topic.community = user.community
        topic.promoter = user
        topic.status = 1
        topic.title = title
        topic.content = content

        topic.save(flush: true)

        return [code: '200', topicId: topic.id]
    }

    /*
    *话题审核
    * */
    def topicAuditing(Long topic_id, String auditing, Integer auditing_result = 3){
        Topic topic = Topic.findById(topic_id)
        topic.status = auditing_result
        topic.auditing_desc = auditing
        topic.auditing_time = new Date()
        topic.save(flush: true)
    }

    /*
    *话题回复
    * */
    def topicReply(Long user_id, Long topic_id, String content){
        def user = User.findById(user_id)
        def topic = Topic.findById(topic_id)
        if (user == null || topic == null) return [code: 'topic.message.topic_or_user.empty']

        if (topic.community.id != user.community.id) {
            return [code: 'topic.message.community_neq_user']
        }

        TopicReply topicReply = new TopicReply([
                topic: topic,
                publisher: user,
                content: content,
                status: 1,
                create_time: new Date(),
                update_time: new Date()
        ])
        topicReply.save(flush: true)

        return [code: '200', replyId: topicReply.id]
    }

    /*
    *收藏话题
    * */
    def collectTopic(Long user_id, Long topic_id){
        def user = User.get(user_id)
        if (user == null) return [code: 'topic.message.user_or_topic_empty']
        def topic = Topic.get(topic_id)
        if (topic == null) return [code: 'topic.message.user_or_topic_empty']

        def res = UserCollection.findByCollectorAndTopicAndStatus(user, topic, 1);

        if (res != null) return [code: 'topic.message.collection.repeat']

        res = UserCollection.findByCollectorAndTopicAndStatus(user, topic, 2)
        if (res != null) {
            res.status = 1
            res.update_time = new Date()
            res.save(flush: true)
            return [code: '200']
        }

        UserCollection userCollection = new UserCollection([
                collector: user,
                type: 1,
                poll: null,
                topic: topic,
                status: 1,
                create_time: new Date(),
                update_time: new Date()
        ])

        userCollection.save(flush: true)
        return [code: '200']
    }

    /*
    *取消话题收藏
    * */
    def cancelCollectTopic(Long user_id, Long topic_id){
        def user = User.get(user_id)
        if (user == null) return [code: 'topic.message.user_or_topic_empty']
        def topic = Topic.get(topic_id)
        if (topic == null) return [code: 'topic.message.user_or_topic_empty']

        def res = UserCollection.findByCollectorAndTopic(user, topic)
        if (res == null || res.status == 2 || res.collector.id != user_id) return [code: 'collection.cancel.error']

        res.status = 2
        res.save(flush: true)
        return [code: '200']
    }

    /*
    *获取话题收藏
    * */
    def getTopicCollect(Long user_id, Long topic_id, Integer page_num, Integer page_size){
        def user = User.get(user_id)
        if (user == null) return null
        def topic = Topic.get(topic_id)

        def query = {
            eq('collector', user)
            eq('status', 1)
            eq('type', 1)
        }

        if (topic == null) return UserCollection.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)

        return UserCollection.findAllByCollectorAndTopicAndStatus(user, topic, 1)
    }

    /*
    *屏蔽回复
    * */
    def shieldReply(Long reply_id, Long user_id){
        def reply = TopicReply.findById(reply_id)
        reply.status = 2
        reply.cancel_or_shield_person = User.findById(user_id)
        reply.cancel_or_shield_time = new Date()
        reply.save(flush: true)
    }

    /*
    *撤销回复
    * */
    def cancelReply(Long reply_id, Long user_id){
        def reply = TopicReply.findById(reply_id)
        reply.status = 3
        reply.cancel_or_shield_person = User.findById(user_id)
        reply.cancel_or_shield_time = new Date()
        reply.save(flush: true)
    }

}
