package smartcommunity

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ImageController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Image.list(params), model:[imageInstanceCount: Image.count()]
    }

    def show(Image imageInstance) {
        respond imageInstance
    }

    def create() {
        respond new Image(params)
    }

    def getSingleImage(Image imageInstance){
        if (imageInstance == null) return
        FileInputStream inputStream = new FileInputStream(imageInstance.storage_url)
        def bytes = new byte[1024]
        def out = response.getOutputStream()
        def len = inputStream.read(bytes, 0, 1024)
        while(len != -1) {
            out.write(bytes, 0, len)
            len = inputStream.read(bytes, 0, 1024)
        }
        out.flush()
        out.close()
        inputStream.close()
    }

    def save_file(MultipartFile file){
        if(file == null){
            return -1
        }

        Image imageInstance = new Image()

        //生成文件名
        def original_file_name = file.getOriginalFilename()
        def suffix_start = original_file_name.lastIndexOf('.') + 1
        def storage_file_name = UUID.randomUUID().toString() + '.' + original_file_name[suffix_start..-1]

        //获取当前登陆用户
        def current_user = ((User)session.getAttribute('user'))

        if(current_user == null){
            flash.message = message(code:'image.message.user.nologin', defaule:'Errors')
            respond imageInstance, view:'create'
            return -1
        }

        //校验输入文件名
        def exists_image = Image.findAllByNameAndUploader(storage_file_name, current_user)
        if(!exists_image.isEmpty()){
            flash.message = message(code:'image.message.file.name.duplicate', defaule:'Errors')
            respond imageInstance, view:'create'
            return -1
        }

        //创建目录
        def default_image_location = grailsApplication.config.zhsq.default.image.storage.location
        def current_user_image_dir = new File("${default_image_location}${current_user.name}")
        if(!current_user_image_dir.exists()){
            current_user_image_dir.mkdirs()
        }

        //存入文件系统
        File image = new File("${current_user_image_dir.absolutePath}/${storage_file_name}")
        image.withDataOutputStream {output ->
            output.write(file.getBytes())
        }

        //存入数据库
        imageInstance.uploader = current_user
        imageInstance.upload_time = new Date()
        imageInstance.create_time = new Date()
        imageInstance.update_time = new Date()
        imageInstance.status = 1
        imageInstance.storage_url = image.absolutePath
        imageInstance.name = storage_file_name
        imageInstance.save flush:true

        return 0
    }

    @Transactional
    def upload(Image imageInstance) {
        if (imageInstance == null) {
            notFound()
            return
        }

        if (imageInstance.hasErrors()) {
            respond imageInstance.errors, view:'create'
            return
        }
        if(params.myfile == null){
            flash.message = message(code:'image.message.file.empty', default:'Errors')
            respond imageInstance, view:'create'
            return
        }

        if(this.save_file(params.myfile instanceof MultipartFile ? params.myfile : null) != 0)
            return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'image.label', default: 'Image'), imageInstance.id])
                redirect imageInstance
            }
            '*' { respond imageInstance, [status: CREATED] }
        }
    }

    @Transactional
    def uploadMultiImages(Image imageInstance){

        if(params.files.size == 0){
            flash.message = message(code:'image.message.file.empty', default:'Errors')
            respond imageInstance, view:'create'
            return
        }

        if(request instanceof MultipartHttpServletRequest){
            def files = request.getFiles("files")
            files.each {file ->
                this.save_file(file)
            }
        } else {
            flash.message = message(code:'image.message.file.error', default:'Errors')
            respond imageInstance, view:'create'
            return
        }

        imageInstance.id = 2
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'image.label', default: 'Image'), imageInstance.id])
                redirect imageInstance
            }
            '*' { respond imageInstance, [status: CREATED] }
        }
    }

    @Transactional
    def save(Image imageInstance) {
        if (imageInstance == null) {
            notFound()
            return
        }

        if (imageInstance.hasErrors()) {
            respond imageInstance.errors, view:'create'
            return
        }

        imageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'image.label', default: 'Image'), imageInstance.id])
                redirect imageInstance
            }
            '*' { respond imageInstance, [status: CREATED] }
        }
    }

    def edit(Image imageInstance) {
        respond imageInstance
    }

    @Transactional
    def update(Image imageInstance) {
        if (imageInstance == null) {
            notFound()
            return
        }

        if (imageInstance.hasErrors()) {
            respond imageInstance.errors, view:'edit'
            return
        }

        imageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Image.label', default: 'Image'), imageInstance.id])
                redirect imageInstance
            }
            '*'{ respond imageInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Image imageInstance) {

        if (imageInstance == null) {
            notFound()
            return
        }

        imageInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Image.label', default: 'Image'), imageInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'image.label', default: 'Image'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
