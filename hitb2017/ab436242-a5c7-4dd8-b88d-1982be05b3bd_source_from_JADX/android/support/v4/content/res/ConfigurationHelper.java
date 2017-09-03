package android.support.v4.content.res;

import android.content.res.Resources;
import android.os.Build.VERSION;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;

public final class ConfigurationHelper {
    private static final ConfigurationHelperBaseImpl IMPL;

    private static class ConfigurationHelperBaseImpl {
        private ConfigurationHelperBaseImpl() {
        }

        public int getDensityDpi(@NonNull Resources resources) {
            return resources.getDisplayMetrics().densityDpi;
        }
    }

    @RequiresApi(17)
    private static class ConfigurationHelperApi17Impl extends ConfigurationHelperBaseImpl {
        private ConfigurationHelperApi17Impl() {
            super();
        }

        public int getDensityDpi(@NonNull Resources resources) {
            return ConfigurationHelperJellybeanMr1.getDensityDpi(resources);
        }
    }

    static {
        if (VERSION.SDK_INT >= 17) {
            IMPL = new ConfigurationHelperApi17Impl();
        } else {
            IMPL = new ConfigurationHelperBaseImpl();
        }
    }

    private ConfigurationHelper() {
    }

    @Deprecated
    public static int getScreenHeightDp(@NonNull Resources resources) {
        return resources.getConfiguration().screenHeightDp;
    }

    @Deprecated
    public static int getScreenWidthDp(@NonNull Resources resources) {
        return resources.getConfiguration().screenWidthDp;
    }

    @Deprecated
    public static int getSmallestScreenWidthDp(@NonNull Resources resources) {
        return resources.getConfiguration().smallestScreenWidthDp;
    }

    public static int getDensityDpi(@NonNull Resources resources) {
        return IMPL.getDensityDpi(resources);
    }
}
