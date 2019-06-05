package com.devyy.flutter.yim.emoticon;

/**
 * StickerItem 实体类
 */
public class StickerItem {
    private String category;
    private String name;

    public StickerItem(String category, String name) {
        this.category = category;
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj != null && obj instanceof StickerItem) {
            StickerItem item = (StickerItem) obj;
            return item.getCategory().equals(category) && item.getName().equals(name);
        }
        return false;
    }
}
