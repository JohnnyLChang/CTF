package anative.hackit2017.com.apiclient;

import anative.hackit2017.com.nativetest.R;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    public static MainActivity INSTANCE = null;
    public static String regKey = null;

    class C00021 implements OnClickListener {
        C00021() {
        }

        public void onClick(View view) {
            Api.register(((TextView) MainActivity.this.findViewById(R.id.editText2)).getText().toString());
        }
    }

    class C00032 implements OnClickListener {
        C00032() {
        }

        public void onClick(View view) {
            Api.getInfo();
        }
    }

    public static native byte[] signature(byte[] bArr);

    static {
        System.loadLibrary("signatures");
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView((int) R.layout.activity_main);
        INSTANCE = this;
        findViewById(R.id.button).setOnClickListener(new C00021());
        findViewById(R.id.button3).setOnClickListener(new C00032());
    }

    public static void toast(String msg) {
        Toast.makeText(INSTANCE, msg, 0).show();
    }
}
