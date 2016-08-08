package smartcommunity

//办事部门类
class ServiceDepartment {
    String name
    String description
    Street street
    Community community
    String address
    Date create_time
    Date update_time

    static mapping = {
        description type: 'text'
    }

    static constraints = {
        name nullable: false, size: 0..250
        street nullable: true
    }
}
