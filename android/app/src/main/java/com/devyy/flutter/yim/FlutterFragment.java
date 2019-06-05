package com.devyy.flutter.yim;

import android.os.Bundle;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterFragment;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * 以 FlutterFragment 显示 Flutter
 *
 * @since 2019-05-14
 */
public class FlutterFragment extends BoostFlutterFragment {

    @Override
    public void destroyContainer() {

    }

    @Override
    public String getContainerName() {
        return "flutterFragment";
    }

    @Override
    public Map getContainerParams() {
        Map<String, String> params = new HashMap<>();
        params.put("tag", getArguments().getString("tag"));
        return params;
    }

    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    public static FlutterFragment instance(String tag) {
        FlutterFragment fragment = new FlutterFragment();
        fragment.setTabTag(tag);
        return fragment;
    }

    public void setTabTag(String tag) {
        Bundle args = new Bundle();
        args.putString("tag", tag);
        super.setArguments(args);
    }
}


