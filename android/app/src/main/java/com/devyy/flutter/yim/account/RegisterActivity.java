package com.devyy.flutter.yim.account;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.devyy.flutter.yim.R;
import com.devyy.flutter.yim.YIMHelper;
import com.hyphenate.EMError;
import com.hyphenate.chat.EMClient;
import com.hyphenate.exceptions.HyphenateException;

/**
 * 用户注册页面
 * 环信注册功能
 *
 * @author zhangyiyang
 * @since 2019-03-16
 */
public class RegisterActivity extends Activity {

    private EditText userNameEditText;
    private EditText passwordEditText;
    private EditText confirmPwdEditText;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.em_activity_register);

        userNameEditText = (EditText) findViewById(R.id.username);
        passwordEditText = (EditText) findViewById(R.id.password);
        confirmPwdEditText = (EditText) findViewById(R.id.confirm_password);
    }

    /**
     * 注冊
     */
    public void register(View view) {

        final String username = userNameEditText.getText().toString().trim();
        final String pwd = passwordEditText.getText().toString().trim();
        String confirm_pwd = confirmPwdEditText.getText().toString().trim();

        if (TextUtils.isEmpty(username)) {
            Toast.makeText(this, "用户名不能为空！", Toast.LENGTH_SHORT).show();
            userNameEditText.requestFocus();
            return;
        } else if (TextUtils.isEmpty(pwd)) {
            Toast.makeText(this, "密码不能为空！", Toast.LENGTH_SHORT).show();
            passwordEditText.requestFocus();
            return;
        } else if (TextUtils.isEmpty(confirm_pwd)) {
            Toast.makeText(this, "确认密码不能为空！", Toast.LENGTH_SHORT).show();
            confirmPwdEditText.requestFocus();
            return;
        } else if (!pwd.equals(confirm_pwd)) {
            Toast.makeText(this, "两次密码输入不一致，请重输！", Toast.LENGTH_SHORT).show();
            return;
        }

        if (!TextUtils.isEmpty(username) && !TextUtils.isEmpty(pwd)) {
            final ProgressDialog pd = new ProgressDialog(this);
            pd.setMessage("注册ing……");
            pd.show();

            new Thread(() -> {
                try {
                    // call method in SDK
                    EMClient.getInstance().createAccount(username, pwd);
                    runOnUiThread(() -> {
                        if (!RegisterActivity.this.isFinishing())
                            pd.dismiss();
                        // 保存用户名
                        YIMHelper.getInstance().setCurrentUserName(username);
                        Toast.makeText(getApplicationContext(), "注册成功!", Toast.LENGTH_SHORT).show();
                        finish();

                    });
                } catch (final HyphenateException e) {
                    runOnUiThread(() -> {
                        if (!RegisterActivity.this.isFinishing())
                            pd.dismiss();
                        int errorCode = e.getErrorCode();
                        if (errorCode == EMError.NETWORK_ERROR) {
                            Toast.makeText(getApplicationContext(), "网络不可用", Toast.LENGTH_SHORT).show();
                        } else if (errorCode == EMError.USER_ALREADY_EXIST) {
                            Toast.makeText(getApplicationContext(), "用户名已经存在", Toast.LENGTH_SHORT).show();
                        } else if (errorCode == EMError.USER_AUTHENTICATION_FAILED) {
                            Toast.makeText(getApplicationContext(), "无权限注册", Toast.LENGTH_SHORT).show();
                        } else if (errorCode == EMError.USER_ILLEGAL_ARGUMENT) {
                            Toast.makeText(getApplicationContext(), "非法用户名", Toast.LENGTH_SHORT).show();
                        } else {
                            Toast.makeText(getApplicationContext(), "注册失败", Toast.LENGTH_SHORT).show();
                        }
                    });
                }
            }).start();
        }
    }
}
