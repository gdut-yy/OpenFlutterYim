package com.devyy.flutter.yim.view.activity;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import com.devyy.flutter.yim.view.ChatFragmentTo1;


public class ChatActivityTo1 extends SingleFragmentActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getSupportActionBar().hide();
    }

    @Override
    protected Fragment createFragment() {
        return ChatFragmentTo1.newInstance();
    }

}
