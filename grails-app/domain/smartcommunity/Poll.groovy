package smartcommunity

//民意征询类
class Poll {
    static transients = ['options']

    String title
    String description
    String options
    Street street
    Community community
    User creator
    Integer rule //[1: 单选; 2: 多选]
    Integer max_select_num
    Integer score
    Date start_time
    Date end_time
    Integer status  //[1: 进行中; 2：未开始; 3：已结束;4:关闭]
    Date create_time
    Date update_time

    static mapping = {
        description type: 'text'
    }

    static constraints = {
        title nullable: false, size: 1..250
        rule nullable: false, inList: [1, 2]
        status nullable: true, inList: [1, 2, 3, 4]
        end_time nullable: false
    }
}
