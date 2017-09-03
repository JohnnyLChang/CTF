package android.support.v4.view;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Rect;
import android.support.annotation.RequiresApi;
import android.support.v4.view.accessibility.AccessibilityManagerCompat;
import android.text.TextUtils;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnHoverListener;
import android.view.View.OnLongClickListener;
import android.view.ViewConfiguration;
import android.view.accessibility.AccessibilityManager;
import android.widget.Toast;

@RequiresApi(14)
class ViewCompatICS {

    private static class TooltipHandler implements OnLongClickListener, OnHoverListener {
        private final View mAnchor;
        private final Runnable mShowRunnable = new C01121();
        private Toast mTooltip;
        private final CharSequence mTooltipText;

        class C01121 implements Runnable {
            C01121() {
            }

            public void run() {
                TooltipHandler.this.show(1);
            }
        }

        TooltipHandler(View anchor, CharSequence tooltipText) {
            this.mAnchor = anchor;
            this.mTooltipText = tooltipText;
            this.mAnchor.setOnLongClickListener(this);
            this.mAnchor.setOnHoverListener(this);
        }

        public boolean onLongClick(View v) {
            show(0);
            return true;
        }

        public boolean onHover(View v, MotionEvent event) {
            AccessibilityManager manager = (AccessibilityManager) this.mAnchor.getContext().getSystemService("accessibility");
            if (!(manager.isEnabled() && AccessibilityManagerCompat.isTouchExplorationEnabled(manager))) {
                int action = event.getAction();
                if (action == 7) {
                    hide();
                    this.mAnchor.getHandler().postDelayed(this.mShowRunnable, (long) ViewConfiguration.getLongPressTimeout());
                } else if (action == 10) {
                    hide();
                }
            }
            return false;
        }

        private void show(int duration) {
            Context context = this.mAnchor.getContext();
            Resources resources = context.getResources();
            int screenWidth = resources.getDisplayMetrics().widthPixels;
            int screenHeight = resources.getDisplayMetrics().heightPixels;
            Rect displayFrame = new Rect();
            this.mAnchor.getWindowVisibleDisplayFrame(displayFrame);
            if (displayFrame.left < 0 && displayFrame.top < 0) {
                int statusBarHeight;
                int resourceId = resources.getIdentifier("status_bar_height", "dimen", "android");
                if (resourceId > 0) {
                    statusBarHeight = resources.getDimensionPixelSize(resourceId);
                } else {
                    statusBarHeight = 0;
                }
                displayFrame.set(0, statusBarHeight, screenWidth, screenHeight);
            }
            int[] anchorPos = new int[2];
            this.mAnchor.getLocationOnScreen(anchorPos);
            int referenceX = anchorPos[0] + (this.mAnchor.getWidth() / 2);
            if (ViewCompat.getLayoutDirection(this.mAnchor) == 0) {
                referenceX = screenWidth - referenceX;
            }
            int anchorTop = anchorPos[1];
            hide();
            this.mTooltip = Toast.makeText(context, this.mTooltipText, duration);
            if (((double) anchorTop) < ((double) displayFrame.height()) * 0.8d) {
                this.mTooltip.setGravity(8388661, referenceX, (this.mAnchor.getHeight() + anchorTop) - displayFrame.top);
            } else {
                this.mTooltip.setGravity(8388693, referenceX, displayFrame.bottom - anchorTop);
            }
            this.mTooltip.show();
        }

        private void hide() {
            if (this.mTooltip != null) {
                this.mTooltip.cancel();
                this.mTooltip = null;
            }
            this.mAnchor.getHandler().removeCallbacks(this.mShowRunnable);
        }
    }

    ViewCompatICS() {
    }

    public static void setTooltipText(View view, CharSequence tooltipText) {
        if (TextUtils.isEmpty(tooltipText)) {
            view.setOnLongClickListener(null);
            view.setLongClickable(false);
            view.setOnHoverListener(null);
            return;
        }
        TooltipHandler tooltipHandler = new TooltipHandler(view, tooltipText);
    }
}
