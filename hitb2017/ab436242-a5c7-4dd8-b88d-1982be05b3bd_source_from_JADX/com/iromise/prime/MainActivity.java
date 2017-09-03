package com.iromise.prime;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    private static long f14N = ((long) Math.pow(10.0d, 16.0d));

    class C01931 implements OnClickListener {
        C01931() {
        }

        public void onClick(View view) {
            Toast.makeText(MainActivity.this, "HITB{" + MainActivity.this.CalcNumber(MainActivity.f14N) + "}", 0).show();
        }
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView((int) C0194R.layout.activity_main);
        Button start = (Button) findViewById(C0194R.id.start);
        Log.i("Number", String.valueOf(f14N));
        start.setOnClickListener(new C01931());
    }

    private Boolean isOk(long n) {
        if (n == 1) {
            return Boolean.FALSE;
        }
        if (n == 2) {
            return Boolean.TRUE;
        }
        for (long i = 2; i * i < n; i++) {
            if (n % i == 0) {
                return Boolean.FALSE;
            }
        }
        return Boolean.TRUE;
    }

    private long CalcNumber(long n) {
        long number = 0;
        for (long i = 1; i <= n; i++) {
            if (isOk(i).booleanValue()) {
                number++;
            }
        }
        return number;
    }
}
