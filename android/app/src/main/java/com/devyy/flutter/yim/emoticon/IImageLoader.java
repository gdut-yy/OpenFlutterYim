package com.devyy.flutter.yim.emoticon;

import android.content.Context;
import android.widget.ImageView;

/**
 * 图片加载器（交由外部工程决定）
 */
public interface IImageLoader {

    void displayImage(Context context, String path, ImageView imageView);
}
