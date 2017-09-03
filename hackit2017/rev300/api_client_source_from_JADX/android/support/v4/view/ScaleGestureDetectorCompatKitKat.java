package android.support.v4.view;

import android.support.annotation.RequiresApi;
import android.view.ScaleGestureDetector;

@RequiresApi(19)
class ScaleGestureDetectorCompatKitKat {
    private ScaleGestureDetectorCompatKitKat() {
    }

    public static void setQuickScaleEnabled(Object scaleGestureDetector, boolean enabled) {
        ((ScaleGestureDetector) scaleGestureDetector).setQuickScaleEnabled(enabled);
    }

    public static boolean isQuickScaleEnabled(Object scaleGestureDetector) {
        return ((ScaleGestureDetector) scaleGestureDetector).isQuickScaleEnabled();
    }
}
