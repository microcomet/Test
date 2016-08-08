package smartcommunity

//街道类
class Street {
    String name
    String description
    String code
    String charger
    String charger_mobile
    Date create_time
    Date update_time
    int status

    static constraints = {
        name nullable: false, size: 1..250
        description nullable: false, size: 1..2000
        code nullable: false, size: 1..50
    }
}
