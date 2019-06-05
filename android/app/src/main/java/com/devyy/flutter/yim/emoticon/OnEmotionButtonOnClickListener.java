package com.devyy.flutter.yim.emoticon;

import android.view.View;

public interface OnEmotionButtonOnClickListener {
    /**
     * 主要是为了适用仿微信的情况，微信有一个表情按钮和一个功能按钮，这2个按钮都是控制了底部区域的显隐
     *
     * @param view
     * @return true:拦截切换输入法，false:让输入法正常切换
     */
    boolean onEmotionButtonOnClickListener(View view);
}
