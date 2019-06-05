package com.devyy.flutter.yim.account;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;

import com.devyy.flutter.yim.PageRouter;
import com.devyy.flutter.yim.R;
import com.devyy.flutter.yim.YIMHelper;
import com.hyphenate.chat.EMClient;

import java.lang.ref.WeakReference;

/**
 * 应用启动页
 *
 * @author zhangyiyang
 * @since 2019-03-16
 */
public class SplashActivity extends Activity {

    public static WeakReference<SplashActivity> sRef;

    private static final int sleepTime = 2000;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        sRef = new WeakReference<>(this);

        setContentView(R.layout.em_activity_splash);
        YIMHelper.getInstance().initHandler(this.getMainLooper());
    }

    @Override
    protected void onStart() {
        super.onStart();

        new Thread(() -> {
            // 如果已经登录
            if (YIMHelper.getInstance().isLoggedIn()) {
                // auto login mode, make sure all group and conversation is loaed before enter the main screen
                long start = System.currentTimeMillis();
                EMClient.getInstance().chatManager().loadAllConversations();
                EMClient.getInstance().groupManager().loadAllGroups();
                long costTime = System.currentTimeMillis() - start;
                // wait
                if (sleepTime - costTime > 0) {
                    try {
                        Thread.sleep(sleepTime - costTime);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                // 跳转至主页面
                PageRouter.openPageByUrl(this, PageRouter.FLUTTER_PAGE_URL);
            }
            // 没有登录
            else {
                try {
                    Thread.sleep(sleepTime);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                // 跳转至登录页面
                startActivity(new Intent(SplashActivity.this, LoginActivity.class));
            }
        }).start();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        sRef.clear();
        sRef = null;
    }
}
