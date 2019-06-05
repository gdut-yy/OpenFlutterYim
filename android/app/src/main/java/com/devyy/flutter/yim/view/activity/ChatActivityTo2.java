package com.devyy.flutter.yim.view.activity;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import com.devyy.flutter.yim.view.ChatFragmentTo2;


public class ChatActivityTo2 extends SingleFragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getSupportActionBar().hide();
    }

    @Override
    protected Fragment createFragment() {
        return ChatFragmentTo2.newInstance();
    }

}
