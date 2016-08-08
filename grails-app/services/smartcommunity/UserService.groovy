package smartcommunity

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class UserService {
    static scope = 'request'

    def imageService

    /*
    *用户注册
    * */

    def userRegister(User user, String sms_code) {

        if (sms_code == null) {
            return [
                    code   : '404',
                    message: 'user.sms_code.empty'
            ]
        }


        def user_in_db = User.findByMobile(user.mobile)
        if (user_in_db) {
            return [
                    code   : '404',
                    message: 'user.mobile.exists'
            ]
        }

        user.status = user.status ?: 1

        UserSMSCode userSMSCode = new UserSMSCode([
                mobile     : user.mobile,
                smsCode    : sms_code,
                create_time: new Date(),
                update_time: new Date()
        ])

        user.save(flush: true)
        println user.errors
        userSMSCode.save(flush: true)
        return [
                code   : '200',
                message: 'user.register.success'
        ]
    }

    /*
    *用户登陆
    * */

    def userLogin(String phone, String password) {

        def ret = [:]
        //存在校验
        def exist_user = User.findByMobile(phone)
        if (!exist_user) {
            ret.message = false
            return ret
        }

        //密码校验
        if (password.encodeAsSHA256Bytes().encodeAsHex() != exist_user.password) {
            ret.message = false
            return ret
        }

        //状态校验
        if (exist_user.status != 2) {
            ret.message = false
            return ret
        }

        ret.message = true
        ret.exist_user = exist_user
        return ret
    }

    /*
    *修改密码
    * */

    def modifyPassword(String phone, String currentPwd, String new_pass) {
        def user = User.findByMobileAndPassword(phone, currentPwd.encodeAsSHA256Bytes().encodeAsHex())
        if (user == null) return [code: 'user.not.exist']
        user.password = new_pass.encodeAsSHA256Bytes().encodeAsHex()
        user.save(flush: true)
        return [code: '200']
    }

    def modifyUserPicture(Long user_id, MultipartFile image, String save_path) {
        def user = User.get(user_id)
        if (user == null) return [code: 'user.not.exist']
        if (image == null) return [code: 'user.upload.image.is.null']

        def res = imageService.saveImage(image, "${save_path}${user.name}")
        if (res != -1) {
            Image imageInstance = new Image([
                    name       : res,
                    storage_url: "${save_path}${user.name}/${res}",
                    uploader   : user,
                    upload_time: new Date(),
                    status     : 1,
                    create_time: new Date(),
                    update_time: new Date()
            ])
            imageInstance.save(flush: true)

            user.head_url = imageInstance.storage_url
            user.potrait_id = imageInstance.id

            user.save(flush: true)
            return [code: '200', imageId: imageInstance.id]
        } else {
            return [code: 'user.potrait.modify.failed']
        }
    }

    /*
    *修改手机号
    * */

    def modifyPhone(String phone, String pwd, String new_phone) {
        def user = User.findByMobile(phone)
        if (user == null) return [code: '404', message: 'user.not.exist']
        if (user.password != pwd.encodeAsSHA256Bytes().encodeAsHex()) return [code: '404', message: 'user.message.pwd.error']

        def exist_user = User.findAllByMobile(new_phone)
        if (exist_user != null && exist_user.size() > 0) return [code: '500', message: 'user.message.duplicate.phone']

        user.mobile = new_phone
        user.save(flush: true)
        return [code: '200', message: 'user.modify.success']
    }

    /*
    *修改用户住址
    * */

    def modifyAddress(Long user_id, Long community_id) {
        def user = User.findById(user_id)
        if (user == null) return [code: '404', message: 'user.not.exist']
        def new_community = Community.findById(community_id)
        if (new_community == null) return [code: '404', message: 'user.community.empty']
        user.community = new_community ?: user.community
        user.save(flush: true)
        return [code: '200', message: 'user.modify.success']
    }

    /*
    *获取个人信息
    * */

    def getUserDetail(Long userId) {
        def user = User.findById(userId)
        return user ?: null
    }

    /*
    *获取用户信息
    * role：获取小于等于role的用户信息
    * */

    def userQuery(Integer role) {
        return User.findAllByRoleInList(Role.findAllByRoleInRange(role..8))
    }

    /*
    *用户审核
    * */

    def userAuditing(Long user_id, Integer ret, String auditing_desc) {
        User user = User.findById(user_id)
        user.status = ret
        user.auditing_desc auditing_desc
        user.save(flush: true)
    }

    /*
    *验证用户
    * */

    def verifyUser(String phone, String password) {
        def user = User.findByMobile(phone)
        if (user == null) return [code: 'user.not.exist']

        //状态校验
        if (user.status != 2) {
            return [code: { status ->
                if (status == 3) return 'user.message.status.auditing.error'
                if (status == 4) return 'user.message.status.forbidden'
                if (status == 5) return 'user.message.status.delete'
                return 'user.message.status.error'
            }(user.status)]
        }

        if (password.encodeAsSHA256Bytes().encodeAsHex() == user.password) return [code: 'user.verify.success']
        return [code: 'user.verify.failed']
    }

    /*
    *验证手机验证码
    * */

    def verifySmsCode(String phone, String code) {
        def userSmsCodeList = UserSMSCode.findAllByMobile(phone).sort { a, b ->
            return b.create_time.compareTo(a.create_time)
        }

        if (!userSmsCodeList || userSmsCodeList.size() == 0) {
            return false
        }

        if (userSmsCodeList[0].smsCode == code) {
            return true
        }
        return false
    }

    /*
    *获取手机验证码
    * */

    def generateSMSCode(String phone) {
        def exist_code = UserSMSCode.findAllByMobile(phone)
        UserSMSCode.deleteAll(exist_code)

        def sms = this.smsCode(6)
        UserSMSCode userSMSCode = new UserSMSCode([
                mobile     : phone,
                smsCode    : sms,
                create_time: new Date(),
                update_time: new Date()
        ])

        userSMSCode.save(flush: true)
        return sms
    }

    /*
    *随机生成验证码
    * */

    def smsCode(Integer length) {
        String retStr = ""
        String strTable = "1234567890"
        int len = strTable.length()
        boolean bDone = true
        while (bDone) {
            retStr = ""
            def count = 0
            for (def i = 0; i < length; i++) {
                def dblR = Math.random() * len
                int intR = Math.floor(dblR)
                def c = strTable.charAt(intR)
                if (('0' <= c) && (c <= '9')) {
                    count++
                }
                retStr += strTable.charAt(intR)
            }
            if (count >= 2) {
                bDone = false
            }
        }

        return retStr
    }

    /*
    *用户收藏
    * */

    def collectionTopicOrPoll(Long user_id, Long target_id, Integer type) {
        User collector = User.findById(user_id)
        if (collector == null) return false
        if (type == 1) {
            UserCollection userCollection = new UserCollection()
            userCollection.collector = collector
            userCollection.topic = Topic.findById(target_id)
            userCollection.status = 1
            userCollection.create_time = new Date()
            userCollection.update_time = new Date()
            userCollection.save(flush: true)
        } else if (type == 2) {
            UserCollection userCollection = new UserCollection()
            userCollection.collector = collector
            userCollection.poll = Poll.findById(target_id)
            userCollection.status = 1
            userCollection.create_time = new Date()
            userCollection.update_time = new Date()
            userCollection.save(flush: true)
        }
        return true
    }

    /*
    *获取用户收藏
    * */

    def getCollection(Long user_id) {
        return UserCollection.findAllByCollectorAndStatus(User.findById(user_id), 1)
    }

    /*
    *取消收藏
    * */

    def cancelCollection(Integer type, Long target_id, Long user_id) {
        User collector = User.findById(user_id)
        if (collector == null) return false
        if (type == 1) {
            Topic target = Topic.findById(target_id)
            UserCollection userCollection = UserCollection.findByCollectorAndTopicAndType(collector, target, type)
            if (userCollection == null) return false
            userCollection.status = 2
            userCollection.update_time = new Date()
            userCollection.save(flush: true)
        } else {
            Poll poll = Poll.findById(target_id)
            UserCollection userCollection = UserCollection.findByCollectorAndTypeAndPoll(collector, poll, type)
            if (userCollection == null) return false
            userCollection.status = 2
            userCollection.update_time = new Date()
            userCollection.save(flush: true)
        }
        return true
    }

    /*
    *意见提交
    * */

    def adviceSubmit(Long user_id, String title, String content, List<MultipartFile> images, String save_path) {
        def user = User.get(user_id)
        if (user == null) return [code: 'user.not.exist']

        Suggestion suggestion = new Suggestion([
                street     : user.community.street,
                community  : user.community,
                publisher  : user,
                title      : (title == null ? 'Test' : title),
                content    : content,
                status     : 1,
                create_time: new Date(),
                update_time: new Date()
        ])

        suggestion.save(flush: true)

        if (images != null) {
            images.each { image ->
                def res = imageService.saveImage(image, "${save_path}${user.name}")
                if (res != -1) {
                    Image imageInstance = new Image([
                            name       : res,
                            storage_url: "${save_path}${user.name}/${res}",
                            uploader   : user,
                            upload_time: new Date(),
                            status     : 1,
                            create_time: new Date(),
                            update_time: new Date()
                    ])
                    imageInstance.save(flush: true)

                    SuggestionImage suggestionImage = new SuggestionImage([
                            suggestion: suggestion,
                            image     : imageInstance
                    ])
                    suggestionImage.save(flush: true)
                }
            }
        }
        return [code: '200']

    }

}
