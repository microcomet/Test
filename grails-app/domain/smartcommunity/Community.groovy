package smartcommunity

//社区类
class Community {
    String name
    String description
    String code
    Street street
    String charger
    String charger_mobile
    Date create_time
    Date update_time

    static mapping = {
        description type: 'text'
    }

    static constraints = {
        name nullable: false, size: 1..500
        code nullable: false, size: 1..50
        street nullable: false
        charger nullable: false
        charger_mobile nullable: false
    }
}
