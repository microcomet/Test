package smartcommunity

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class DesireService {

    static scope = 'request'

    def imageService

    /*
    *新建微心愿
    * */

    def createTinyWish(Long user_id, String content, List<MultipartFile> images, String save_path) {
        def user = User.findById(user_id)
        if (user == null) return [code: 'user.not.exist']
        if (content == null) return [code: 'desire.content.empty']

        def now = new Date()
        Desire desire = new Desire()
        desire.create_time = now
        desire.update_time = now
        desire.description = content
        desire.community = user.community
        desire.score = Score.findByType(2) ? Score.findByType(2).score : 50
        desire.title = " "
        desire.status = 1
        desire.requester = user
        desire.save(flush: true)

        if (images != null && images.size() > 0) {
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

                    DesireImage desireImage = new DesireImage([
                            desire: desire,
                            image : imageInstance,
                            status: 1
                    ])
                    desireImage.save(flush: true)
                }
            }
        }

        return [code: '200']
    }

    /*
    *获取心愿关联的image列表
    * */

    def getWishImageList(Long wish_id) {
        def imageList = DesireImage.findAllByDesireAndStatus(Desire.get(wish_id), 1)
        def images = []
        imageList.each { desireImage ->
            images.add(desireImage.image.id)
        }
        return images
    }

    /*
    *获取用户当前社区的所有微心愿
    * */

    def getTinyWishListByUserId(Long user_id, Integer page_num, Integer page_size) {
        def user = User.get(user_id)
        if (user == null || user.community == null) return null
        def query = {
            eq('community', user.community)
            ne('status', 6)
            order('create_time', 'desc')
        }
        return Desire.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size);
    }

    /*
    *领取微心愿
    * */

    def receiveTinyWish(Long user_id, Long tinyWish_id) {
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return [code: 'desire.receive.user_or_desire.empty']
        def user = User.findById(user_id)
        if (user == null) return [code: 'desire.receive.user_or_desire.empty']

        if (desire.helper == null) {
            desire.helper = user
            desire.status = 2
            desire.received_time = new Date()
            desire.update_time = new Date()
            desire.save(flush: true)
            return [code: '200']
        } else {
            return [code: 'desire.receive.already']
        }
    }

    /*
    *撤销领取的微心愿
    * */

    def cancelTinyWish(Long user_id, Long tinyWish_id) {
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return [code: 'desire.empty']

        if (desire.status == 5) return [code: 'desire.status.closed']
        if (desire.status == 6) return [code: 'desire.status.deleted']

        def now = new Date()
        if (desire.helper.id == user_id && desire.status == 2 && ((now.time - desire.received_time.time) / 3600000 < 1)) {
            desire.helper = null
            desire.received_time = null
            desire.update_time = now
            desire.save(flush: true)
            return [code: '200']
        } else {
            return [code: 'desire.revoke.error']
        }
    }

    /*
    *修改微心愿
    * */

    def modifyTinyWish(Long user_id, Long tinyWish_id, String content, List<MultipartFile> images, String save_path) {
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return [code: 'desire.empty']
        def user = User.findById(user_id)
        if (user == null) return [code: 'user.not.exist']

        if (desire.helper == null && desire.requester.id == user_id) {
            desire.update_time = new Date()
            desire.description = content

            def priorImageList = DesireImage.findAllByDesireAndStatus(desire, 1)

            priorImageList.each { image ->
                image.status = 2
                image.save(flush: true)
            }

            if (images != null && images.size() > 0) {
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

                        DesireImage desireImage = new DesireImage([
                                desire: desire,
                                image : imageInstance,
                                status: 1
                        ])
                        desireImage.save(flush: true)
                    }
                }
            }

            desire.save(flush: true)
            return [code: '200']
        }
        return [code: 'desire.modify.deny']
    }

    /*
    *请求者确认心愿完成
    * */

    def confirmWishByRequester(Long user_id, Long tinyWish_id) {
        def user = User.findById(user_id)
        if (user == null) return [code: 'desire.receive.user_or_desire.empty']
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return [code: 'desire.receive.user_or_desire.empty']

        if (desire.requester.id != user_id) return [code: 'desire.confirm.user.neq']

        if (desire.status != 4) return [code: 'desire.confirm.early']

        if (this.modifyTinyWishStatus(tinyWish_id, 3)) return [code: '200']

        return [code: 'desire.confirm.failed']
    }

    /*
    *帮助者确认心愿完成
    * */

    def confirmWishByHelper(Long user_id, Long tinyWish_id) {
        def user = User.findById(user_id)
        if (user == null) return [code: 'desire.receive.user_or_desire.empty']
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return [code: 'desire.receive.user_or_desire.empty']

        if (desire.helper.id != user_id) return [code: 'desire.confirm.user.neq']

        if (this.modifyTinyWishStatus(tinyWish_id, 4)) return [code: '200']

        return [code: 'desire.confirm.failed']
    }

    /*
    *用户对自己认领的心愿进行反馈
    * */

    def tinyWishFeedback(Long user_id, Long tinyWish_id, String feedback) {
        def user = User.findById(user_id)
        if (user == null) return [code: 'desire.receive.user_or_desire.empty']
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return [code: 'desire.receive.user_or_desire.empty']

        if (desire.helper.id != user_id && desire.requester.id != user_id) return [code: 'desire.confirm.user.neq']
        if (desire.status == 5) return [code: 'desire.status.closed']
        if (desire.status == 6) return [code: 'desire.status.deleted']
        DesireFeedback desireFeedback = new DesireFeedback([
                desire     : desire,
                feeder     : user,
                feedContent: feedback,
                status     : 1,
                feedTime   : new Date(),
                updateTime : new Date()
        ])

        desireFeedback.save(flush: true)
//        desire.feedback = feedback
//        desire.update_time = new Date()
//        desire.save(flush: true)
        return [code: '200']
    }

    /*
    *修改微心愿状态
    * */

    def modifyTinyWishStatus(Long tinyWish_id, Integer status) {
        if (!(status in [3, 4])) return false
        def desire = Desire.findById(tinyWish_id)
        if (desire == null) return false

        if (desire.status < 2) return false

        if (desire.status >= 2) desire.status = ((desire.status + status == 7) ? 5 : status)

        if (status == 3) desire.finish_time = new Date()
        if (status == 4) desire.submit_time = new Date()
        desire.save(flush: true)
        return true
    }

    /*
    *删除心愿
    * */

    def deleteTinyWish(Long user_id, Long tinyWish_id) {
        def desire = Desire.findById(tinyWish_id)
        if (desire.helper == null && desire.requester.id == user_id) {
            desire.status = 6
            desire.save(flush: true)
            return [code: '200']
        }
        return [code: 'desire.receive.already']
    }

    /*
    *获取自己创建的微心愿列表
    * */

    def getMySelfTinyWish(Long user_id, Integer page_num, Integer page_size) {
        def user = User.findById(user_id)
        if (user == null) return [code: 'user.not.exist']
        def query = {
            eq('requester', user)
            ne('status', 6)
            order('create_time', 'desc')
        }

        return [
                code    : '200',
                wishList: Desire.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)
        ]
    }

    /*
    *获取自己领取的微心愿
    * */

    def getReceivedTinyWish(Long user_id, page_num, page_size) {
        def user = User.findById(user_id)
        if (user == null) return null

        def query = {
            eq('helper', user)
            ne('status', 6)
            order('received_time', 'desc')
        }

        return Desire.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)
    }

    /*
    *获取心愿详情
    * */

    def getTinyWishDetail(Long wish_id, Long user_id, int page_num, int page_size) {
        def tinyWish = Desire.get(wish_id)
        if (tinyWish == null) return [code: '404', message: 'desire.empty']
        def user = User.get(user_id)
        if (user == null) return [code: '404', message: 'user.not.exist']

        def query = {
            eq('desire', tinyWish)
            eq('status', 1)
            order('feedTime', 'desc')
        }

        def feedbackList = DesireFeedback.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)

        return [code: '200', message: 'desire.get.success', tinyWish: tinyWish, feedbackList: feedbackList]
    }
}
