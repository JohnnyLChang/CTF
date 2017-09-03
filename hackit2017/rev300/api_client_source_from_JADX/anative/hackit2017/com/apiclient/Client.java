package anative.hackit2017.com.apiclient;

import anative.hackit2017.com.nativetest.R;
import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request.Builder;
import com.squareup.okhttp.RequestBody;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import org.apache.commons.codec.binary.Hex;

public class Client {
    private String SERVER_API;
    private String method;
    private HashMap<String, String> post = new HashMap();

    public Client(String method) {
        this.method = method;
        this.SERVER_API = MainActivity.INSTANCE.getResources().getString(R.string.server);
    }

    public Client addPost(String key, String value) {
        this.post.put(key, value);
        return this;
    }

    private String buildPostArgs() {
        StringBuilder builder = new StringBuilder();
        for (String key : this.post.keySet()) {
            builder.append(key + "=" + ((String) this.post.get(key)) + "&");
        }
        String request = builder.toString();
        String signedRequest = null;
        try {
            signedRequest = String.format("%s.%s", new Object[]{new String(Hex.encodeHex(MainActivity.signature(request.getBytes()))), URLEncoder.encode(request, "UTF-8")});
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return String.format("sig_body=%s&sig_version=4", new Object[]{signedRequest});
    }

    public String send() {
        try {
            return new OkHttpClient().newCall(new Builder().url(this.SERVER_API + this.method).post(RequestBody.create(MediaType.parse("text/plain"), buildPostArgs())).build()).execute().body().string();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
