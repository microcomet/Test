package smartcommunity

//话题回复类
class TopicReply {
    Topic topic
    User publisher
    String content
    Integer status //[1：正常 2：屏蔽 3：删除]
    String cancel_or_shield_description
    User cancel_or_shield_person
    Date cancel_or_shield_time
    Date create_time
    Date update_time

    static mapping = {
        content type: 'text'
    }

    static constraints = {
        topic nullable: false
        publisher nullable: false
        content nullable: false
        status nullable: false
    }
}
