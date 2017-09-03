package org.sha2017.ctf.hiddenmessage;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView((int) C0189R.layout.activity_main);
        String hidden = "The hidden message can be found in strings.xml";
    }
}
