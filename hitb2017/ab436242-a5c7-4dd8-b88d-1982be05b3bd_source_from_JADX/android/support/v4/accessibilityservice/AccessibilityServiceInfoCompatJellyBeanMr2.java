package android.support.v4.accessibilityservice;

import android.accessibilityservice.AccessibilityServiceInfo;
import android.support.annotation.RequiresApi;

@RequiresApi(18)
class AccessibilityServiceInfoCompatJellyBeanMr2 {
    AccessibilityServiceInfoCompatJellyBeanMr2() {
    }

    public static int getCapabilities(AccessibilityServiceInfo info) {
        return info.getCapabilities();
    }
}
