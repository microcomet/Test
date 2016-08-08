package smartcommunity

//话题类
class Topic {
    String title
    String content
    Integer status  //[1: 审核中 2：审核通过 3：审核未通过 4：关闭]
    User promoter
    Community community
    User clerk
    Date auditing_time
    String auditing_desc
    Date close_time
    User closer
    Date create_time
    Date update_time

    static mapping = {
        content type: 'text'
    }

    static constraints = {
        title nullable: false, size: 1..500
        content nullable: false
        auditing_desc size: 1..1000
    }
}
