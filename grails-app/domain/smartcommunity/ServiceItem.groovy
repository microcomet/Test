package smartcommunity

//办事项目类
class ServiceItem {
    String name
    String detail
    Integer status //[1: 正常 2：停止]
    ServiceDepartment department
    Date create_time
    Date update_time

    static mapping = {
        detail type: 'text'
    }

    static constraints = {
        name nullable: false, size: 0..500
        detail nullable: false,size:0..5000
        department nullable: false
    }
}
