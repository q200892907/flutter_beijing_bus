package com.jvtd.flutter_beijing_bus;

import android.content.Context;
import android.support.multidex.MultiDex;

import io.flutter.app.FlutterApplication;

/**
 * 作者:chenlei
 * 时间:2019/1/22 11:21 AM
 */
public class FlutterBusApplication extends FlutterApplication {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
