package android.support.v4.app;

import android.app.ActivityManager;
import android.support.annotation.RequiresApi;

@RequiresApi(19)
class ActivityManagerCompatKitKat {
    ActivityManagerCompatKitKat() {
    }

    public static boolean isLowRamDevice(ActivityManager am) {
        return am.isLowRamDevice();
    }
}
