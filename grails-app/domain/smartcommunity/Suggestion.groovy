package smartcommunity

import org.springframework.web.multipart.MultipartFile

class Suggestion {

    static transients = ['files', 'image_ids']
    Street street
    Community community
    User publisher
    String title
    String content
    Integer status //[1：处理中 2： 已处理]
    MultipartFile[] files
    List<Long> image_ids
    User closer
    Date close_time
    Date create_time
    Date update_time

    static  mapping = {
        content type: 'text'
    }

    static constraints = {
        title nullable: false, size: 0..500
        content nullable: false
    }
}
