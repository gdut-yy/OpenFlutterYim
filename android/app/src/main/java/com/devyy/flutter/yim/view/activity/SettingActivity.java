package com.devyy.flutter.yim.view.activity;

import androidx.fragment.app.Fragment;

import com.devyy.flutter.yim.view.SettingFragment;

/**
 * @author zhangyiyang
 * @since 2019-03-16
 */
public class SettingActivity extends SingleFragmentActivity {

    @Override
    protected Fragment createFragment() {
        return SettingFragment.newInstance();
    }

}
