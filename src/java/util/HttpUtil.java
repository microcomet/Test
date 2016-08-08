package util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

//import org.apache.log4j.Logger;

//import config.Cfg;

/**
 * http连接工具包
 * @author Cat
 *
 */
public class HttpUtil {
	//static Logger logger = Logger.getLogger(HttpUtil.class);

	/**
	 * 发送POST请求
	 * @param url 地址
	 * @param headerMap 请求头部
	 * @param dataMap 请求参数
	 * @return String 返回值
	 */
	public static String postToURL(String url, Map<String,String> headerMap, Map<String,String> dataMap){
		try {
			System.out.println("进入测试");
			HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
			conn.setConnectTimeout(1000 * 20);
			conn.setReadTimeout(1000 * 20);
			conn.setInstanceFollowRedirects(false);
			conn.setRequestMethod("POST"); //设置请求方式
			
			conn.setRequestProperty("charset", "utf-8");//设置编码
			
			conn.setUseCaches(false);// Post 请求不能使用缓存
			
			//设置请求头部
			if(headerMap!=null && headerMap.size()>0){
				for (String key : headerMap.keySet()) {
					conn.setRequestProperty(key,headerMap.get(key));
				}
			}
			
			//打开输入、输出流
			conn.setDoOutput(true); //设置该连接是可以输出的
			conn.setDoInput(true); 
			
			//设置请求参数
			String params = "";
			if (dataMap != null && dataMap.size() > 0) {
				for (String key : dataMap.keySet()) {
					if(params.length()>0){
						params=params+"&";
					}
					
					if(key==null || key.isEmpty()){
						params=params+dataMap.get(key);
					} else{
						params=params+key+"="+dataMap.get(key);
					}
				}
			}

			conn.getOutputStream().write(params.getBytes(dataMap.get("charset")));
			conn.getOutputStream().flush();
			conn.getOutputStream().close();
			
			if (conn.getResponseCode() == 200) {
				System.out.println("连接成功");
				ByteArrayOutputStream bo = new ByteArrayOutputStream();
				byte[] buf = new byte[1024];
				int len = 0;
				while ((len = conn.getInputStream().read(buf)) > 0) {
					bo.write(buf, 0, len);
				}
				String rest = new String(bo.toByteArray(),dataMap.get("charset"));
				conn.getInputStream().close();
				return rest;
			} else {
				//logger.error("HTTP POST TO "+url);
				//logger.error("HTTP POST返回异常，ResponseCode="+conn.getResponseCode());
				System.out.println(conn.getResponseCode());
				System.out.println("连接失败");
				return null;
			}
		}
		catch (Exception e) {
			//logger.error("HTTP POST TO "+url);
			//logger.error("HTTP POST请求异常",e);
			return null;
		}
	}
	
	
	/**
	 * 发送POST请求
	 * @return String 返回值
	 */
	public static void readContentFromPost() throws IOException {
		// Post请求的url，与get不同的是不需要带参数
        URL postUrl = new URL("http://www.wangzhiqiang87.cn");
        // 打开连接
        HttpURLConnection connection = (HttpURLConnection) postUrl.openConnection();
      
        // 设置是否向connection输出，因为这个是post请求，参数要放在
        // http正文内，因此需要设为true
        connection.setDoOutput(true);
        // Read from the connection. Default is true.
        connection.setDoInput(true);
        // 默认是 GET方式
        connection.setRequestMethod("POST");
       
        // Post 请求不能使用缓存
        connection.setUseCaches(false);
       
        connection.setInstanceFollowRedirects(true);
       
        // 配置本次连接的Content-type，配置为application/x-www-form-urlencoded的
        // 意思是正文是urlencoded编码过的form参数，下面我们可以看到我们对正文内容使用URLEncoder.encode
        // 进行编码
        connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
        // 连接，从postUrl.openConnection()至此的配置必须要在connect之前完成，
        // 要注意的是connection.getOutputStream会隐含的进行connect。
        connection.connect();
        DataOutputStream out = new DataOutputStream(connection
                .getOutputStream());
        // The URL-encoded contend
        // 正文，正文内容其实跟get的URL中 '? '后的参数字符串一致
        String content = "account=" + URLEncoder.encode("一个大肥人", "UTF-8");
        content +="&pswd="+URLEncoder.encode("两个个大肥人", "UTF-8");;
        // DataOutputStream.writeBytes将字符串中的16位的unicode字符以8位的字符形式写到流里面
        out.writeBytes(content);

        out.flush();
        out.close(); 
        
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String line;
        
        while ((line = reader.readLine()) != null){
            System.out.println(line);
        }
      
        reader.close();
        connection.disconnect();
	}
	
	/**
	 * 发送GET请求
	 * @param url 地址
	 * @return String 返回结果
	 */
	public static String getToURL(String url){
		try {
			HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
			conn.setConnectTimeout(1000 * 10);
			conn.setReadTimeout(1000 * 10);
			conn.setRequestMethod("GET");
			conn.setDoInput(true);
			if (conn.getResponseCode() == 200) {
				ByteArrayOutputStream bo = new ByteArrayOutputStream();
				byte[] buf = new byte[1024];
				int len = 0;
				while ((len = conn.getInputStream().read(buf)) > 0) {
					bo.write(buf, 0, len);
				}
				
				String rest = new String(bo.toByteArray(), "utf-8");
				conn.getInputStream().close();
				return rest;
			} else {
				//logger.error("HTTP GET TO "+url);
				//logger.error("HTTP GET返回异常，ResponseCode="+conn.getResponseCode());
				return null;
			}
		} catch (Exception e) {
			//logger.error("HTTP GET TO "+url);
			//logger.error("HTTP GET请求异常",e);
			e.printStackTrace();
			return null;
		}
	}
	
	public static void main(String[] args) {
		//通过用户名字获取和用户相关联的实例
		String url = "http://192.168.2.140:8081/sqService/news";
		//头信息
//		Map<String, String> headerMap = new HashMap<String, String>();
//		headerMap.put("Content-type", "application/json");
		//参数
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("method", "getNewsList");
		dataMap.put("charset", "utf-8");

		String aa = postToURL(url, null, dataMap);

		System.out.println("返回信息为："+aa);
		
		/*try {
			readContentFromPost();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
	}
	
	
}
