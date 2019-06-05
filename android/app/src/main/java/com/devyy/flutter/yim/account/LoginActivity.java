package com.devyy.flutter.yim.account;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.devyy.flutter.yim.PageRouter;
import com.devyy.flutter.yim.R;
import com.devyy.flutter.yim.YIMHelper;
import com.hyphenate.EMCallBack;
import com.hyphenate.chat.EMClient;

/**
 * 用户登录页面
 * 环信登录功能
 *
 * @author zhangyiyang
 * @since 2019-03-16
 */
public class LoginActivity extends Activity {

    private static final String TAG = "==>LoginActivity";

    private EditText usernameEditText;
    private EditText passwordEditText;

    private boolean progressShow;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // 若已经登录
        if (YIMHelper.getInstance().isLoggedIn()) {
            boolean autoLogin = true;
            // 跳转至主页面
            PageRouter.openPageByUrl(this, PageRouter.FLUTTER_PAGE_URL);
            return;
        }

        setContentView(R.layout.em_activity_login);

        usernameEditText = (EditText) findViewById(R.id.username);
        passwordEditText = (EditText) findViewById(R.id.password);

        // 如果用户名栏变更，重置密码输入栏
        usernameEditText.addTextChangedListener(new TextWatcher() {
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                passwordEditText.setText(null);
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        passwordEditText.setOnEditorActionListener((v, actionId, event) -> {
            if (actionId == EditorInfo.IME_ACTION_DONE
                    || ((event.getKeyCode() == KeyEvent.KEYCODE_ENTER)
                    && (event.getAction() == KeyEvent.ACTION_DOWN))) {
                login(null);
                return true;
            } else {
                return false;
            }
        });
    }

    /**
     * 登录
     */
    public void login(View view) {

        String currentUsername = usernameEditText.getText().toString().trim();
        String currentPassword = passwordEditText.getText().toString().trim();

        if (TextUtils.isEmpty(currentUsername)) {
            Toast.makeText(this, "用户名不能为空", Toast.LENGTH_SHORT).show();
            return;
        }
        if (TextUtils.isEmpty(currentPassword)) {
            Toast.makeText(this, "密码不能为空", Toast.LENGTH_SHORT).show();
            return;
        }

        // ProgressDialog
        progressShow = true;
        final ProgressDialog pd = new ProgressDialog(LoginActivity.this);
        pd.setCanceledOnTouchOutside(false);
        pd.setOnCancelListener(dialog -> {
            Log.d(TAG, "EMClient.getInstance().onCancel");
            progressShow = false;
        });
        pd.setMessage("登陆ing……");
        pd.show();

        // 保存用户名
        YIMHelper.getInstance().setCurrentUserName(currentUsername);

        // call login method
        Log.d(TAG, "EMClient.getInstance().login");
        EMClient.getInstance().login(currentUsername, currentPassword, new EMCallBack() {

            @Override
            public void onSuccess() {
                Log.d(TAG, "登录成功!");

                // 加载本地会话和群组
                EMClient.getInstance().groupManager().loadAllGroups();
                EMClient.getInstance().chatManager().loadAllConversations();

                if (!LoginActivity.this.isFinishing() && pd.isShowing()) {
                    pd.dismiss();
                }

                // 跳转至主页面
                PageRouter.openPageByUrl(LoginActivity.this, PageRouter.FLUTTER_PAGE_URL);
            }

            @Override
            public void onProgress(int progress, String status) {
                Log.d(TAG, "登陆中···");
            }

            @Override
            public void onError(final int code, final String message) {
                Log.d(TAG, "登录失败: " + code);
                if (!progressShow) {
                    return;
                }
                runOnUiThread(() -> {
                    pd.dismiss();
                    Toast.makeText(getApplicationContext(), "登录失败：" + message,
                            Toast.LENGTH_SHORT).show();

                });
            }
        });
    }

    /**
     * 注册
     */
    public void register(View view) {
        startActivityForResult(new Intent(this, RegisterActivity.class), 0);
    }

    @Override
    protected void onResume() {
        super.onResume();
    }
}
