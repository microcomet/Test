package smartcommunity

import net.sf.json.JSONObject

/**
 * Created by songl on 2016/7/17.
 * 获取政府社区controller
 */
import util.HttpUtil

class NewsController {

    def govService

    def index() {}

    /**
     * 获取新闻公告列表
     *  http://localhost:8080/zhsq/News/getNewsList?method=getNewsList&communityId=xx&ssmk=xx&page_num=xx&page_size=xx
     */
    def getNewsList(){
        //获取分页新闻公告列表
        String url = "http://218.84.107.54:8081/sqService/news";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getNewsList");
        String communityId = request.getParameter("communityId")
        if(communityId){
            Community community = Community.get(communityId)
            dataMap.put("ssqu", community.code);
        }
        String ssmk = request.getParameter("ssmk")
        if(ssmk){
            dataMap.put("ssmk", ssmk);
        }
        String page_size = request.getParameter("page_size")
        if(page_size){
            dataMap.put("pageSize", page_size);
        }
        String page_num = request.getParameter("page_num")
        if(page_num){
            dataMap.put("pageNo", page_num);
        }
        dataMap.put("charset", "utf-8");
        //得到公告列表
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        println("获取到的数据为============"+jsonStr)
        //System.out.println("返回信息为："+jsonStr);
        /*JSONObject jsonObject = JSONObject.fromObject(jsonStr);
        render jsonObject*/
        render jsonStr
    }

    /**
     * 获取新闻公告详情
     */
    def getDetailById(){
        //获取公告详情
        String url = "http://218.84.107.54:8081/sqService/news";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getDetailById");
        String newsId = request.getParameter("newsId")
        if(newsId){
            dataMap.put("newsId", newsId);
        }
        dataMap.put("charset", "utf-8");
        //得到公告详情
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        //System.out.println("返回信息为："+jsonStr);
        /*JSONObject jsonObject = JSONObject.fromObject(jsonStr);
        render jsonObject*/
        render jsonStr
    }

    /**
     * 获取服务类型列表
     */
    def getFwlxList(){
        //获取服务类型列表
        String url = "http://218.84.107.54:8081/sqService/communityService";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getFwlxList");
        dataMap.put("charset", "utf-8");
        //得到服务类型列表
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        //JSONObject jsonObject = JSONObject.fromObject(jsonStr);

        render jsonStr
    }

    /**
     * 根据服务类型获取对应的服务列表
     */
    def getSqfwListByLxId(){
        //根据服务类型获取服务列表
        String url = "http://218.84.107.54:8081/sqService/communityService";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getSqfwListByLxId");
        String communityId = request.getParameter("communityId")//Community表Id
        if(communityId){
            Community community = Community.get(communityId)
            dataMap.put("ssqu", community.code);
        }

        dataMap.put("lxId", request.getParameter("lxId"));
        String page_size = request.getParameter("page_size")
        if(page_size){
            dataMap.put("pageSize", page_size);
        }
        String page_num = request.getParameter("page_num")
        if(page_num){
            dataMap.put("pageNo", page_num);
        }
        dataMap.put("charset", "utf-8");
        //得到服务列表
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        //JSONObject jsonObject = JSONObject.fromObject(jsonStr);

        render jsonStr
    }

    /**
     * 获取社区服务详情
     */
    def getDetailBySqfwId(){
        //获取社区服务详情
        String url = "http://218.84.107.54:8081/sqService/communityService";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getDetailBySqfwId");
        //dataMap.put("sqfwId", params.toString('sqfwId'));
        dataMap.put("sqfwId", request.getParameter("sqfwId"));
        dataMap.put("charset", "utf-8");
        //得到社区服务详情
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        //System.out.println("返回信息为："+jsonStr);
        //JSONObject jsonObject = JSONObject.fromObject(jsonStr);

        render jsonStr
    }

    /**
     * 根据社区服务ID获取数据
     */
    def getDataBySqfwId(){
        //获取社区服务详情
        String url = "http://218.84.107.54:8081/sqService/communityService";
        //参数
        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("method", "getDetailBySqfwId");
        dataMap.put("sqfwId", request.getParameter("sqfwId"));
        dataMap.put("charset", "utf-8");
        //得到社区服务详情
        String jsonStr = HttpUtil.postToURL(url, null, dataMap);
        //System.out.println("返回信息为："+jsonStr);
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
        render dataMap2
    }
}
