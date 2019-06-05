package com.devyy.flutter.yim.emoticon;


import androidx.annotation.Nullable;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * StickerManager 管理类
 */
public class StickerManager {

    // 单例三连
    private static StickerManager sInstance;

    private StickerManager() {
        loadStickerCategory();
    }

    public static StickerManager getInstance() {
        if (sInstance == null) {
            synchronized (StickerManager.class) {
                if (sInstance == null) {
                    sInstance = new StickerManager();
                }
            }
        }
        return sInstance;
    }

    // 正文部分
    private List<StickerCategory> stickerCategories = new ArrayList<>();
    private Map<String, StickerCategory> stickerCategoryMap = new HashMap<>();

    private void loadStickerCategory() {
        File stickerDir = new File(EmotionKit.getStickerPath());
        if (stickerDir.exists()) {
            File[] files = stickerDir.listFiles();
            for (int i = 0; i < files.length; i++) {
                File file = files[i];
                // 当前的目录下同名的有文件和文件夹，只需要其中的一个取其名
                if (file.isDirectory()) {
                    String name = file.getName();
                    StickerCategory category = new StickerCategory(name, name, true, i);
                    stickerCategories.add(category);
                    stickerCategoryMap.put(name, category);
                }
            }

            // 排序
            Collections.sort(stickerCategories, (o1, o2) -> o1.getOrder() - o2.getOrder());
        }
    }

    public synchronized List<StickerCategory> getStickerCategories() {
        return stickerCategories;
    }

    public synchronized StickerCategory getCategory(String name) {
        return stickerCategoryMap.get(name);
    }

    public String getStickerBitmapUri(String categoryName, String stickerName) {
        String path = getStickerBitmapPath(categoryName, stickerName);
        return "file://" + path;
    }

    @Nullable
    public String getStickerBitmapPath(String categoryName, String stickerName) {
        StickerManager manager = StickerManager.getInstance();
        StickerCategory category = manager.getCategory(categoryName);
        if (category == null) {
            return null;
        }
        return EmotionKit.getStickerPath() + File.separator + category.getName() + File.separator + stickerName;
    }

}
