package com.devyy.flutter.yim;

import android.app.Activity;
import android.app.Application;
import android.content.Context;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.devyy.flutter.yim.account.SplashActivity;
import com.devyy.flutter.yim.emoticon.EmotionKit;
import com.taobao.idlefish.flutterboost.Debuger;
import com.taobao.idlefish.flutterboost.FlutterBoostPlugin;
import com.taobao.idlefish.flutterboost.interfaces.IPlatform;

import java.util.Map;

import io.flutter.app.FlutterApplication;

/**
 * @author zhangyiyang
 * @since 2019-05-13
 */
public class MyApplication extends FlutterApplication {

    private static final String TAG = "MyApplication";

    public static Context applicationContext;
    private static MyApplication instance;

    public static MyApplication getInstance() {
        return instance;
    }

    @Override
    public void onCreate() {
        super.onCreate();

        applicationContext = this;
        instance = this;

        // 初始化 环信SDK
        YIMHelper.getInstance().init(applicationContext);

        // 初始化 EmotionKit
        EmotionKit.init(this, (context, path, imageView) ->
                Glide.with(context)
                        .load(path)
                        .centerCrop()
                        .diskCacheStrategy(DiskCacheStrategy.SOURCE)
                        .into(imageView));

        FlutterBoostPlugin.init(new IPlatform() {
            @Override
            public Application getApplication() {
                return MyApplication.this;
            }

            /**
             * 获取应用入口的Activity,这个Activity在应用交互期间应该是一直在栈底的
             */
            @Override
            public Activity getMainActivity() {
                if (SplashActivity.sRef != null) {
                    return SplashActivity.sRef.get();
                }

                return null;
            }

            @Override
            public boolean isDebug() {
                return true;
            }

            /**
             * 如果flutter想打开一个本地页面，将会回调这个方法，页面参数将会拼接在url中
             *
             * 例如：sample://nativePage?aaa=bbb
             *
             * 参数就是类似 aaa=bbb 这样的键值对
             */
            @Override
            public boolean startActivity(Context context, String url, int requestCode) {
                Debuger.log("startActivity url=" + url);

                return PageRouter.openPageByUrl(context, url, requestCode);
            }

            @Override
            public Map getSettings() {
                return null;
            }
        });
    }
}
