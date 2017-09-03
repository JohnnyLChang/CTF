package android.support.v4.media.session;

import android.media.session.MediaController;

class MediaControllerCompatApi26 {

    public interface Callback extends android.support.v4.media.session.MediaControllerCompatApi21.Callback {
        void onRepeatModeChanged(int i);

        void onShuffleModeChanged(boolean z);
    }

    static class CallbackProxy<T extends Callback> extends CallbackProxy<T> {
        CallbackProxy(T callback) {
            super(callback);
        }

        public void onRepeatModeChanged(int repeatMode) {
            ((Callback) this.mCallback).onRepeatModeChanged(repeatMode);
        }

        public void onShuffleModeChanged(boolean enabled) {
            ((Callback) this.mCallback).onShuffleModeChanged(enabled);
        }
    }

    public static class TransportControls extends android.support.v4.media.session.MediaControllerCompatApi23.TransportControls {
        public static void setRepeatMode(Object controlsObj, int repeatMode) {
            ((android.media.session.MediaController.TransportControls) controlsObj).setRepeatMode(repeatMode);
        }

        public static void setShuffleModeEnabled(Object controlsObj, boolean enabled) {
            ((android.media.session.MediaController.TransportControls) controlsObj).setShuffleModeEnabled(enabled);
        }
    }

    MediaControllerCompatApi26() {
    }

    public static Object createCallback(Callback callback) {
        return new CallbackProxy(callback);
    }

    public static int getRepeatMode(Object controllerObj) {
        return ((MediaController) controllerObj).getRepeatMode();
    }

    public static boolean isShuffleModeEnabled(Object controllerObj) {
        return ((MediaController) controllerObj).isShuffleModeEnabled();
    }
}
