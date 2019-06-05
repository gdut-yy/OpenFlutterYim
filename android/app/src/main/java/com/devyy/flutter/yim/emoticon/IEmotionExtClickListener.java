package com.devyy.flutter.yim.emoticon;

import android.view.View;

/**
 * 表情管理按钮点击事件
 */
public interface IEmotionExtClickListener {
    /**
     * "add" -> "表情商店"
     */
    void onEmotionAddClick(View view);

    /**
     * "setting" -> "我的表情"
     */
    void onEmotionSettingClick(View view);
}
