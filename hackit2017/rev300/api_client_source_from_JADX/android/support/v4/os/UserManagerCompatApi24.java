package android.support.v4.os;

import android.content.Context;
import android.os.UserManager;
import android.support.annotation.RequiresApi;
import android.support.annotation.RestrictTo;
import android.support.annotation.RestrictTo.Scope;

@RequiresApi(24)
@RestrictTo({Scope.LIBRARY_GROUP})
public class UserManagerCompatApi24 {
    public static boolean isUserUnlocked(Context context) {
        return ((UserManager) context.getSystemService(UserManager.class)).isUserUnlocked();
    }
}
