import smartcommunity.Role
import smartcommunity.User
import smartcommunity.Score

class BootStrap {

    def timerService

    def init = { servletContext ->

        //初始化角色
        def roleList = [
                new Role([
                        name: '普通用户',
                        role: 2,
                        create_time: new Date(),
                        update_time: new Date()
                ]),

                new Role([
                        name: '社区从业人员',
                        role: 4,
                        create_time: new Date(),
                        update_time: new Date()
                ]),

                new Role([
                        name: '社区管理人员',
                        role: 6,
                        create_time: new Date(),
                        update_time: new Date()
                ]),

                new Role([
                        name: '街道管理人员',
                        role: 8,
                        create_time: new Date(),
                        update_time: new Date()
                ]),

                new Role([
                        name: '超级用户',
                        role: 10,
                        create_time: new Date(),
                        update_time: new Date()
                ])
        ]

        roleList.each {role ->
            if (Role.findByRole(role.role) == null) role.save(flush: true)
        }

        //初始化admin用户
        def user = new User([
                name: 'admin',
                password: 'admin'.encodeAsSHA256Bytes().encodeAsHex(),
                nick_name: 'admin',
                identity_id: '1234567890',
                mobile: '1234567890',
                address: '元气',
                social_security_card_id: '',
                role: Role.findByRole(10),
                head_url: 'http://www.baidu.com',
                status: 2,
                auditing_desc: '审核通过',
                create_time: new Date(),
                update_time: new Date()
        ])
        def admin = User.findByNameAndPassword('admin', 'admin'.encodeAsSHA256Bytes().encodeAsHex())
        if (admin == null) {
            user.save(flush: true)
        }

        //积分配置
        def scoreList = [
            new Score([
                    name: '微心愿',
                    type: 2,
                    score: 100
            ]),

            new Score([
                    name: '民意征询',
                    type: 4,
                    score: 100
            ])
        ]

        scoreList.each {score ->
            if (Score.findByType(score.type) == null) score.save(flush: true)
        }

        //定时器
        timerService.autoOperation()
    }
    def destroy = {
        timerService.close()
    }
}
