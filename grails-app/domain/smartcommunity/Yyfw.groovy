package smartcommunity

class Yyfw {

    Integer fwId
    Integer fwlxId
    String fwmc
    String lxmc

    User reservePerson
    User checkPerson
    Date orderTime
    Date serverTime
    String serverDesc
    String timeSlot   //时间段
    String status //[1: 等待确认 2：通过 3：不通过]
    Date createTime
    Date updateTime

    static constraints = {
        fwId(nullable: true)
        fwlxId(nullable: true)
        fwmc(nullable: true)
        lxmc(nullable: true)
        reservePerson(nullable: true)
        checkPerson(nullable: true)
        orderTime(nullable: true)
        serverTime(nullable: true)
        serverDesc(nullable: true)
        status(nullable: true)
        createTime(nullable: true)
        updateTime(nullable: true)

    }
}
