package smartcommunity

import grails.transaction.Transactional
import user.UserInfo

class AdminController {

    def index() { }

    //登陆接口
    @Transactional
    def login(User userInstance){

        //存在校验
        def exist_user = User.findByName(userInstance.name)
        if(!exist_user){
            flash.message = message(code: 'user.message.login.error', default: 'Errors')
            redirect(uri: '/')
            return
        }

        //状态校验
        if(exist_user.status != 2){
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
        if(userInstance.password != exist_user.password){
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
        ui.community_id = exist_user.community?exist_user.community.id:null
        ui.community_name = exist_user.community?exist_user.community.name:null
        ui.street_id = exist_user.street?exist_user.street.id:null
        ui.street_name = exist_user.street?exist_user.street.name:null
        ui.role_id = exist_user.role.id
        ui.role_name = exist_user.role.name
        ui.role_role = exist_user.role.role

        session.setAttribute('user', ui)

        //存储用户操作日志
        UserLog userLog = new UserLog([
                operator: exist_user,
                operate: 5,
                table_name: 'user',
                description: "${controllerName}/${actionName}",
                operate_time: new Date(),
                create_time: new Date()
        ])
        userLog.save(flush: true)

        //调转到用户信息展示页面
//        redirect(controller: 'user', action: 'show', params: [id: exist_user.id])
        redirect(controller: 'home', action: 'index', params: [id: exist_user.id])
    }

    //注销接口
    def logout(User userInstance){
        def ui = (UserInfo)session.getAttribute("user")


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
}
