package smartcommunity

import grails.converters.JSON
import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartHttpServletRequest

import java.text.SimpleDateFormat

@Transactional(readOnly = true)
class AppController {

    def userService
    def communityService
    def desireService
    def pollService
    def topicService

    /*
    *User用户管理
    * */
    /*
    *APP获取个人信息
    * */

    def getUserMsg() {
        def userDetail = userService.getUserDetail(Long.valueOf(params.userId))
        if (userDetail != null) {
            def sum = 0;
            def recordList = []
            def score = PollRecord.findAllByVoter(userDetail).sum { pollRecord ->
                if (pollRecord.status != 1) {
                    return 0
                }
                def flag = 0
                recordList.each { record ->
                    if (pollRecord.poll.id == record.poll.id && pollRecord.voter.id == record.voter.id) {
                        flag = 1
                    }
                }

                if (flag) {
                    return 0
                }

                recordList.add(pollRecord)
                return pollRecord.score
            }

            sum += (score == null ? 0 : score)

            score = Desire.findAllByHelperAndStatus(userDetail, 5).sum { desire ->
                return (desire.score == null ? 0 : desire.score)
            }

            sum += (score == null ? 0 : score)

            render(contentType: 'application/json') {
                code = 200
                message = message(code: 'user.message.get.success', default: '用户信息获取成功')
                result = [
                        user: [
                                userId          : userDetail.id,
                                userName        : userDetail.name,
                                userHeadPortrait: userDetail.potrait_id ? userDetail.potrait_id : null,
                                userScore       : sum,
                                passState       : userDetail.status,
                                userPhone       : userDetail.mobile,
                                street          : [
                                        streetId  : userDetail.community ? userDetail.community.street.id : null,
                                        streetName: userDetail.community ? userDetail.community.street.name : null
                                ],
                                address         : userDetail.address,
                                identity_id     : userDetail.identity_id,
                                community       : [
                                        communityId  : userDetail.community ? userDetail.community.id : null,
                                        communityName: userDetail.community ? userDetail.community.name : null,
                                        streetId     : userDetail.community ? userDetail.community.street.id : null
                                ]
                        ]
                ]
            }
            return
        }

        render(contentType: 'application/json') {
            code = 404
            message = message(code: 'user.not.exist', default: '用户不存在')
        }
    }

    /*
    *APP验证用户
    * */

    def verifyUser() {

        def ret = userService.verifyUser(String.valueOf(params.userPhone), String.valueOf(params.userPsw))

        if (ret['code'] == '200') {
            render(contentType: 'application/json') {
                code = 200
                message = message(code: 'user.verify.success', default: '验证成功')
            }
            return
        }
        render(contentType: 'application/json') {
            code = 404
            message = message(code: ret['code'], default: '验证失败')
        }
    }

    /*
    *APP修改手机号
    * */

    @Transactional
    def modifyUserPhone() {

        def res = userService.modifyPhone(
                String.valueOf(params.userPhone),
                String.valueOf(params.userPsw),
                String.valueOf(params.userNewPhone))
        def ret = [:]

        ret['code'] = res['code']
        ret['message'] = message(code: res['message'], default: (ret['code'] == '200' ? '修改手机号成功' : '修改手机号失败'))

        render ret as JSON
    }

    /*
    *APP修改用户街道社区
    * */

    @Transactional
    def modifyUserAddress() {

        def res = userService.modifyAddress(Long.valueOf(params.userId), Long.valueOf(params.communityId))

        def ret = [:]
        ret['code'] = res['code']
        ret['message'] = message(code: res['message'], default: (ret['code'] == '200' ? '修改地址成功' : '修改地址失败'))

        render ret as JSON
    }

    /*
    *APP用户注册接口
    * */

    @Transactional
    def userRegister() {
        def street = Street.findById(params.int('streetId'))
        def community = Community.findById(params.int('communityId'))
        User user = new User([
                name       : params.userName,
                password   : params.userPsw.encodeAsSHA256Bytes().encodeAsHex(),
                nick_name  : params.userName,
                identity_id: params.userIdCard,
                mobile     : params.userPhone,
                address    : "${street.name} ${community.name}",
                community  : community,
                role       : Role.findByRole(params.role ?: 2),
                create_time: new Date(),
                update_time: new Date()
        ])

        def ret = [:]

        def res = userService.userRegister(user, String.valueOf(params.captcha))

        ret['code'] = res['code']
        ret['message'] = message(code: res['message'], default: '注册失败')

        render ret as JSON
    }

    /*
    *APP端用户登陆
    * */

    @Transactional
    def userLogin() {

        //存在校验
        def exist_user = User.findByMobile(String.valueOf(params.userPhone))
        if (!exist_user) {
            flash.message = message(code: 'user.message.login.error', default: 'Errors')
            render(contentType: 'application/json') {
                code = 404
                message = flash.message
            }
            return
        }

//        //状态校验
//        if(exist_user.status != 2){
//            render(contentType: 'application/json') {
//                code = 404
//                message = message(code: { status ->
//                    if (status == 3) return 'user.message.status.auditing.error'
//                    if (status == 4) return 'user.message.status.forbidden'
//                    if (status == 5) return 'user.message.status.delete'
//                    return 'user.message.status.error'
//                } (exist_user.status), default: '用户状态异常')
//            }
//            return
//        }

        //角色校验
        if (exist_user.role.role != 2) {
            flash.message = message(code: 'user.message.role.error', default: 'Errors')
            redirect(uri: '/')
            render(contentType: 'application/json') {
                code = 404
                message = flash.message
            }
            return
        }

        //密码校验
        if (params.userPsw.encodeAsSHA256Bytes().encodeAsHex() != exist_user.password) {
            flash.message = message(code: 'user.message.login.error', default: 'Errors')
//            respond exist_user, view: '/login'
            render(contentType: 'application/json') {
                code = 404
                message = flash.message
            }
            return
        }

        //用户信息保存到会话
        session.setAttribute('user', exist_user)

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
        exist_user.community = Community.findById(exist_user.community.id)
        exist_user.community.street = Street.findById(exist_user.community.street.id)
        render(contentType: 'application/json') {
            code = 200
            message = 'success'
            result = [
                    user: [
                            userId          : exist_user.id,
                            userName        : exist_user.name,
                            userPhone       : exist_user.mobile,
                            userHeadPortrait: exist_user.potrait_id ? exist_user.potrait_id : null,
                            address         : exist_user.address,
                            identity_id     : exist_user.identity_id,
                            street          : [
                                    streetId  : exist_user.community ? exist_user.community.street.id : null,
                                    streetName: exist_user.community ? exist_user.community.street.name : null
                            ],
                            community       : [communityId    : exist_user.community.id,
                                               communityName  : exist_user.community.name,
                                               communityDes   : exist_user.community.description,
                                               communityCharge: exist_user.community.charger]

                    ]
            ]
        }

    }

    /*
    *APP获取短信验证码
    * */

    def getSMSCode() {

        render(contentType: 'application/json') {
            code = 200
            message = 'success'
            smscode = userService.generateSMSCode(String.valueOf(params.userPhone))
        }
    }

    /*
    *APP验证短信验证码
    * */

    def verifySMSCode() {

        if (userService.verifySmsCode(String.valueOf(params.userPhone), String.valueOf(params.smsCode))) {
            render(contentType: 'application/json') {
                code = 200
                message = 'success'
            }
            return
        }
        render(contentType: 'application/json') {
            code = 200
            message = 'failed'
        }
    }

    /*
    *APP修改密码
    * */

    @Transactional
    def modifyUserPsw() {
        def res = userService.modifyPassword(String.valueOf(params.userPhone),
                String.valueOf(params.userCurrentPsw), String.valueOf(params.userNewPsw))

        def ret = [:]

        if (res['code'] == '200') {
            ret['code'] = 200
            ret['message'] = message(code: 'user.modify.success', default: '修改成功')
            render ret as JSON
        }

        ret['code'] = 404
        ret['message'] = message(code: res['code'], default: '用户不存在')
        render ret as JSON
    }

    /*
    *APP修改用户头像
    * */

    @Transactional
    def modifyUserHeadPotrait() {
        def ret = [:]

        if (params.userHeadPortrait != null && request instanceof MultipartHttpServletRequest) {
            def default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            def image = request.getFile("userHeadPortrait")
            def res = userService.modifyUserPicture(Long.valueOf(params.userId), image, default_image_location)

            if (res['code'] != '200') {
                ret['code'] = 500
                ret['message'] = message(code: res['code'], default: '上传头像失败')
                render ret as JSON
                return
            }

            ret['code'] = 200
            ret['message'] = message(code: 'user.potrait.modify.success', default: '头像修改成功')
            ret['result'] = [userHeadPortrait: res['imageId']]
            render ret as JSON
            return
        }

        ret['code'] = 404
        ret['message'] = message(code: 'user.params.error', default: '参数错误')
        render ret as JSON
    }

    /*
    *Announcement公告管理
    * */

    /*
    *APP获取社区公告列表
    * */

    def getCommunityNoticesList() {

        def noticeList = (List<Announcement>) communityService.getNoticeList(
                params.long('communityId'),
                params.int('page_num') ? params.int('page_num') : 1,
                params.int('page_size') ? params.int('page_size') : 10,
                params.int('order')
        )

        if (noticeList) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            def ret = [:]
            ret['code'] = (noticeList != null) ? 200 : 404
            ret['message'] = (noticeList != null) ?
                    message(code: 'announcement.notice.get.success', default: '获取成功') :
                    message(code: 'announcement.notice.empty', default: '公告列表为空')
            ret['result'] = []

            noticeList.each { notice ->
                def image = AnnouncementImage.findByAnnouncement(notice)
                def str = [:]
                str['NoticesId'] = notice.id
                str['NoticesTitle'] = notice.title
                def idx = notice.content.length() < 20 ? notice.content.length() : 20

                str['ContentItems'] = [:]
                str['ContentItems']['Content'] = notice.content
                str['ContentItems']['Image'] = image ? image.image.id : ''

                str['Date'] = format.format(notice.create_time)

                ret['result'] = ret['result'] + str
            }

            render ret as JSON
            return
        }
        render(contentType: 'application/json') {
            code = 404
            message = message(code: 'announcement.notice.empty', default: '公告列表为空')
        }
    }

    /*
    *APP根据公告ID获取公告具体详情
    * */

    def getCommunityNoticeById() {

        def ret = [:]
        def res = communityService.getNoticeDetail(params.int('noticeId'))

        if (res == null || res['announcement'] == null) {
            ret['code'] = 404
            ret['message'] = message(code: 'announcement.notice.get.notExist', default: '该公告不存在')
            render ret as JSON
            return
        }

        ret['code'] = 200
        ret['message'] = message(code: 'announcement.notice.get.success', default: '获取成功')
        def notice = [:]
        notice['NoticesId'] = res['announcement'].id
        notice['NoticesTitle'] = res['announcement'].title

        notice['Date'] = res['announcement'].create_time.format('yyyy-MM-dd HH:mm:ss')

        notice['ContentItems'] = [:]
        notice['ContentItems']['Content'] = res['announcement'].content
        notice['ContentItems']['Image'] = res['images'].join(',')

        ret['result'] = notice

        render ret as JSON
    }

    /*
    *Desire微心愿管理
    * */
    /*
    *APP获取用户所在社区的全部微心愿
    * */

    def getTinyWishListByUserId() {

        def res = desireService.getTinyWishListByUserId(
                Long.valueOf(params.userId),
                params.page_num ? Integer.valueOf(params.page_num) : 1,
                params.page_size ? Integer.valueOf(params.page_size) : 10
        )
        def ret = [:]
        ret['code'] = (res != null) ? 200 : 404
        ret['message'] = (res != null) ?
                message(code: 'desire.get.success', default: '获取成功') :
                message(code: 'desire.empty', default: '没有相关微心愿')

        if (res == null) {
            render ret as JSON
            return
        }

        ret['result'] = []
        res.each { wish ->
            def oneWish = [:]
            oneWish['tinyWishId'] = wish.id
            oneWish['tinyWishContent'] = wish.description
            oneWish['createTime'] = wish.create_time.format('yyyy-MM-dd H:m:s')
            oneWish['receivedTime'] = wish.received_time ? wish.received_time.format('yyyy-MM-dd HH:mm:ss') : null
            oneWish['submitTime'] = wish.submit_time ? wish.submit_time.format('yyyy-MM-dd HH:mm:ss') : null
            oneWish['finishTime'] = wish.finish_time ? wish.finish_time.format('yyyy-MM-dd HH:mm:ss') : null
            oneWish['createUser'] = [:]
            oneWish['createUser']['userId'] = wish.requester.id
            oneWish['createUser']['userName'] = wish.requester.name
            oneWish['createUser']['userHeadPortrait'] = wish.requester.potrait_id ? wish.requester.potrait_id : null
            oneWish['tinyWishPicture'] = desireService.getWishImageList(wish.id).join(',')

            if (wish.helper) {
                oneWish['receivedUser'] = [:]
                oneWish['receivedUser']['userId'] = wish.helper.id
                oneWish['receivedUser']['userName'] = wish.helper.name
                oneWish['receivedUser']['userHeadPortrait'] = wish.helper.potrait_id ? wish.helper.potrait_id : null
            }

            ret['result'] += oneWish
        }

        render ret as JSON
    }

    /*
    *APP获取自己创建的微心愿列表
    * */

    def getMySelfTinyWishListByUserId() {

        def res = desireService.getMySelfTinyWish(
                Long.valueOf(params.userId),
                params.page_num ? Integer.valueOf(params.page_num) : 1,
                params.page_size ? Integer.valueOf(params.page_size) : 10
        )

        if (res['code'] != '200') {
            render(contentType: 'application/json') {
                code = 404
                message = message(code: res['code'], default: '获取失败')
            }
            return
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


        def ret = [:]
        ret['code'] = (res['wishList'] != null || res['wishList'].size()) ? 200 : 404
        ret['message'] = (res['wishList'] != null || res['wishList'].size() > 0) ?
                message(code: 'desire.get.success', default: '获取成功') :
                message(code: 'desire.empty', default: '没有相关微心愿')
        ret['result'] = []
        res['wishList'].each { wish ->
            def oneWish = [:]
            oneWish['tinyWishId'] = wish.id
            oneWish['tinyWishContent'] = wish.description
            oneWish['createTime'] = format.format(wish.create_time)
            oneWish['receivedTime'] = wish.received_time ? format.format(wish.received_time) : null
            oneWish['submitTime'] = wish.submit_time ? format.format(wish.submit_time) : null
            oneWish['finishTime'] = wish.finish_time ? format.format(wish.finish_time) : null
            oneWish['tinyWishPicture'] = desireService.getWishImageList(wish.id).join(',')
            ret['result'] += oneWish
        }

        render ret as JSON
        return
    }

    /*
    *APP获取自己领取的微心愿列表
    * */

    def getReceivedTinyWishListByUserId() {

        def user = User.findById(Long.valueOf(params.userId))

        def res = desireService.getReceivedTinyWish(
                Long.valueOf(params.userId),
                params.page_num ? Integer.valueOf(params.page_num) : 1,
                params.page_size ? Integer.valueOf(params.page_size) : 10
        )

        if (res == null || user == null) {
            render(contentType: 'application/json') {
                code = 404
                message = message(code: 'desire.receive.user_or_desire.empty', default: '获取失败')
            }
            return
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

        def ret = [:]
        ret['code'] = (res != null) ? 200 : 404
        ret['message'] = (res != null) ?
                message(code: 'desire.get.success', default: '获取成功') :
                message(code: 'desire.empty', default: '获取失败')
        ret['result'] = []
        res.each { wish ->
            def oneWish = [:]
            oneWish['tinyWishId'] = wish.id
            oneWish['tinyWishContent'] = wish.description
            oneWish['createTime'] = format.format(wish.create_time)
            oneWish['receivedTime'] = wish.received_time ? format.format(wish.received_time) : null
            oneWish['submitTime'] = wish.submit_time ? format.format(wish.submit_time) : null
            oneWish['finishTime'] = wish.finish_time ? format.format(wish.finish_time) : null
            oneWish['createUser'] = [:]
            oneWish['createUser']['userId'] = wish.requester.id
            oneWish['createUser']['userName'] = wish.requester.name
            oneWish['createUser']['userHeadPortrait'] = wish.requester.potrait_id ? wish.requester.potrait_id : null
            oneWish['tinyWishPicture'] = desireService.getWishImageList(wish.id).join(',')
            ret['result'] += oneWish

        }

        render ret as JSON
        return
    }

    /*
    *APP新建微心愿
    * */

    @Transactional
    def createTinyWish() {

        def default_image_location = null
        def images = null

        if (params.tinyWishPicture != null && request instanceof MultipartHttpServletRequest) {
            default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            images = request.getFiles("tinyWishPicture")
        }

        def res = desireService.createTinyWish(Long.valueOf(params.userId),
                String.valueOf(params.content), images, default_image_location)

        render(contentType: 'application/json') {
            code = ((res['code'] == '200') ? 200 : 404)
            message = ((res['code'] == '200')) ?
                    message(code: 'desire.create.success', default: '心愿创建成功') :
                    message(code: res['code'], default: '心愿创建失败')
        }
    }

    /*
    *APP领取微心愿
    * */

    @Transactional
    def receiveTinyWish() {

        def res = desireService.receiveTinyWish(Long.valueOf(params.userId),
                Long.valueOf(params.tinyWishId))

        render(contentType: 'application/json') {
            code = ((res['code'] == '200') ? 200 : 404)
            message = ((res['code'] == '200')) ?
                    message(code: 'desire.receive.success', default: '领取成功') :
                    message(code: res['code'], default: '领取失败')
        }
    }

    /*
    *APP删除微心愿
    * */

    @Transactional
    def deleteTinyWishByUserId() {

        def res = desireService.deleteTinyWish(Long.valueOf(params.userId), Long.valueOf(params.tinyWishId))

        render(contentType: 'application/json') {
            code = ((res['code'] == '200') ? 200 : 404)
            message = ((res['code'] == '200')) ?
                    message(code: 'desire.delete.success', default: '删除成功') :
                    message(code: res['code'], default: '删除失败')
        }

    }

    /*
    *APP撤销领取的微心愿
    * */

    @Transactional
    def revokeTinyWish() {

        def res = desireService.cancelTinyWish(Long.valueOf(params.userId), Long.valueOf(params.tinyWishId))

        render(contentType: 'application/json') {
            code = (res['code'] == '200') ? 200 : 404
            message = (res['code'] == '200') ?
                    message(code: 'desire.revoke.success', default: '撤销成功') :
                    message(code: res['code'], default: '撤销失败')
        }
    }

    /*
    *APP微心愿修改
    * */

    @Transactional
    def changeTinyWishByUserId() {

        def default_image_location = null
        def images = null

        if (params.tinyWishPicture != null && request instanceof MultipartHttpServletRequest) {
            default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            images = request.getFiles("tinyWishPicture")
        }

        def res = desireService.modifyTinyWish(Long.valueOf(params.userId),
                Long.valueOf(params.tinyWishId), String.valueOf(params.content), images, default_image_location)

        render(contentType: 'application/json') {
            code = (res['code'] == '200') ? 200 : 404
            message = (res['code'] == '200') ?
                    message(code: 'desire.modify.success', default: '修改成功') :
                    message(code: res['code'], default: '修改失败')
        }
    }

    /*
    *APP请求者确认微心愿完成
    * */

    @Transactional
    def confirmTinyWishFinished() {

        def res = desireService.confirmWishByRequester(Long.valueOf(params.userId), Long.valueOf(params.tinyWishId))

        render(contentType: 'application/json') {
            code = (res['code'] == '200') ? 200 : 404
            message = (res['code'] == '200') ?
                    message(code: 'desire.confirm.success', default: '确认成功') :
                    message(code: res['code'], default: '确认失败')
        }

    }

    /*
    *APP帮助者确认微心愿完成
    * */

    @Transactional
    def tinyWishFinished() {

        def res = desireService.confirmWishByHelper(Long.valueOf(params.userId), Long.valueOf(params.tinyWishId))

        render(contentType: 'application/json') {
            code = (res['code'] == '200') ? 200 : 404
            message = (res['code'] == '200') ?
                    message(code: 'desire.confirm.success', default: '确认成功') :
                    message(code: res['code'], default: '确认失败')
        }
    }

    /*
    *APP用户对自己认领的心愿进行反馈
    * */

    @Transactional
    def tinyWishFeedback() {
        def res = desireService.tinyWishFeedback(Long.valueOf(params.userId),
                Long.valueOf(params.tinyWishId), String.valueOf(params.feedbackContent))

        render(contentType: 'application/json') {
            code = (res['code'] == '200') ? 200 : 404
            message = (res['code'] == '200') ?
                    message(code: 'desire.feedback.success', default: '反馈成功') :
                    message(code: res['code'], default: '反馈失败')
        }
    }

    /*
    *APP获取心愿详情
    * */

    def getTinyWishDetail() {
        def res = desireService.getTinyWishDetail(Long.valueOf(params.tinyWishId),
                Long.valueOf(params.userId),
                params.page_num ? Integer.valueOf(params.page_num) : 1,
                params.page_size ? Integer.valueOf(params.page_size) : 10)

        def ret = [:]
        ret['code'] = res['code']
        ret['message'] = message(code: res['message'], default: (res['code'] == '200' ? '获取成功' : '获取失败'))

        if (res['code'] == '200') {

            def wish = [:]
            wish['tinyWishId'] = res['tinyWish'].id
            wish['tinyWishContent'] = res['tinyWish'].description
            wish['createTime'] = res['tinyWish'].create_time.format('yyyy-MM-dd H:m:s')
            wish['receivedTime'] = res['tinyWish'].received_time ? res['tinyWish'].received_time.format('yyyy-MM-dd HH:mm:ss') : null
            wish['submitTime'] = res['tinyWish'].submit_time ? res['tinyWish'].submit_time.format('yyyy-MM-dd HH:mm:ss') : null
            wish['finishTime'] = res['tinyWish'].finish_time ? res['tinyWish'].finish_time.format('yyyy-MM-dd HH:mm:ss') : null
            wish['createUser'] = [:]
            wish['createUser']['userId'] = res['tinyWish'].requester.id
            wish['createUser']['userName'] = res['tinyWish'].requester.name
            wish['createUser']['userHeadPortrait'] = res['tinyWish'].requester.potrait_id ? res['tinyWish'].requester.potrait_id : null
            wish['tinyWishPicture'] = desireService.getWishImageList(res['tinyWish'].id).join(',')

            if (res['tinyWish'].helper) {
                wish['receivedUser'] = [:]
                wish['receivedUser']['userId'] = res['tinyWish'].helper.id
                wish['receivedUser']['userName'] = res['tinyWish'].helper.name
                wish['receivedUser']['userHeadPortrait'] = res['tinyWish'].helper.potrait_id ? res['tinyWish'].helper.potrait_id : null
            }

            def feedbackList = []
            res['feedbackList'].each { ele ->
                def feedback = [:]
                feedback['feedbackTime'] = ele['feedTime'].format('yyyy-MM-dd H:m:s')
                feedback['feedbackContent'] = ele['feedContent']
                feedback['feedbackUser'] = [:]
                feedback['feedbackUser']['userId'] = ele['feeder'].id
                feedback['feedbackUser']['userName'] = ele['feeder'].name
                feedback['feedbackUser']['userHeadPortrait'] = ele['feeder'].potrait_id ? ele['feeder'].potrait_id : null

                feedbackList.add(feedback)
            }

            wish['feedbackList'] = feedbackList

            ret['result'] = wish

        }

        render ret as JSON

    }

    /*
    *民意征询
    * */
    /*
    *APP获取投票列表
    * */

    def getVotesListByUserId() {
        def ret = [:]

        def voteList = (List<Poll>) pollService.getVoteList(Long.valueOf(params.userId), params.page_num ?: 1, params.page_size ?: 10)

        println Poll.list()
        ret['code'] = voteList != null ? 200 : 404
        ret['message'] = voteList != null ?
                message(code: 'poll.message.get.success', default: '获取投票成功') :
                message(code: 'poll.message.get.failed', default: '获取投票失败')
        if (voteList == null || voteList.size() <= 0) {
            render ret as JSON
            return
        }

        ret['result'] = []

        def user = User.get((params.userId == null) ? 0 : Long.valueOf(params.userId))

        voteList.each { ele ->
            def one = [:]

            def query_str = {
                eq('poll', ele)
                projections {
                    distinct(['voter', 'poll'])
                }
            }

            one['VoteId'] = ele.id
            one['VoteContent'] = ele.description
            one['VoteJoinCount'] = PollRecord.createCriteria().list(query_str).size()
            one['IsMultiselect'] = (ele.rule == 1 ? 0 : 1)
            one['Date'] = ele.create_time.format('yyyy-MM-dd HH:mm:ss')
            one['isCollection'] = (UserCollection.countByCollectorAndPollAndStatus(user, ele, 1) > 0 ? 1 : 0)
            one['isVote'] = (PollRecord.countByPollAndVoterAndStatus(ele, user, 1) > 0 ? 1 : 0)
            one['VoteItem'] = []
            def options = PollOption.findAllByPoll(ele)

            def voteUser = PollRecord.createCriteria()
            def count = voteUser.list {
                eq('poll', ele)
                projections {
                    distinct(['voter', 'poll'])
                }
            }

            options.each { option ->
                def single = [:]
                single['VoteItemId'] = option.id
                single['VoteItemContent'] = option.option_text
                single['VoteItemJointCount'] = PollRecord.countByPollAndPollOption(ele, option)
                single['VoteItemProgress'] = single['VoteItemJointCount'] / (count.size() == 0 ? 1 : count.size())
                single['isVote'] = (PollRecord.countByPollAndVoterAndPollOptionAndStatus(ele, user, option, 1) > 0 ? 1 : 0)
                one['VoteItem'].add(single)
            }

            ret['result'].add(one)
        }

        render ret as JSON
    }

    /*
    *APP投票
    * */

    @Transactional
    def voting() {
        def res = pollService.voting(
                Long.valueOf(params.userId),
                Long.valueOf(params.voteId),
                String.valueOf(params.selected)
        )

        render(contentType: 'application/json') {
            code = res['code'] == '200' ? 200 : 404
            message = res['code'] == '200' ?
                    message(code: 'poll.message.vote.success', default: '投票成功') :
                    message(code: res['code'], default: '投票失败')
        }
    }

    /*
    *社区服务
    * */
    /*
    *APP获取街道数据
    * */

    def getStreetData() {
        def res = communityService.getStreetData()

        def ret = [:]
        ret['code'] = res ? 0 : 1
        ret['message'] = res ?
                message(code: 'street.message.get.success', default: '获取街道成功') :
                message(code: 'street.message.get.failed', default: '获取街道失败')
        if (!res) {
            render ret as JSON
            return
        }
        ret['result'] = []
        res.each { street ->
            def street_one = [:]
            street_one['streetId'] = street.id
            street_one['streetName'] = street.name
            ret['result'].add(street_one)
        }

        render ret as JSON
    }

    /*
    *APP获取社区数据
    * */

    def getCommunityData() {
        def input = request.JSON
        println "=====>" + params.streetId
//        def res = communityService.getCommunityData()
        def res = communityService.getCommunityDataByStreetId(params.int('streetId'))
        def ret = [:]
        ret['code'] = res ? 0 : 1
        ret['message'] = res ? 'success' : 'failed'
        ret['result'] = []
        res.each { community ->
            def community_one = [:]
            community_one['communityId'] = community.id
            community_one['streetId'] = community.street.id
            community_one['communityName'] = community.name
            ret['result'].add(community_one)
        }

        render ret as JSON
    }

    /*
    *APP获取社区办事部门列表
    * */

    def getCommunityDepartmentsList() {

        def departmentList = communityService.getDepartment(Long.valueOf(params.streetId))
        departmentList.each { department ->
            department.street = Street.findById(department.street.id)
        }

        def ret = [:]
        ret['code'] = (departmentList != null) ? 200 : 404
        ret['message'] = (departmentList != null) ? 'success' : 'failed'
        ret['result'] = []

        departmentList.each { department ->
            def one_department = [:]
            one_department['DepartmId'] = department.id
            one_department['DepartmName'] = department.name
            ret['result'].add(one_department)
        }

        render ret as JSON
    }

    /*
    *APP获取部门下的业务列表
    * */

    def getBusinessByDepartmentId() {

        def ret = [:]

        def serviceItem = communityService.getDepartmentService(Long.valueOf(params.departmentId))

        ret['code'] = (serviceItem != null) ? 200 : 404
        ret['message'] = (serviceItem != null) ? 'success' : 'failed'

        if (serviceItem == null || serviceItem.size() <= 0) {
            render ret as JSON
            return
        }

        ret['result'] = []

        serviceItem.each { item ->
            def ele = [:]
            ele['BusinessID'] = item.id
            ele['BusinessTitle'] = item.name
            ret['result'].add(ele)
        }

        render ret as JSON
    }

    /*
    *APP获取业务详情
    * */

    def getBusinessContentByBusinessId() {
        def ret = [:]
        def item = communityService.getServiceItemDetail(Long.valueOf(params.businessId))

        ret['code'] = item != null ? 200 : 404
        ret['message'] = item != null ? 'success' : 'failed'

        if (item == null) {
            render ret as JSON
            return
        }

        ret['result'] = [:]
        ret['result']['BusinessID'] = item.id
        ret['result']['BusinessTitle'] = item.name
        ret['result']['BusinessContent'] = item.detail
        ret['result']['IsAppointment'] = (item.status == 1 ? 1 : 0)

        render ret as JSON
    }

    /*
    *APP用户预约查询
    * */

    def getOrderBusinessByUserId() {
        def reservationList = communityService.getReservationListForZf(
                Long.valueOf(params.userId),
                params.page_num ? Integer.valueOf(params.page_num) : 1,
                params.page_size ? Integer.valueOf(params.page_size) : 10
        )
        def ret = [:]
        ret['code'] = (reservationList != null) ? 200 : 404
        ret['message'] = (reservationList != null) ? 'success' : 'failed'
        ret['result'] = []
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd")
        reservationList.each { reservation ->
            def ele = [:]

            ele['departmentName'] = reservation.lxmc
            ele['BusinessTitle'] = reservation.fwmc
            ele['businessOrderTime'] = simpleDateFormat.format(reservation.orderTime).toString()
            ele['businessTime'] = reservation.timeSlot
            ele['status'] = reservation.status
            ret['result'].add(ele)
        }

        render ret as JSON
    }

    /*
    *APP用户预约办理业务
    * */

    @Transactional
    def orderBusiness() {
        def ret = [:]
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd")

        def fwid = Long.valueOf(params.businessId)
        def userId = Long.valueOf(params.userId)
        def orderDate = simpleDateFormat.parse(String.valueOf(params.orderDate))
        def timeSlot = params.timeSlot



        def res = communityService.reserveServiceForZf(fwid, userId, orderDate, timeSlot)

        ret['code'] = (res['code'] == '200') ? 200 : 500
        ret['message'] = (res['code'] == '200') ?
                message(code: 'serviceItem.order.success', default: '预约成功') :
                message(code: res['code'], default: '预约失败')

        render ret as JSON
    }

    /*
    *Topic话题
    * */
    /*
    *APP获取社区下的话题列表
    * */

    def getTopicsByCommunityId() {
        def ret = [:]
        def res = topicService.getTopicByCommunity(
                Long.valueOf(params.communityId),
                params.userId == null ? null : Long.valueOf(params.userId),
                params.page_num ? Integer.valueOf(params.page_num) : 1,
                params.page_size ? Integer.valueOf(params.page_size) : 10,
                params.order ? Integer.valueOf(params.order) : 1)
        ret['code'] = (res != null) ? 200 : 404
        ret['message'] = (res != null) ?
                message(code: 'topic.message.get.success', default: '获取话题成功') :
                message(code: 'topic.message.get.empty', default: '话题列表为空')

        if (res == null || res.size() <= 0) {
            render ret as JSON
            return
        }

        ret['result'] = []
        res.each { topic ->
            def ele = [:]
            def count = TopicReply.countByTopicAndStatus(topic, 1)
            def user = User.get(topic.promoter.id)
            ele['discussId'] = topic.id
            ele['commentCount'] = count > 0 ? count : 0
            ele['Date'] = topic.create_time.format('yyyy-MM-dd HH:mm:ss')
            ele['discussTitle'] = topic.title
            ele['User'] = [:]
            ele['User']['userId'] = user != null ? user.id : null
            ele['User']['userName'] = user != null ? user.name : null
            ele['User']['userHeadPortrait'] = user != null ? (user.potrait_id ? user.potrait_id : null) : null
            ele['isCollection'] = (UserCollection.countByCollectorAndTopicAndStatus(User.get((params.userId == null) ? 0 : Long.valueOf(params.userId)), topic, 1) > 0 ? 1 : 0)
            ret['result'].add(ele)
        }
        render ret as JSON
    }

    /*
    *APP获取话题讨论详情
    * */

    def getTopicContentByTopicId() {
        def ret = [:]
        def res = topicService.getTopicDetail(Long.valueOf(params.topicId))
        ret['code'] = (res != null) ? 200 : 404
        ret['message'] = (res != null) ?
                message(code: 'topic.message.get.success', default: '获取话题成功') :
                message(code: 'topic.message.get.empty', default: '话题为空')


        if (res == null) {
            render ret as JSON
            return
        }

        def ele = [:]
        def count = TopicReply.countByTopicAndStatus(res, 1)
        def user = User.get(res.promoter.id)
        ele['discussId'] = res.id
        ele['commentCount'] = count > 0 ? count : 0
        ele['Date'] = res.create_time.format('yyyy-MM-dd HH:mm:ss')
        ele['discussTitle'] = res.title
        ele['discussContent'] = res.content
        ele['User'] = [:]
        ele['User']['userId'] = user != null ? user.id : null
        ele['User']['userName'] = user != null ? user.name : null
        ele['User']['userHeadPortrait'] = user != null ? (user.potrait_id ? user.potrait_id : null) : null
        ele['isCollection'] = (UserCollection.countByCollectorAndTopicAndStatus(User.get((params.userId == null) ? 0 : Long.valueOf(params.userId)), res, 1) > 0 ? 1 : 0)
        ele['CommentList'] = []

        def allReply = topicService.getTopicReply(
                Long.valueOf(params.topicId),
                params.page_num ? Integer.valueOf(params.page_num) : null,
                params.page_size ? Integer.valueOf(params.page_size) : null
        )
        allReply.each { reply ->
            def one = [:]
            def commentUser = User.get(reply.publisher.id)
            one['CommentId'] = reply.id
            one['CommentIdContent'] = reply.content
            one['Date'] = reply.create_time.format('yyyy-MM-dd HH:mm:ss')
            one['User'] = [:]
            one['User']['userId'] = commentUser != null ? commentUser.id : null
            one['User']['userName'] = commentUser != null ? commentUser.name : null
            one['User']['userHeadPortrait'] = commentUser != null ? (commentUser.potrait_id ? commentUser.potrait_id : null) : null
            ele['CommentList'].add(one)
        }

        ret['result'] = ele

        render ret as JSON
    }

    /*
    *APP参与话题讨论
    * */

    @Transactional
    def involvingTopic() {

        def ret = [:]

        def res = topicService.topicReply(Long.valueOf(params.userId),
                Long.valueOf(params.topicId),
                String.valueOf(params.content))

        if (res['code'] != '200') {
            ret['code'] = 404
            ret['message'] = message(code: res['code'], default: '参与讨论失败')
            render ret as JSON
            return
        }

        ret['code'] = 200
        ret['message'] = message(code: 'topic.message.reply.success', default: '评论成功')
        ret['result'] = [replyId: ret['replyId']]

        render ret as JSON
    }

    /*
    *APP新建话题讨论
    * */

    @Transactional
    def createTopic() {

        def ret = [:]

        def res = topicService.createTopic(Long.valueOf(params.userId),
                String.valueOf(params.title),
                String.valueOf(params.content))

        if (res['code'] != '200') {
            ret['code'] = 404
            ret['message'] = message(code: res['code'], default: '创建话题失败')
            render ret as JSON
            return
        }

        ret['code'] = 200
        ret['message'] = message(code: 'topic.message.create.success', default: '创建话题成功')
        ret['result'] = [topicId: res['topicId']]

        render ret as JSON
    }

    /*
    *APP添加收藏
    * */

    @Transactional
    def addUserCollectionByTypeAndTargetId() {
        def ret = false
        if (Integer.valueOf(params.type) == 1)
            ret = topicService.collectTopic(Long.valueOf(params.userId), Long.valueOf(params.targetId))

        if (Integer.valueOf(params.type) == 2)
            ret = pollService.collectVote(Long.valueOf(params.userId), Long.valueOf(params.targetId))

        render(contentType: 'application/json') {
            code = ret['code'] == '200' ? 200 : 500
            message = ret['code'] == '200' ?
                    message(code: 'collection.create.success', default: '收藏成功') :
                    message(code: ret['code'], default: '收藏失败')
        }
    }

    /*
    *APP取消收藏
    * */

    @Transactional
    def cancelUserCollectionByTypeAndTargetId() {

        def ret = false
        if (Integer.valueOf(params.type) == 1)
            ret = topicService.cancelCollectTopic(Long.valueOf(params.userId), Long.valueOf(params.targetId))

        if (Integer.valueOf(params.type) == 2)
            ret = pollService.cancelCollectVote(Long.valueOf(params.userId), Long.valueOf(params.targetId))

        render(contentType: 'application/json') {
            code = ret['code'] == '200' ? 200 : 500
            message = ret['code'] == '200' ?
                    message(code: 'collection.get.success', default: '取消收藏成功') :
                    message(code: ret['code'], default: '取消收藏失败')
        }
    }

    /*
    *APP获取收藏
    * */

    def getUserCollection() {
        def ret = [:]
        if (Integer.valueOf(params.type) == 1) {
            def res = topicService.getTopicCollect(
                    Long.valueOf(params.userId),
                    params.targetId ? Long.valueOf(params.targetId) : null,
                    params.page_num ? Integer.valueOf(params.page_num) : 1,
                    params.page_size ? Integer.valueOf(params.page_size) : 10
            )
            ret['code'] = ((res != null) ? 200 : 404)
            ret['message'] = ((res != null) ? 'success' : 'failed')
            if (res == null) {
                render ret as JSON
                return
            }
            def result = []
            res.each { collection ->
                def ele = [:]
                ele['discussId'] = collection.topic.id
                ele['commentCount'] = TopicReply.countByTopic(collection.topic)
                ele['Date'] = collection.topic.create_time.format('yyyy-MM-dd HH:mm:ss')
                ele['discussTitle'] = collection.topic.title
                ele['User'] = [:]
                ele['User']['userName'] = collection.topic.promoter.name
                ele['User']['userId'] = collection.topic.promoter.id
                ele['User']['userHeadPortrait'] = collection.topic.promoter.potrait_id ? collection.topic.promoter.potrait_id : null
                result.add(ele)
            }

            ret['result'] = result
        }

        if (Integer.valueOf(params.type) == 2) {
            def res = pollService.getVoteCollect(
                    Long.valueOf(params.userId),
                    params.targetId ? Long.valueOf(params.targetId) : null,
                    params.page_num ? Integer.valueOf(params.page_num) : 1,
                    params.page_size ? Integer.valueOf(params.page_size) : 10
            )
            ret['code'] = ((res != null) ? 200 : 404)
            ret['message'] = ((res != null) ? 'success' : 'failed')
            if (res == null) {
                render ret as JSON
                return
            }
            def result = []

            res.each { collection ->
                def ele = [:]
                def poll = Poll.get(Long.valueOf(collection.vote.id))
                def user = User.get(Long.valueOf(params.userId))
                ele['VoteId'] = collection.vote.id
                ele['VoteContent'] = collection.vote.description
                ele['VoteJoinCount'] = collection.voteUserCount
                ele['IsMultiselect'] = (collection.vote.rule == 1 ? 0 : 1)
                ele['Date'] = collection.vote.create_time.format('yyyy-MM-dd HH:mm:ss')
                ele['isVote'] = (PollRecord.countByPollAndVoterAndStatus(poll, user, 1) > 0 ? 1 : 0)
                ele['VoteItem'] = []

                collection.options.each { option ->
                    def voteItem = [:]
                    voteItem['VoteItemId'] = option.id
                    voteItem['VoteItemContent'] = option.option_desc
                    voteItem['isVote'] = (PollRecord.countByPollAndVoterAndPollOptionAndStatus(poll, user, option, 1) > 0 ? 1 : 0)
                    voteItem['VoteItemJointCount'] = PollRecord.countByPollAndPollOption(collection.vote, option)
                    voteItem['VoteItemProgress'] = voteItem['VoteItemJointCount'] / (ele['VoteJoinCount'] == 0 ? 1 : ele['VoteJoinCount'])
                    ele['VoteItem'].add(voteItem)
                }

                result.add(ele)
            }

            ret['result'] = result
        }

        render ret as JSON
        return
    }

    /*
    *APP意见提交
    * */

    @Transactional
    def opining() {
        def default_image_location = null
        def images = null

        if (params.imgs != null && request instanceof MultipartHttpServletRequest) {
            default_image_location = grailsApplication.config.zhsq.default.image.storage.location
            images = request.getFiles("imgs")
        }

        def res = userService.adviceSubmit(
                Long.valueOf(params.userId),
                params.title == null ? null : String.valueOf(params.title),
                String.valueOf(params.content),
                images,
                default_image_location
        )

        render(contentType: 'application/json') {
            code = res['code'] == '200' ? 200 : 500
            message = res['code'] == '200' ?
                    message(code: 'advice.submit.success', default: '意见提交成功') :
                    message(code: res['code'], default: '意见提交失败')
        }
    }
}
