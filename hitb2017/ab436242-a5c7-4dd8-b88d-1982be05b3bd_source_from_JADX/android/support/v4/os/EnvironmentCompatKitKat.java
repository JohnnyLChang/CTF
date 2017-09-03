package android.support.v4.os;

import android.os.Environment;
import android.support.annotation.RequiresApi;
import java.io.File;

@RequiresApi(19)
class EnvironmentCompatKitKat {
    EnvironmentCompatKitKat() {
    }

    public static String getStorageState(File path) {
        return Environment.getStorageState(path);
    }
}
