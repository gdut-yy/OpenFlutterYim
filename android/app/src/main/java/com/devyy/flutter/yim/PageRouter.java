package com.devyy.flutter.yim;

import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;

import com.devyy.flutter.yim.view.activity.ChatActivityTo1;
import com.devyy.flutter.yim.view.activity.ChatActivityTo2;
import com.devyy.flutter.yim.view.activity.SettingActivity;

/**
 * 全局路由配置
 * 用于 NATIVE => FLUTTER, FLUTTER => NATIVE
 *
 * @author zhangyiyang
 * @since 2019-03-16
 */
public class PageRouter {

    /**
     * Flutter主页
     */
    public static final String FLUTTER_PAGE_URL = "sample://flutterPage";
    public static final String FLUTTER_FRAGMENT_PAGE_URL = "sample://flutterFragmentPage";
    /**
     * 设置页面
     */
    public static final String NATIVE_SETTING_PAGE_URL = "sample://nativeSettingPage";
    /**
     * TO kolzb001
     */
    public static final String NATIVE_CHAT_TO_KOLZB001_PAGE_URL = "sample://nativeChatTo1Page";
    /**
     * TO kolzb002
     */
    public static final String NATIVE_CHAT_TO_KOLZB002_PAGE_URL = "sample://nativeChatTo2Page";


    public static boolean openPageByUrl(Context context, String url) {
        return openPageByUrl(context, url, 0);
    }

    public static boolean openPageByUrl(Context context, String url, int requestCode) {
        try {
            if (url.startsWith(FLUTTER_PAGE_URL)) {
                context.startActivity(new Intent(context, FlutterPageActivity.class));
                return true;
            } else if (url.startsWith(FLUTTER_FRAGMENT_PAGE_URL)) {
                context.startActivity(new Intent(context, FlutterFragmentPageActivity.class));
                return true;
            } else if (TextUtils.equals(url, NATIVE_SETTING_PAGE_URL)) {
                context.startActivity(new Intent(context, SettingActivity.class));
                return true;
            } else if (TextUtils.equals(url, NATIVE_CHAT_TO_KOLZB001_PAGE_URL)) {
                context.startActivity(new Intent(context, ChatActivityTo1.class));
                return true;
            } else if (TextUtils.equals(url, NATIVE_CHAT_TO_KOLZB002_PAGE_URL)) {
                context.startActivity(new Intent(context, ChatActivityTo2.class));
                return true;
            } else {
                return false;
            }
        } catch (Throwable t) {
            return false;
        }
    }
}
