package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

/* compiled from: FragmentManager */
final class FragmentManagerState implements Parcelable {
    public static final Creator<FragmentManagerState> CREATOR = new C00231();
    FragmentState[] mActive;
    int[] mAdded;
    BackStackState[] mBackStack;
    int mPrimaryNavActiveIndex = -1;

    /* compiled from: FragmentManager */
    static class C00231 implements Creator<FragmentManagerState> {
        C00231() {
        }

        public FragmentManagerState createFromParcel(Parcel in) {
            return new FragmentManagerState(in);
        }

        public FragmentManagerState[] newArray(int size) {
            return new FragmentManagerState[size];
        }
    }

    public FragmentManagerState(Parcel in) {
        this.mActive = (FragmentState[]) in.createTypedArray(FragmentState.CREATOR);
        this.mAdded = in.createIntArray();
        this.mBackStack = (BackStackState[]) in.createTypedArray(BackStackState.CREATOR);
        this.mPrimaryNavActiveIndex = in.readInt();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeTypedArray(this.mActive, flags);
        dest.writeIntArray(this.mAdded);
        dest.writeTypedArray(this.mBackStack, flags);
        dest.writeInt(this.mPrimaryNavActiveIndex);
    }
}
