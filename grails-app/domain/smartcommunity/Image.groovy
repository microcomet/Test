package smartcommunity

import org.springframework.web.multipart.MultipartFile

//图片类
class Image {
    static transients = ['myfile', 'files']

    String name
    String storage_url
    byte[] myfile
    MultipartFile[] files
    User uploader
    Date upload_time
    Integer status  //[1: 正常 2：非正常]
    Date create_time
    Date update_time

    static constraints = {
        name size: 1..200
        storage_url size: 1..500
    }
}
