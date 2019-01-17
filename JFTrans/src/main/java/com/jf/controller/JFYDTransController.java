package com.jf.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jf.util.LANG;
import com.jf.util.Util;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by huangpengfei on 2019/1/17.
 */
@Controller
public class JFYDTransController {

    public Map<String, String> formData = new HashMap<>();
    public Map<LANG, String> langMap = new HashMap<>();
    public ObjectMapper mapper = new ObjectMapper();

    @RequestMapping(value = "/youDaoTrans", method = RequestMethod.GET)
    @ResponseBody
    public Map trans(String text, String from, String to) {

        Map map = new HashMap();
        try {
            String result = initYDParam(text, from, to);
//            JSONObject jsonObject = new JSONObject(result);
//            Map temMap = jsonObject.toMap();

            JsonNode resultNode =  mapper.readTree(result).path("translateResult");
            String dst = resultNode.findPath("tgt").toString();
            String src = resultNode.findPath("src").toString();

            map.put("src",src);
            map.put("dst",dst);
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }

    private String initYDParam(String text, String kfrom, String kto) throws Exception{
        // 初始化参数
        setFormData(text, kfrom, kto);

        String url = "http://fanyi.youdao.com/translate_o";
        String reqUrl = Util.getUrlWithQueryString(url, formData);
        HttpPost request = new HttpPost(reqUrl);

        System.out.println(reqUrl);
        request.setHeader("Cookie","OUTFOX_SEARCH_USER_ID=819492325@10.168.1.241; JSESSIONID=aaayu6S9Te0-t_kJMebHw; OUTFOX_SEARCH_USER_ID_NCOO=727553669.6778518; DICT_SESS=v2|MiNWGDWChzY6Mwz0LUWROY0M6LRfzE0eLOfOM6Lwy0e40HwShMk5RT40Mzlh4eL0wBOMQFkLUA0OAO4JZ0feFRUMRfYGOfOA0; DICT_LOGIN=1||1547279965579; SESSION_FROM_COOKIE=unknown; DICT_UGC=be3af0da19b5c5e6aa4e17bd8d90b28a|; JSESSIONID=abcgDuN9ePdr3beZN1kHw; _ntes_nnid=71c769867ee541788c72b47e738df2a7,1547444206018; ___rl__test__cookies=1547529900556");
        request.setHeader("Referer","http://fanyi.youdao.com/");
        request.setHeader("User-Agent","Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36");

        CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(request);
        HttpEntity entity = response.getEntity();
        String result = EntityUtils.toString(entity, "utf-8");
        System.out.println(result);
        EntityUtils.consume(entity);
        response.getEntity().getContent().close();
        response.close();

        return result;
    }


//    public void setLangSupport() {
//        langMap.put(LANG.ZH, "zh-CHS");
//        langMap.put(LANG.EN, "en");
//        langMap.put(LANG.JP, "ja");
//        langMap.put(LANG.KOR, "ko");
//        langMap.put(LANG.FRA, "fr");
//        langMap.put(LANG.RU, "ru");
//    }


    public void setFormData(String text, String from, String to) {

        String slat = String.valueOf(System.currentTimeMillis() + (long)(Math.random() * 10 + 1));
        String signStr =  "fanyideskweb" + text + slat + "p09@Bn{h02_BIEe]$P^nG";
        String sign = Util.md5(signStr);

        System.out.println(slat);
        System.out.println(sign);
        formData.put("i", text);
        formData.put("from", from);
        formData.put("to", to);
        formData.put("smartresult", "dict");
        formData.put("client", "fanyideskweb");
        formData.put("salt", slat);
        formData.put("sign", sign);
        formData.put("doctype", "json");
        formData.put("version", "2.1");
        formData.put("keyfrom", "fanyi.web");
        formData.put("action", "FY_BY_CLICKBUTTION");
        formData.put("typoResult", "false");
    }

    public static void main(String args[]){

        JFYDTransController transController = new JFYDTransController();
        try{
            String result = transController.initYDParam("苹果", "zh", "en");
            ObjectMapper mapper = new ObjectMapper();
            String tgt = mapper.readTree(result).path("smartResult").findPath("type").toString();
            System.out.println(tgt);

//            JSONObject jsonObject = new JSONObject(result);
//            Map map = jsonObject.toMap();



//            Iterator it = map.keySet().iterator();
//            while (it.hasNext()){
//                String key = it.next().toString();
//                Object value = map.get(key);
//                System.out.println("key = "+key+", value = " + value);
//
//            }
//
//            System.out.println(map);
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
