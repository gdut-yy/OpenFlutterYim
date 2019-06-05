package com.devyy.flutter.yim.emoticon;

/**
 *
 */
public interface IEmotionSelectedListener {
    /**
     *
     * @param key
     */
    void onEmojiSelected(String key);

    /**
     *
     * @param categoryName
     * @param stickerName
     * @param stickerBitmapPath
     */
    void onStickerSelected(String categoryName, String stickerName, String stickerBitmapPath);

}
