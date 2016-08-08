package smartcommunity

import user.UserInfo

class UserIncController {

    def index() { }
    def createUser(){
        println "roleLv = "+params.roleLv
        println "s+c = " +params.streetId + "/" + params.communityId
        def ui = (UserInfo)session.getAttribute("user")
        def streetList
        def communityList

        if(ui.role_role == 10){//超级管理员
            streetList = Street.list()
        }else if(ui.role_role == 8){//街道管理员
            streetList = Street.findAllById(ui.street_id)
        }else if(ui.role_role == 6){//社区管理员
            communityList = Community.findAllById(ui.community_id)
        }


        return [streetList:streetList,communityList:communityList]
    }

}
