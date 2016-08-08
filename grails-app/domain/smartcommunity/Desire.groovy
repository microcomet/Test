package smartcommunity

import org.springframework.web.multipart.MultipartFile

//心愿类
class Desire {
    static transients = ['files', 'image_ids']

    Community community

    String title
    String description
    MultipartFile[] files
    List<Long> image_ids
    Integer score
    User requester
    User helper
    String feedback
    Integer status //[1: 发布 2：进行中 3: 请求者确认完成 4：帮助者确认完成 5：已关闭 6:用户自己删除]
    Date create_time
    Date update_time
    Date received_time   //用户领取时间
    Date submit_time     //领取心愿用户提交完成的时间
    Date finish_time     //创建心愿用户确认完成的时间

    static mapping = {
        description type: 'text'
        feedback type: 'text'
    }

    static constraints = {
        title nullable: false, size: 0..500
        description nullable: false
        received_time nullable: true
        submit_time nullable: true
        finish_time nullable: true
    }
}
