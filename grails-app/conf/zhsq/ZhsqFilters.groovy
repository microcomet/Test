package zhsq

import grails.converters.JSON
import smartcommunity.UserLog
import smartcommunity.User
import user.UserInfo

class ZhsqFilters {

    def filters = {

        all(controller: '*', action: '*') {
            before = {
                println("contollerName = " + controllerName + "/" + "acitonName = " + actionName)
                println("params = " + params)

                /**
                 * 手机端请求过滤
                 * */

                //手机端访问的controller名字
                String[] appAction = ["app", "news"]
                //需要判断用户状态的action列表
                String[] actionOther = ["receiveTinyWish", "createTinyWish", "addUserCollectionByTypeAndTargetId", "cancelUserCollectionByTypeAndTargetId", "getBusinessContentByBusinessId", "createTopic", "involvingTopic", "voting", "opining", "orderBusiness"]
                //不需要判断用户状态的action列表
                String[] noCheckAction = ["userLogin", "getSMSCode", "verifySMSCode", "userRegister", "getCommunityData", "getStreetData", "getNewsList", "getDetailById", "getFwlxList", "getSqfwListByLxId", "getDetailBySqfwId"]

                //如果请求的controller在列表中,说明是手机请求
                if (controllerName in appAction) {
                    //判断如果传了用户ID
                    if (params.userId) {
                        def user = User.get(params.userId)
                        //用户状态为4返回用户已经冻结了.
                        if (user.status == 4) {
                            def ret = [:]

                            ret['code'] = 999
                            ret['message'] = "用户被冻结,无法使用此功能!"

                            render ret as JSON
                            return false
                        }
                        //如果状态没冻结,在判断是否在需要验证的action
                        if (actionName in actionOther) {
                            println("App send message")

                            //如果用户状态是1或3,提示用户审核状态不对,无法正确访问.
                            if (user.status == 1 || user.status == 3) {
                                def ret = [:]

                                ret['code'] = 666
                                ret['message'] = "用户未审核通过,无法使用该功能!"

                                render ret as JSON
                                return false
                            }

                        }
                    } else {//如果用户ID空.
                        if (actionName in noCheckAction) {

                        } else {//判断用户请求的action在不需要确认的列表中,返回用户状态冻结
                            def ret = [:]

                            ret['code'] = 999
                            ret['message'] = "用户不存在或被冻结,无法使用此功能!"

                            render ret as JSON
                            return false
                        }

                    }

                }

                /**
                 * 后台端请求过滤
                 * */

                String[] other = ["app", "image", "assets", "home", "inc", "admin", "news"]

                if (controllerName != null) {
                    if ((controllerName in other) == false) {
//                        println "controllerName is " + controllerName + "/ 不在 " + other + " 中"

                        def ui = (UserInfo) session.getAttribute('user')
                        if (ui) {
                            println "User is " + ui.user_id
//                            UserLog userLog = new UserLog([
//                                    operator    : User.get(ui.user_id),
//                                    description : "${controllerName}/${actionName}",
//                                    operate_time: new Date(),
//                                    create_time : new Date()
//                            ])
//                            userLog.save(flush: true)
                        } else {
                            println "User is null"
                            //render(view: '/admin/login')
                            redirect(controller: "admin", action: "index")
                            return false
                        }


                    } else {
//                        println "controllerName is " + controllerName + "/ 在" + other + "中"
                    }
                }


            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
//
//        streetCreate(controller:'street', action: 'create'){
//            before = {
//                def current_user = (User)session.getAttribute('user')
//                if(current_user.role.role < 8){
//                    flash.message = '权限不足'
//                    redirect(controller: 'street', action: 'index')
//                    return false
//                }
//            }
//
//            after = {
//
//            }
//
//            afterView = {
//
//            }
//        }
//
//        communityCreate(controller:'community', action: 'create'){
//            before = {
//                def current_user = (User)session.getAttribute('user')
//                if(current_user.role.role < 6){
//                    flash.message = '权限不足'
//                    redirect(controller: 'community', action: 'index')
//                    return false
//                }
//            }
//
//            after = {
//
//            }
//
//            afterView = {
//
//            }
//        }
    }
}
