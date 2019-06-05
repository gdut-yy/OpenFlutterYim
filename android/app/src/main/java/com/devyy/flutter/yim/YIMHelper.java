package com.devyy.flutter.yim;

import android.content.Context;
import android.os.Looper;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;

import com.hyphenate.EMCallBack;
import com.hyphenate.chat.EMClient;
import com.hyphenate.chat.EMOptions;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * YIMHelper 单例
 *
 * @author zhangyiyang
 * @since 2019-03-16
 */
public class YIMHelper {

    private static final String TAG = "YIMHelper";

    /**
     * Singleton 三连
     */
    private static YIMHelper instance = null;

    private YIMHelper() {
        executor = Executors.newCachedThreadPool();
    }

    public synchronized static YIMHelper getInstance() {
        if (instance == null) {
            instance = new YIMHelper();
        }
        return instance;
    }

    private ExecutorService executor;

    public void execute(Runnable runnable) {
        executor.execute(runnable);
    }

    /**
     * 初始化 环信SDK
     *
     * @param context
     */
    public void init(Context context) {
        EMOptions options = new EMOptions();

        // 初始化 EMClient
        EMClient.getInstance().init(context, options);
    }

    /**
     * 判断是否已经登录
     *
     * @return
     */
    public boolean isLoggedIn() {
        return EMClient.getInstance().isLoggedInBefore();
    }

    private String username;

    /**
     * set current username
     *
     * @param username
     */
    public void setCurrentUserName(String username) {
        this.username = username;
    }

    /**
     * get current user's id
     */
    public String getCurrentUsernName() {
        return username;
    }


    protected android.os.Handler handler;
    private Context appContext;
    Queue<String> msgQueue = new ConcurrentLinkedQueue<>();

    public void initHandler(Looper looper) {
        handler = new android.os.Handler(looper) {
            @Override
            public void handleMessage(Message msg) {
                String str = (String) msg.obj;
                Toast.makeText(appContext, str, Toast.LENGTH_LONG).show();
            }
        };
        while (!msgQueue.isEmpty()) {
            showToast(msgQueue.remove());
        }
    }

    void showToast(final String message) {
        Log.d(TAG, "receive invitation to join the group：" + message);
        if (handler != null) {
            Message msg = Message.obtain(handler, 0, message);
            handler.sendMessage(msg);
        } else {
            msgQueue.add(message);
        }
    }

    /**
     * 用户登出
     *
     * @param unbindDeviceToken whether you need unbind your device token
     * @param callback          callback
     */
    public void logout(boolean unbindDeviceToken, final EMCallBack callback) {
        endCall();
        Log.d(TAG, "logout: " + unbindDeviceToken);
        EMClient.getInstance().logout(unbindDeviceToken, new EMCallBack() {

            @Override
            public void onSuccess() {
                Log.d(TAG, "logout: onSuccess");
                if (callback != null) {
                    callback.onSuccess();
                }

            }

            @Override
            public void onProgress(int progress, String status) {
                if (callback != null) {
                    callback.onProgress(progress, status);
                }
            }

            @Override
            public void onError(int code, String error) {
                Log.d(TAG, "logout: onSuccess");
                if (callback != null) {
                    callback.onError(code, error);
                }
            }
        });
    }

    void endCall() {
        try {
            EMClient.getInstance().callManager().endCall();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
