package com.devyy.flutter.yim.emoticon;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class StickerCategory {

    private String name;
    private String title;
    private boolean system;
    private int order;
    private List<StickerItem> stickerItems;

    public StickerCategory(String name, String title, boolean system, int order) {
        this.name = name;
        this.title = title;
        this.system = system;
        this.order = order;

    }

    public boolean hasStickers() {
        return stickerItems != null && stickerItems.size() > 0;
    }

    public int getCount() {
        if (stickerItems == null || stickerItems.isEmpty()) {
            return 0;
        }

        return stickerItems.size();
    }

    public String getCoverImgPath() {
        for (File file : new File(EmotionKit.getStickerPath()).listFiles()) {
            if (file.isFile() && file.getName().startsWith(name)) {
                return "file://" + file.getAbsolutePath();
            }
        }
        return null;
    }

    public List<StickerItem> loadStickerData() {
        List<StickerItem> stickers = new ArrayList<>();
        File stickerDir = new File(EmotionKit.getStickerPath(), name);
        if (stickerDir.exists()) {
            File[] files = stickerDir.listFiles();
            for (File file : files) {
                //比如：tsj ---> tsj/tsj_001.gif
//                stickers.add(new StickerItem(name, name + File.separator + file.getName()));
                stickers.add(new StickerItem(name, file.getName()));
            }
        }

        // 补充最后一页缺少的贴图
        int tmp = stickers.size() % EmoticonLayout.STICKER_PER_PAGE;
        if (tmp != 0) {
            int tmp2 = EmoticonLayout.STICKER_PER_PAGE - (stickers.size() - (stickers.size() / EmoticonLayout.STICKER_PER_PAGE) * EmoticonLayout.STICKER_PER_PAGE);
            for (int i = 0; i < tmp2; i++) {
                stickers.add(new StickerItem("", ""));
            }
        }

        this.setStickerItems(stickers);
        return stickers;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof StickerCategory)) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        StickerCategory r = (StickerCategory) obj;
        return r.getName().equals(getName());
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }

    // Getter and Setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isSystem() {
        return system;
    }

    public void setSystem(boolean system) {
        this.system = system;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public List<StickerItem> getStickerItems() {
        return stickerItems;
    }

    public void setStickerItems(List<StickerItem> stickerItems) {
        this.stickerItems = stickerItems;
    }
}
