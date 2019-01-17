package com.jf.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.util.*;

/**
 * Created by huangpengfei on 2019/1/16.
 */

@Controller
public class JFBDTransController {

    public ObjectMapper mapper = new ObjectMapper();

    @RequestMapping(value = "/baiduTrans", method = RequestMethod.GET)
    @ResponseBody
    public Map trans(String text, String from, String to) {

        Map map = new HashMap();
        try {
            String result = initBDParam(text, from, to);
//            JSONObject jsonObject = new JSONObject(result);
//            Map temMap = jsonObject.toMap();
//            HashMap transResult = (HashMap)(temMap.get("trans_result"));
//            HashMap data = (HashMap)((ArrayList)transResult.get("data")).get(0);

            JsonNode node = mapper.readTree(result).path("trans_result").path("data");
            String src = node.findPath("src").toString();
            String dst = node.findPath("dst").toString();
            map.put("src",src);
            map.put("dst",dst);
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }


    private String initBDParam(String text, String kfrom, String kto) throws Exception{
        String from = kfrom;//"zh";
        String to = kto;//"en";
        String q = text;
        String token = "0c5f74e92e7af1001fe8e40457367301";
        String gtk = "320305.131321201";
        String url = "https://fanyi.baidu.com/v2transapi";
        String sign = token(q, gtk);

        Map<String, String> params = new HashMap<>();
        params.put("from", from);
        params.put("to", to);
        params.put("query", q);
        params.put("transtype", "translang");
        params.put("simple_means_flag", "3");
        params.put("sign", sign);
        params.put("token", token);

        CloseableHttpClient httpClient = HttpClients.createDefault();

//        HttpPost request = new HttpPost(url);
//        request.setEntity(new UrlEncodedFormEntity(Main.map2list(params), "UTF-8"));
        HttpPost request = new HttpPost(Util.getUrlWithQueryString(url, params));
        request.setHeader("Cookie", "BAIDUID=5D2CC11E270B40D6F09AB748380FC118:FG=1; BIDUPSID=5D2CC11E270B40D6F09AB748380FC118; PSTM=1544162795; BDUSS=1nSXJqaGZlMTRlcEFvVFRCellieFQ3QnhXeENsMTJKNFEzeVdGT3J4ckc4VEZjQVFBQUFBJCQAAAAAAAAAAAEAAAACea43cHJvZ3JhbXNfMTIzAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMZkClzGZApcdU; REALTIME_TRANS_SWITCH=1; FANYI_WORD_SWITCH=1; HISTORY_SWITCH=1; SOUND_SPD_SWITCH=1; SOUND_PREFER_SWITCH=1; BDRCVFR[feWj1Vr5u3D]=I67x6TjHwwYf0; delPer=0; PSINO=2; BDRCVFR[SsB3xVCBoFf]=Ae1_MfEv1LYmLPbUB48ugf; locale=zh; Hm_lvt_64ecd82404c51e03dc91cb9e8c025574=1547280317,1547280727,1547280921,1547282858; H_PS_PSSID=1463_27211_21115_28132_28267_20719; to_lang_often=%5B%7B%22value%22%3A%22en%22%2C%22text%22%3A%22%u82F1%u8BED%22%7D%2C%7B%22value%22%3A%22zh%22%2C%22text%22%3A%22%u4E2D%u6587%22%7D%5D; from_lang_often=%5B%7B%22value%22%3A%22zh%22%2C%22text%22%3A%22%u4E2D%u6587%22%7D%2C%7B%22value%22%3A%22en%22%2C%22text%22%3A%22%u82F1%u8BED%22%7D%5D; Hm_lpvt_64ecd82404c51e03dc91cb9e8c025574=1547430180");
        request.setHeader("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36");

        CloseableHttpResponse response = httpClient.execute(request);
        HttpEntity entity = response.getEntity();
        String result = EntityUtils.toString(entity, "utf-8");
        EntityUtils.consume(entity);
        response.getEntity().getContent().close();
        response.close();

        return result;
    }

    private  String token(String value, String sign) {
        String result = "";
        ScriptEngine engine = new ScriptEngineManager().getEngineByName("js");

        try {
            FileReader reader = new FileReader("/Users/work/JFTrans/src/main/resources/TransJS/Baidu.js");
            engine.eval(reader);

            if (engine instanceof Invocable) {
                Invocable invoke = (Invocable)engine;
                result = String.valueOf(invoke.invokeFunction("token", value, sign));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String args[]){

        JFBDTransController transController = new JFBDTransController();
        try{
            String result = transController.initBDParam("苹果", "zh", "en");
//            String result = "{\n" +
//                    "\"trans_result\":{\n" +
//                    "\"data\":[\n" +
//                    "{\"src\":1,\"dst\":\"apple1\"},\n" +
//                    "{\"src\":2,\"dst\":\"apple2\"},\n" +
//                    "{\"src\":3,\"dst\":\"apple3\"},\n" +
//                    "{\"src\":4,\"dst\":\"apple4\"}\n" +
//                    "]\n" +
//                    "}\n" +
//                    "}";
            System.out.println(result);

            JsonNode node = transController.mapper.readTree(result).path("trans_result").path("data");
            String src = node.findPath("src").toString();
            String dst = node.findPath("dst").toString();
            System.out.println("src = "+src+" dst = " + dst);

        }catch (Exception e){
            e.printStackTrace();
        }

    }

}
