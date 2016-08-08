package smartcommunity

//用户类
class User {
    String name
    String password
    String nick_name
    String identity_id
    String mobile
    String address
    Community community
    Street street
    String social_security_card_id
    Role role
    String head_url
    Integer potrait_id
    Integer status //[1: 审核中 2：审核通过 3：审核未通过 4：冻结 5：删除]
    String auditing_desc
    Date create_time
    Date update_time

    static constraints = {
        name nullable: false, size: 1..100
        password nullable: false, size: 1..255
        nick_name nullable: false, size: 1..100
        identity_id nullable: false, size: 1..30
        mobile nullable: false, size: 1..20
        address nullable: false, size: 1..500
        social_security_card_id size: 1..30
        head_url size: 1..200
        status inList: [1, 2, 3, 4, 5]
        auditing_desc size: 1..1000, widget: 'textarea'
    }
}
