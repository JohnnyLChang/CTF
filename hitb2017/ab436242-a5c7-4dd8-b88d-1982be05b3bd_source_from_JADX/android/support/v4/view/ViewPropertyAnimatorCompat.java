package android.support.v4.view;

import android.annotation.TargetApi;
import android.os.Build.VERSION;
import android.view.View;
import android.view.animation.Interpolator;
import java.lang.ref.WeakReference;

public final class ViewPropertyAnimatorCompat {
    static final ViewPropertyAnimatorCompatImpl IMPL;
    static final int LISTENER_TAG_ID = 2113929216;
    private static final String TAG = "ViewAnimatorCompat";
    Runnable mEndAction = null;
    int mOldLayerType = -1;
    Runnable mStartAction = null;
    private WeakReference<View> mView;

    interface ViewPropertyAnimatorCompatImpl {
        Interpolator getInterpolator(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view);

        void setListener(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, ViewPropertyAnimatorListener viewPropertyAnimatorListener);

        void setUpdateListener(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, ViewPropertyAnimatorUpdateListener viewPropertyAnimatorUpdateListener);

        void translationZ(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, float f);

        void translationZBy(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, float f);

        void withEndAction(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, Runnable runnable);

        void withLayer(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view);

        void withStartAction(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, Runnable runnable);

        void mo549z(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, float f);

        void zBy(ViewPropertyAnimatorCompat viewPropertyAnimatorCompat, View view, float f);
    }

    static class ViewPropertyAnimatorCompatBaseImpl implements ViewPropertyAnimatorCompatImpl {

        static class MyVpaListener implements ViewPropertyAnimatorListener {
            boolean mAnimEndCalled;
            ViewPropertyAnimatorCompat mVpa;

            MyVpaListener(ViewPropertyAnimatorCompat vpa) {
                this.mVpa = vpa;
            }

            public void onAnimationStart(View view) {
                this.mAnimEndCalled = false;
                if (this.mVpa.mOldLayerType >= 0) {
                    view.setLayerType(2, null);
                }
                if (this.mVpa.mStartAction != null) {
                    Runnable startAction = this.mVpa.mStartAction;
                    this.mVpa.mStartAction = null;
                    startAction.run();
                }
                ViewPropertyAnimatorListener listenerTag = view.getTag(ViewPropertyAnimatorCompat.LISTENER_TAG_ID);
                ViewPropertyAnimatorListener listener = null;
                if (listenerTag instanceof ViewPropertyAnimatorListener) {
                    listener = listenerTag;
                }
                if (listener != null) {
                    listener.onAnimationStart(view);
                }
            }

            public void onAnimationEnd(View view) {
                if (this.mVpa.mOldLayerType >= 0) {
                    view.setLayerType(this.mVpa.mOldLayerType, null);
                    this.mVpa.mOldLayerType = -1;
                }
                if (VERSION.SDK_INT >= 16 || !this.mAnimEndCalled) {
                    if (this.mVpa.mEndAction != null) {
                        Runnable endAction = this.mVpa.mEndAction;
                        this.mVpa.mEndAction = null;
                        endAction.run();
                    }
                    ViewPropertyAnimatorListener listenerTag = view.getTag(ViewPropertyAnimatorCompat.LISTENER_TAG_ID);
                    ViewPropertyAnimatorListener listener = null;
                    if (listenerTag instanceof ViewPropertyAnimatorListener) {
                        listener = listenerTag;
                    }
                    if (listener != null) {
                        listener.onAnimationEnd(view);
                    }
                    this.mAnimEndCalled = true;
                }
            }

            public void onAnimationCancel(View view) {
                ViewPropertyAnimatorListener listenerTag = view.getTag(ViewPropertyAnimatorCompat.LISTENER_TAG_ID);
                ViewPropertyAnimatorListener listener = null;
                if (listenerTag instanceof ViewPropertyAnimatorListener) {
                    listener = listenerTag;
                }
                if (listener != null) {
                    listener.onAnimationCancel(view);
                }
            }
        }

        ViewPropertyAnimatorCompatBaseImpl() {
        }

        public void setListener(ViewPropertyAnimatorCompat vpa, View view, ViewPropertyAnimatorListener listener) {
            view.setTag(ViewPropertyAnimatorCompat.LISTENER_TAG_ID, listener);
            ViewPropertyAnimatorCompatICS.setListener(view, new MyVpaListener(vpa));
        }

        public void withEndAction(ViewPropertyAnimatorCompat vpa, View view, Runnable runnable) {
            ViewPropertyAnimatorCompatICS.setListener(view, new MyVpaListener(vpa));
            vpa.mEndAction = runnable;
        }

        public void withStartAction(ViewPropertyAnimatorCompat vpa, View view, Runnable runnable) {
            ViewPropertyAnimatorCompatICS.setListener(view, new MyVpaListener(vpa));
            vpa.mStartAction = runnable;
        }

        public void withLayer(ViewPropertyAnimatorCompat vpa, View view) {
            vpa.mOldLayerType = view.getLayerType();
            ViewPropertyAnimatorCompatICS.setListener(view, new MyVpaListener(vpa));
        }

        public Interpolator getInterpolator(ViewPropertyAnimatorCompat vpa, View view) {
            return null;
        }

        public void mo549z(ViewPropertyAnimatorCompat vpa, View view, float value) {
        }

        public void zBy(ViewPropertyAnimatorCompat vpa, View view, float value) {
        }

        public void translationZ(ViewPropertyAnimatorCompat vpa, View view, float value) {
        }

        public void translationZBy(ViewPropertyAnimatorCompat vpa, View view, float value) {
        }

        public void setUpdateListener(ViewPropertyAnimatorCompat vpa, View view, ViewPropertyAnimatorUpdateListener listener) {
        }
    }

    @TargetApi(16)
    static class ViewPropertyAnimatorCompatApi16Impl extends ViewPropertyAnimatorCompatBaseImpl {
        ViewPropertyAnimatorCompatApi16Impl() {
        }

        public void setListener(ViewPropertyAnimatorCompat vpa, View view, ViewPropertyAnimatorListener listener) {
            ViewPropertyAnimatorCompatJB.setListener(view, listener);
        }

        public void withStartAction(ViewPropertyAnimatorCompat vpa, View view, Runnable runnable) {
            view.animate().withStartAction(runnable);
        }

        public void withEndAction(ViewPropertyAnimatorCompat vpa, View view, Runnable runnable) {
            view.animate().withEndAction(runnable);
        }

        public void withLayer(ViewPropertyAnimatorCompat vpa, View view) {
            view.animate().withLayer();
        }
    }

    @TargetApi(18)
    static class ViewPropertyAnimatorCompatApi18Impl extends ViewPropertyAnimatorCompatApi16Impl {
        ViewPropertyAnimatorCompatApi18Impl() {
        }

        public Interpolator getInterpolator(ViewPropertyAnimatorCompat vpa, View view) {
            return (Interpolator) view.animate().getInterpolator();
        }
    }

    @TargetApi(19)
    static class ViewPropertyAnimatorCompatApi19Impl extends ViewPropertyAnimatorCompatApi18Impl {
        ViewPropertyAnimatorCompatApi19Impl() {
        }

        public void setUpdateListener(ViewPropertyAnimatorCompat vpa, View view, ViewPropertyAnimatorUpdateListener listener) {
            ViewPropertyAnimatorCompatKK.setUpdateListener(view, listener);
        }
    }

    @TargetApi(21)
    static class ViewPropertyAnimatorCompatApi21Impl extends ViewPropertyAnimatorCompatApi19Impl {
        ViewPropertyAnimatorCompatApi21Impl() {
        }

        public void translationZ(ViewPropertyAnimatorCompat vpa, View view, float value) {
            view.animate().translationZ(value);
        }

        public void translationZBy(ViewPropertyAnimatorCompat vpa, View view, float value) {
            view.animate().translationZBy(value);
        }

        public void mo549z(ViewPropertyAnimatorCompat vpa, View view, float value) {
            view.animate().z(value);
        }

        public void zBy(ViewPropertyAnimatorCompat vpa, View view, float value) {
            view.animate().zBy(value);
        }
    }

    ViewPropertyAnimatorCompat(View view) {
        this.mView = new WeakReference(view);
    }

    static {
        if (VERSION.SDK_INT >= 21) {
            IMPL = new ViewPropertyAnimatorCompatApi21Impl();
        } else if (VERSION.SDK_INT >= 19) {
            IMPL = new ViewPropertyAnimatorCompatApi19Impl();
        } else if (VERSION.SDK_INT >= 18) {
            IMPL = new ViewPropertyAnimatorCompatApi18Impl();
        } else if (VERSION.SDK_INT >= 16) {
            IMPL = new ViewPropertyAnimatorCompatApi16Impl();
        } else {
            IMPL = new ViewPropertyAnimatorCompatBaseImpl();
        }
    }

    public ViewPropertyAnimatorCompat setDuration(long value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().setDuration(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat alpha(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().alpha(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat alphaBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().alphaBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat translationX(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().translationX(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat translationY(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().translationY(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat withEndAction(Runnable runnable) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.withEndAction(this, view, runnable);
        }
        return this;
    }

    public long getDuration() {
        View view = (View) this.mView.get();
        if (view != null) {
            return view.animate().getDuration();
        }
        return 0;
    }

    public ViewPropertyAnimatorCompat setInterpolator(Interpolator value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().setInterpolator(value);
        }
        return this;
    }

    public Interpolator getInterpolator() {
        View view = (View) this.mView.get();
        if (view != null) {
            return IMPL.getInterpolator(this, view);
        }
        return null;
    }

    public ViewPropertyAnimatorCompat setStartDelay(long value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().setStartDelay(value);
        }
        return this;
    }

    public long getStartDelay() {
        View view = (View) this.mView.get();
        if (view != null) {
            return view.animate().getStartDelay();
        }
        return 0;
    }

    public ViewPropertyAnimatorCompat rotation(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().rotation(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat rotationBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().rotationBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat rotationX(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().rotationX(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat rotationXBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().rotationXBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat rotationY(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().rotationY(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat rotationYBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().rotationYBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat scaleX(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().scaleX(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat scaleXBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().scaleXBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat scaleY(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().scaleY(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat scaleYBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().scaleYBy(value);
        }
        return this;
    }

    public void cancel() {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().cancel();
        }
    }

    public ViewPropertyAnimatorCompat m1x(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().x(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat xBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().xBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat m2y(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().y(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat yBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().yBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat translationXBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().translationXBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat translationYBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().translationYBy(value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat translationZBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.translationZBy(this, view, value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat translationZ(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.translationZ(this, view, value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat m3z(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.mo549z(this, view, value);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat zBy(float value) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.zBy(this, view, value);
        }
        return this;
    }

    public void start() {
        View view = (View) this.mView.get();
        if (view != null) {
            view.animate().start();
        }
    }

    public ViewPropertyAnimatorCompat withLayer() {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.withLayer(this, view);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat withStartAction(Runnable runnable) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.withStartAction(this, view, runnable);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat setListener(ViewPropertyAnimatorListener listener) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.setListener(this, view, listener);
        }
        return this;
    }

    public ViewPropertyAnimatorCompat setUpdateListener(ViewPropertyAnimatorUpdateListener listener) {
        View view = (View) this.mView.get();
        if (view != null) {
            IMPL.setUpdateListener(this, view, listener);
        }
        return this;
    }
}
