package android.support.v4.app;

import android.support.annotation.RequiresApi;
import android.text.Html;

@RequiresApi(16)
class ShareCompatJB {
    ShareCompatJB() {
    }

    public static String escapeHtml(CharSequence html) {
        return Html.escapeHtml(html);
    }
}
