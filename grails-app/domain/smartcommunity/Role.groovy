package smartcommunity

//角色类
class Role {
    String name
    Integer role //[2: 社区用户 4： 社区从业人员 6： 社区管理员 8： 街道管理员]
    Date create_time
    Date update_time

    static constraints = {
        name nullable: false, size: 1..50
        role nullable: false
    }
}
