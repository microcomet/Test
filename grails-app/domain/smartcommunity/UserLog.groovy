package smartcommunity

//用户日志类
class UserLog {
    User operator
    Integer operate
    String table_name
    String description
    Date operate_time
    Date create_time

    static constraints = {
        table_name size: 0..100
        description size: 0..1000
    }
}
