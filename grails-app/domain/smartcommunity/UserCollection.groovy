package smartcommunity

class UserCollection {

    User collector
    Integer type
    Poll poll
    Topic topic
    Integer status //[1: 正常 2： 取消]
    Date create_time
    Date update_time

    static constraints = {
        collector nullable: false
        type nullable: false
    }
}
