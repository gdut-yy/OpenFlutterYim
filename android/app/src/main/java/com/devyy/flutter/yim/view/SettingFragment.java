package com.devyy.flutter.yim.view;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.devyy.flutter.yim.R;
import com.devyy.flutter.yim.YIMHelper;
import com.devyy.flutter.yim.account.SplashActivity;
import com.hyphenate.EMCallBack;

/**
 * "我" => "设置" 页面
 * 环信登出功能
 *
 * @author zhangyiyang
 * @since 2019-03-17
 */
public class SettingFragment extends Fragment {

    private TextView tvLogout;

    public static SettingFragment newInstance() {
        return new SettingFragment();
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.discovery_fragment_setting, container, false);

        tvLogout = (TextView) v.findViewById(R.id.tv_setting_logout);
        tvLogout.setOnClickListener(view -> logout());

        return v;
    }

    private void logout() {
        final ProgressDialog pd = new ProgressDialog(getActivity());
        String st = "退出登录";
        pd.setMessage(st);
        pd.setCanceledOnTouchOutside(false);
        pd.show();
        YIMHelper.getInstance().logout(true, new EMCallBack() {

            @Override
            public void onSuccess() {
                getActivity().runOnUiThread(() -> {
                    pd.dismiss();
                    // show login screen
                    getActivity().finish();
                    startActivity(new Intent(getActivity(), SplashActivity.class));

                });
            }

            @Override
            public void onProgress(int progress, String status) {

            }

            @Override
            public void onError(int code, String message) {
                getActivity().runOnUiThread(() -> {
                    pd.dismiss();
                    Toast.makeText(getActivity(), "unbind devicetokens failed", Toast.LENGTH_SHORT).show();
                });
            }
        });
    }
}
