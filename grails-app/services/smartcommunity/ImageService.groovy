package smartcommunity

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class ImageService {

    /*
    *存储图片到文件系统
    * */
    def saveImage(MultipartFile image, String save_path){
        if(image == null){
            return -1
        }

        //生成文件名
        def original_file_name = image.getOriginalFilename()
        def suffix_start = original_file_name.lastIndexOf('.') + 1
        def storage_file_name = UUID.randomUUID().toString() + '.' + original_file_name[suffix_start..-1]

        //创建目录
        def current_user_image_dir = new File(save_path)
        if(!current_user_image_dir.exists()){
            current_user_image_dir.mkdirs()
        }

        //存入文件系统
        File out_image = new File("${current_user_image_dir.absolutePath}/${storage_file_name}")
        out_image.withDataOutputStream {output ->
            output.write(image.getBytes())
        }
        return storage_file_name
    }
}
