package smartcommunity

import grails.transaction.Transactional
import net.sf.json.JSONObject
import util.HttpUtil

@Transactional
class CommunityService {

    static scope = 'request'

    def serviceMethod() {

    }

    /*
    *获取街道数据
    * */

    def getStreetData() {
        return Street.findAll()
    }

    /*
    *获取社区数据
    * */

    def getCommunityData() {
        return Community.findAll()
    }

    /*
    *根据街道获取社区数据
    * */

    def getCommunityDataByStreetId(Integer sid) {
        return Community.findAllByStreet(Street.get(sid))
    }

    /*
    *获取社区公告列表
    * */

    def getNoticeList(Long community_id, Integer page_num, Integer page_size, Integer orderNum) {

        def query = {
            eq("status", 1)
            eq("community", Community.get(community_id))
            order("create_time", "asc")
        }


        def noticeList = Announcement.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)

        return noticeList

    }

    /*
    *获取公告详情
    * */

    def getNoticeDetail(Long announcement_id) {
        def announcement = Announcement.findById(announcement_id)
        def imageList = AnnouncementImage.findAllByAnnouncement(announcement)
        def imageIds = []
        imageList.each { image ->
            imageIds.add(image.image.id)
        }
//        announcement.files = fileList
        return [announcement: announcement, images: imageIds]
    }

    /*
    *增加部门
    * */

    def addDepartment(ServiceDepartment serviceDepartment) {
        def now = new Date()
        serviceDepartment.description = serviceDepartment.description ?: ''
        serviceDepartment.address = serviceDepartment.address ?: ''
        serviceDepartment.create_time = now
        serviceDepartment.update_time = now
        serviceDepartment.save(flush: true)
    }

    /*
    *获取社区部门信息
    * */

    def getDepartment(Long street_id) {
        return ServiceDepartment.findAllByStreet(Street.findById(street_id))
    }

    /*
    *增加办事项目
    * */

    def addServiceItem(ServiceItem serviceItem) {
        def now = new Date()
        serviceItem.create_time = serviceItem.create_time ?: now
        serviceItem.update_time = serviceItem.update_time ?: now
        serviceItem.detail = serviceItem.detail ?: ''
        serviceItem.status = serviceItem.status ?: 1
        serviceItem.save(flush: true)
    }

    /*
    *获取社区办事列表
    * */

    def getDepartmentService(Long department_id) {
        return ServiceItem.findAllByDepartment(ServiceDepartment.findById(department_id))
    }

    /*
    *获取办事详情
    * */

    def getServiceItemDetail(Long item_id) {
        return ServiceItem.findById(item_id)
    }

    /*
    *发起预约
    * */

    def reserveService(Long user_id, Long service_id, Date order_date) {
        if (order_date == null) return [code: 'reserve.order.data.null']
        def now = new Date()
        def reserve_person = User.findById(user_id)
        if (reserve_person == null) return [code: 'user.not.exist']
        def serviceItem = ServiceItem.findById(service_id)
        if (serviceItem == null) return [code: 'serviceItem.not.exist']
        def res = ServiceReservation.findAllByReserve_personAndServiceItemAndServer_timeIsNull(reserve_person, serviceItem)
        if (res.size() > 0) return [code: 'serviceItem.order.repeat']

        ServiceReservation serviceReservation = new ServiceReservation()
        serviceReservation.reserve_person = User.findById(user_id)
        serviceReservation.serviceItem = ServiceItem.findById(service_id)
        serviceReservation.order_date = order_date
        serviceReservation.status = 1
        serviceReservation.create_time = now
        serviceReservation.update_time = now
        serviceReservation.save(flush: true)

        return [code: '200']
    }

    /**
     * 发起预约调用政府的数据

     */
    def reserveServiceForZf(Long fwid, Long user_id, Date order_date, String timeSlot) {
        if (order_date == null) return [code: 'reserve.order.data.null']
        def now = new Date()
        def reserve_person = User.findById(user_id)
        if (reserve_person == null) return [code: 'user.not.exist']


        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap = getDataBySqfwId(fwid)

        def fwmc = dataMap.get("fwmc")
        def fwlxId = dataMap.get("fwlxId")
        def lxmc = dataMap.get("fwlxId")


        Yyfw yyfw = new Yyfw()
        yyfw.fwId=fwid
        yyfw.fwmc=fwmc
        yyfw.fwlxId=Integer.parseInt(fwlxId)
        yyfw.lxmc=lxmc
        yyfw.status = 1

        yyfw.reservePerson = reserve_person
        yyfw.orderTime = order_date
        yyfw.timeSlot = timeSlot

        yyfw.createTime = new Date()

        if(yyfw.save(flush: true)){
            return [code: '200']
        }else{
            return [code: '500']
        }


    }

    /*
    *确认预约
    * */

    def confirmReservation(Long reservation_id, Date server_time, String server_desc, Integer reservation_status = 2) {
        ServiceReservation serviceReservation = ServiceReservation.findById(reservation_id)
        serviceReservation.server_time = server_time
        serviceReservation.server_desc = server_desc
        serviceReservation.status = reservation_status
        serviceReservation.update_time = new Date()
        serviceReservation.save(flush: true)
    }

    /*
    *获取预约列表
    * */

    def getReservationList(Long user_id, Integer page_num, Integer page_size) {
        def query = {
            eq('reserve_person', User.get(user_id))
        }
        return ServiceReservation.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)
    }


    /*
    *获取预约列表
    * */

    def getReservationListForZf(Long user_id, Integer page_num, Integer page_size) {
        def query = {
            eq('reservePerson', User.get(user_id))
        }
        return Yyfw.createCriteria().list(query, offset: page_num > 1 ? ((page_num - 1) * page_size) : 0, max: page_size)
    }


    /*
    *获取街道下的社区
    * */

    def getCommnunityList(Long street_id) {
        return Community.findAllByStreet(Street.findById(street_id))
    }

    /*
    *添加社区信息
    * */

    def addCommunity(String name, String description, Long street_id, Long charger_id) {
        Community community = new Community([
                name       : name,
                description: description,
                street     : Street.findById(street_id),
                charger    : User.findById(charger_id),
                create_time: new Date(),
                update_time: new Date()
        ])
        community.save(flush: true)
    }





    /**
     * 根据社区服务ID获取数据
     */
    def getDataBySqfwId(Long sqfwId){
        //获取社区服务详情
        String url = "http://218.84.107.54:8081/sqService/communityService";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getDetailBySqfwId");
        dataMap.put("sqfwId", sqfwId.toString());
        dataMap.put("charset", "utf-8");
        //得到社区服务详情
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        println("返回信息为："+jsonStr);
        JSONObject jsonObject = JSONObject.fromObject(jsonStr);
        JSONObject sqfwDetail = JSONObject.fromObject(jsonObject.get("result"));
        String data = "";
        Map<String, String> dataMap2 = new HashMap<String, String>();
        if(sqfwDetail.size() > 0) {//查询到该条数据
            String fwmc = sqfwDetail.get("fwmc");//服务名称
            String fwlxId = sqfwDetail.get("fwlxId");//服务类型ID
            String lxmc = sqfwDetail.get("lxmc")     //服务类型名称
            data += "服务名称:"+fwmc+"，服务类型ID:"+fwlxId+"，类型名称："+lxmc;
            dataMap2.put("fwmc",fwmc)
            dataMap2.put("fwlxId",fwlxId)
            dataMap2.put("lxmc",lxmc)

        }
        return dataMap2
    }

}
