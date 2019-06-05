package com.devyy.flutter.yim.emoticon;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Rect;
import android.os.Build;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.LinearLayout;

/**
 * EmoticonKeyBoard 仿微信表情软键盘
 */
public class EmoticonKeyBoard {

    private static final String SHAREPREFERENCE_NAME = "EmoticonKeyBoard";
    private static final String SHAREPREFERENCE_SOFT_INPUT_HEIGHT = "soft_height";

    private Activity mActivity;
    private InputMethodManager mInputMethodManager;
    private SharedPreferences mSharedPreferences;
    private View mEmotionLayout;
    private EditText mEditText;
    private View mContentView;

    private OnEmotionButtonOnClickListener mOnEmotionButtonOnClickListener;

    public static EmoticonKeyBoard with(Activity activity) {
        EmoticonKeyBoard emotionKeyBoard = new EmoticonKeyBoard();
        emotionKeyBoard.mActivity = activity;
        emotionKeyBoard.mInputMethodManager = (InputMethodManager) activity
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        emotionKeyBoard.mSharedPreferences = activity.getSharedPreferences(SHAREPREFERENCE_NAME, Context.MODE_PRIVATE);
        return emotionKeyBoard;
    }

    public EmoticonKeyBoard bindToContent(View contentView) {
        mContentView = contentView;
        return this;
    }

    public EmoticonKeyBoard bindToEditText(EditText editText) {
        mEditText = editText;
        mEditText.requestFocus();
        mEditText.setOnTouchListener((v, event) -> {
            if (event.getAction() == MotionEvent.ACTION_UP && mEmotionLayout.isShown()) {
                lockContentHeight();// 显示软件盘时，锁定内容高度，防止跳闪。
                hideEmotionLayout(true);// 隐藏表情布局，显示软件盘
                // 软件盘显示后，释放内容高度
                mEditText.postDelayed(() -> unlockContentHeightDelayed(), 200L);
            }
            return false;
        });
        return this;
    }

    public EmoticonKeyBoard bindToEmotionButton(View... emotionButton) {
        for (View view : emotionButton) {
            view.setOnClickListener(getOnEmotionButtonOnClickListener());
        }
        return this;
    }

    /**
     * 设置表情内容布局
     */
    public EmoticonKeyBoard setEmotionLayout(View emotionLayout) {
        mEmotionLayout = emotionLayout;
        return this;
    }

    public EmoticonKeyBoard build() {
        // 设置软件盘的模式：SOFT_INPUT_ADJUST_RESIZE  这个属性表示Activity的主窗口总是会被调整大小，从而保证软键盘显示空间。
        // 从而方便我们计算软件盘的高度
        mActivity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN |
                WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
        // 隐藏软件盘
        hideSoftInput();
        return this;
    }

    /**
     * 点击返回键时先隐藏表情布局
     */
    public boolean interceptBackPress() {
        if (mEmotionLayout.isShown()) {
            hideEmotionLayout(false);
            return true;
        }
        return false;
    }

    private void showEmotionLayout() {
        int softInputHeight = getSupportSoftInputHeight();
        if (softInputHeight == 0) {
            softInputHeight = mSharedPreferences.getInt(SHAREPREFERENCE_SOFT_INPUT_HEIGHT, dip2Px(270));
        }
        hideSoftInput();
        mEmotionLayout.getLayoutParams().height = softInputHeight;
        mEmotionLayout.setVisibility(View.VISIBLE);
    }

    private int dip2Px(int dip) {
        float density = mActivity.getApplicationContext().getResources().getDisplayMetrics().density;
        int px = (int) (dip * density + 0.5f);
        return px;
    }

    /**
     * 获取软件盘的高度
     */
    private int getSupportSoftInputHeight() {
        Rect r = new Rect();
        /**
         * decorView是window中的最顶层view，可以从window中通过getDecorView获取到decorView。
         * 通过decorView获取到程序显示的区域，包括标题栏，但不包括状态栏。
         */
        mActivity.getWindow().getDecorView().getWindowVisibleDisplayFrame(r);
        //获取屏幕的高度
        int screenHeight = mActivity.getWindow().getDecorView().getRootView().getHeight();
        //计算软件盘的高度
        int softInputHeight = screenHeight - r.bottom;
        /**
         * 某些Android版本下，没有显示软键盘时减出来的高度总是144，而不是零，
         * 这是因为高度是包括了虚拟按键栏的(例如华为系列)，所以在API Level高于20时，
         * 我们需要减去底部虚拟按键栏的高度（如果有的话）
         */
//        if (Build.VERSION.SDK_INT >= 20) {
//            // When SDK Level >= 20 (Android L), the softInputHeight will contain the height of softButtonsBar (if has)
//            softInputHeight = softInputHeight - getSoftButtonsBarHeight();
//        }
        if (softInputHeight < 0) {
            Log.w("LQR", "EmotionKeyboard--Warning: value of softInputHeight is below zero!");
        }
        //存一份到本地
        if (softInputHeight > 0) {
            mSharedPreferences.edit().putInt(SHAREPREFERENCE_SOFT_INPUT_HEIGHT, softInputHeight).apply();
        }
        return softInputHeight;
    }

    private View.OnClickListener getOnEmotionButtonOnClickListener() {
        return v -> {
            if (mOnEmotionButtonOnClickListener != null) {
                if (mOnEmotionButtonOnClickListener.onEmotionButtonOnClickListener(v)) {
                    return;
                }
            }

            if (mEmotionLayout.isShown()) {
                lockContentHeight();//显示软件盘时，锁定内容高度，防止跳闪。
                hideEmotionLayout(true);//隐藏表情布局，显示软件盘
                unlockContentHeightDelayed();//软件盘显示后，释放内容高度
            } else {
                if (isSoftInputShown()) {//同上
                    lockContentHeight();
                    showEmotionLayout();
                    unlockContentHeightDelayed();
                } else {
                    showEmotionLayout();//两者都没显示，直接显示表情布局
                }
            }
        };
    }


    public void setOnEmotionButtonOnClickListener(OnEmotionButtonOnClickListener onEmotionButtonOnClickListener) {
        mOnEmotionButtonOnClickListener = onEmotionButtonOnClickListener;
    }

    /**
     * 隐藏表情布局
     *
     * @param showSoftInput 是否显示软件盘
     */
    private void hideEmotionLayout(boolean showSoftInput) {
        if (mEmotionLayout.isShown()) {
            mEmotionLayout.setVisibility(View.GONE);
            if (showSoftInput) {
                showSoftInput();
            }
        }
    }

    /**
     * 锁定内容高度，防止跳闪
     */
    private void lockContentHeight() {
        LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) mContentView.getLayoutParams();
        params.height = mContentView.getHeight();
        params.weight = 0.0F;
    }

    /**
     * 释放被锁定的内容高度
     */
    public void unlockContentHeightDelayed() {
        mEditText.postDelayed(() -> ((LinearLayout.LayoutParams) mContentView.getLayoutParams()).weight = 1.0F, 200L);
    }

    /**
     * 编辑框获取焦点，并显示软件盘
     */
    public void showSoftInput() {
        mEditText.requestFocus();
        mEditText.post(() -> mInputMethodManager.showSoftInput(mEditText, 0));
    }

    /**
     * 隐藏软件盘
     */
    public void hideSoftInput() {
        mInputMethodManager.hideSoftInputFromWindow(mEditText.getWindowToken(), 0);
    }

    /**
     * 是否显示软件盘
     */
    public boolean isSoftInputShown() {
        return getSupportSoftInputHeight() != 0;
    }

    /**
     * 底部虚拟按键栏的高度
     */
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    private int getSoftButtonsBarHeight() {
        DisplayMetrics metrics = new DisplayMetrics();
        //这个方法获取可能不是真实屏幕的高度
        mActivity.getWindowManager().getDefaultDisplay().getMetrics(metrics);
        int usableHeight = metrics.heightPixels;
        //获取当前屏幕的真实高度
        mActivity.getWindowManager().getDefaultDisplay().getRealMetrics(metrics);
        int realHeight = metrics.heightPixels;
        if (realHeight > usableHeight) {
            return realHeight - usableHeight;
        } else {
            return 0;
        }
    }

    /**
     * 获取软键盘高度
     */
    public int getKeyBoardHeight() {
        return mSharedPreferences.getInt(SHAREPREFERENCE_SOFT_INPUT_HEIGHT, 400);
    }

}
