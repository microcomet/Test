package smartcommunity

import user.UserInfo

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def userFindService

    def index(Integer max, String status, int roleLv) {

        def statusList = []

        if (status) {
            status.split(',').each { ele ->
                statusList.add(Integer.valueOf(ele))
            }
        }

        def name = params.name
        def identity_id = params.identity_id
        def streetId = params.streetId ? params.int('streetId') : null
        def communityId = params.communityId ? params.int('communityId') : null

        def query = {
            createAlias("role", "role")
            if (status) {
                'in'("status", statusList)
            }

            if (roleLv) {
                eq("role.role", roleLv)
            }
            if (name) {
                println "name>" + name
                or {
                    like("name", "%" + name + "%")
                    like("nick_name", "%" + name + "%")
                    like("mobile", "%" + name + "%")
                }
            }
            if (identity_id) {
                eq("identity_id", identity_id)
            }
            if (streetId) {
//                println "communityId>"+communityId != null

                eq("street", Street.get(streetId))
            }
            if (communityId) {
//                println "communityId>"+communityId != null

                eq("community", Community.get(communityId))
            }
            order("create_time", (params.order == 0 ? "asc" : "desc"))
        }

        params.max = Math.min(max ?: 10, 100)

        def total = User.createCriteria().count(query)


        def list = User.createCriteria().list(query, offset: params.offset, max: params.max)

//        render(view: 'index',model: [userInstanceList:list,total: total,status:params.status,roleLv: params.roleLv])
        respond list, model: [total: total, status: params.status, roleLv: params.roleLv]

        return

    }

    def show(User userInstance) {
        respond userInstance
    }

    //登陆接口
    @Transactional
    def login(User userInstance) {

        //存在校验
        def exist_user = User.findByName(userInstance.name)
        if (!exist_user) {
            flash.message = message(code: 'user.message.login.error', default: 'Errors')
            redirect(uri: '/')
            return
        }

        //状态校验
        if (exist_user.status != 2) {
            flash.message = message(code: 'user.message.status.error', default: 'Errors')
            redirect(uri: '/')
            return
        }

        if (exist_user.role.role <= 2) {
            flash.message = message(code: 'user.message.role.no.permission', default: 'Errors')
            redirect(uri: '/')
            return
        }

        //密码校验
        userInstance.password = userInstance.password.encodeAsSHA256Bytes().encodeAsHex()
        if (userInstance.password != exist_user.password) {
            flash.message = message(code: 'user.message.login.error', default: 'Errors')
            respond userInstance, view: '/login2'
            return
        }
//
//        if (exist_user.role.role != 10) {
//            exist_user.community = Community.findById(exist_user.community.id)
//            exist_user.community.street = Street.findById(exist_user.community.street.id)
//        }

        //用户信息保存到会话
        def ui = new UserInfo()
        ui.user_id = exist_user.id
        ui.name = exist_user.name
        ui.nick_name = exist_user.nick_name
        ui.mobile = exist_user.mobile
        ui.community_id = exist_user.community ? exist_user.community.id : null
        ui.community_name = exist_user.community ? exist_user.community.name : null
        ui.street_id = exist_user.street ? exist_user.street.id : null
        ui.street_name = exist_user.street ? exist_user.street.name : null
        ui.role_id = exist_user.role.id
        ui.role_name = exist_user.role.name
        ui.role_role = exist_user.role.role

        session.setAttribute('user', ui)

        //存储用户操作日志
        UserLog userLog = new UserLog([
                operator    : exist_user,
                operate     : 5,
                table_name  : 'user',
                description : "${controllerName}/${actionName}",
                operate_time: new Date(),
                create_time : new Date()
        ])
        userLog.save(flush: true)

        //调转到用户信息展示页面
//        redirect(controller: 'user', action: 'show', params: [id: exist_user.id])
        redirect(controller: 'home', action: 'index', params: [id: exist_user.id])
    }

    //注销接口
    def logout(User userInstance) {
        def ui = (UserInfo) session.getAttribute("user")

        //存储用户操作日志
//        if(ui)
//        {
//            def userLog = new UserLog([
//                    operator    : User.get(ui.user_id),
//                    operate     : 6,
//                    table_name  : 'user',
//                    description : "${controllerName}/${actionName}",
//                    operate_time: new Date(),
//                    create_time : new Date()
//            ])
//            userLog.save(flush: true)
//        }
        session.removeAttribute('user')

        render(view: '/login2')
        return
    }

    def create() {

        respond new User(params)
    }

    //用户注册接口
    def register() {
        respond new User(params)
    }

    //用户审核接口
    def auditing(User userInstance) {
        respond userInstance
    }

    def edit(User userInstance) {
        respond userInstance
    }

    def modifyPassword() {
        return
    }

    @Transactional
    def confirmNewPassword() {
        def oldPwd = params.oldPwd
        def newPwd = params.newPwd

        def ui = (UserInfo) session.getAttribute("user")

        if (oldPwd == null || newPwd == null || ui == null) {
            flash.message = message(code: 'user.pwd.empty', default: '密码为空')
            redirect controller: 'user', action: 'modifyPassword'
            return
        }

        def user = User.get(ui.user_id)
        if (user == null) {
            flash.message = message(code: 'user.not.exist', default: '用户不存在')
            redirect uri: '/'
            return
        }

        if (user.password != oldPwd.encodeAsSHA256Bytes().encodeAsHex()) {
            flash.message = message(code: 'user.message.pwd.error', default: '密码错误')
            redirect controller: 'user', action: 'modifyPassword'
            return
        }

        user.password = newPwd.encodeAsSHA256Bytes().encodeAsHex()
        user.save(flush: true)

        redirect(controller: 'home', action: 'index', params: [id: user.id])
    }

    @Transactional
    def save(User userInstance) {
        println "===>" + params.role.id + "/" + userInstance.role.id
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'create'
            return
        }

        //重名校验
        def exist_user = User.findAllByName(userInstance.name)
        if (!exist_user.empty) {
            flash.message = message(code: 'user.message.duplicate.create', default: 'Error')
            respond userInstance, view: 'create'
            return
        }

//        println userInstance.role.id
        //使用SHA256编码方式编码密码
        userInstance.password = userInstance.password.encodeAsSHA256Bytes().encodeAsHex()
        userInstance.status = userInstance.status ?: 1
        userInstance.auditing_desc = userInstance.auditing_desc ?: ""
        userInstance.create_time = userInstance.create_time ?: new Date()
        userInstance.update_time = userInstance.update_time ?: new Date()
        userInstance.status = 2

        if (userInstance.save(flush: true)) {

            redirect(controller: 'user', action: 'index', params: [roleLv: params.roleLv])
            return
        } else {
            println userInstance.errors
            println "创建失败"
            redirect(controller: 'user', action: 'create', params: [userInstance: userInstance, roleLv: params.roleLv])
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'edit'
            return
        }


        userInstance.update_time = userInstance.update_time ?: new Date()

        println userInstance.errors
        println "---------------------"
        println userInstance.id
        println userInstance.status
        println params.int('status')
        println "---------------------"

        if (params.status) {
            userInstance.status = params.int("status")
        }
        if (userInstance.save(flush: true)) {
            redirect action: 'index', params: [roleLv: userInstance.role.role]

            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.update_time = userInstance.update_time ?: new Date()

        userInstance.status = 5

        if (userInstance.save(flush: true)) {
            redirect action: 'index', params: [roleLv: userInstance.role.role]

            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
