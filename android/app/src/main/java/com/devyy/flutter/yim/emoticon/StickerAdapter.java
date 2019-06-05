package com.devyy.flutter.yim.emoticon;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.devyy.flutter.yim.R;

public class StickerAdapter extends BaseAdapter {

    private Context mContext;
    private StickerCategory mCategory;

    private int startIndex;
    private int mEmotionLayoutWidth;
    private int mEmotionLayoutHeight;

    private float mPerWidth;
    private float mPerHeight;
    private float mIvSize;

    public StickerAdapter(Context context, StickerCategory category, int emotionLayoutWidth, int emotionLayoutHeight, int startIndex) {
        mContext = context;
        mCategory = category;
        this.startIndex = startIndex;

        mEmotionLayoutWidth = emotionLayoutWidth;
        mEmotionLayoutHeight = emotionLayoutHeight - EmotionKit.dip2px(62 + 30);//减去底部的tab高度、小圆点的高度才是viewpager的高度，再减少30dp是让表情整体的顶部和底部有个外间距
        mPerWidth = mEmotionLayoutWidth * 1f / EmoticonLayout.STICKER_COLS;
        mPerHeight = mEmotionLayoutHeight * 1f / EmoticonLayout.STICKER_ROWS;

        float ivWidth = mPerWidth * 0.8f;
        float ivHeight = mPerHeight * 0.8f;
        mIvSize = Math.min(ivWidth, ivHeight);
    }

    @Override
    public int getCount() {
        int count;
        if (mCategory.getStickerItems() != null) {
            count = Math.min(mCategory.getStickerItems().size() - startIndex, EmoticonLayout.STICKER_PER_PAGE);
        } else {
            count = EmoticonLayout.STICKER_PER_PAGE;
        }

        return count;
    }

    @Override
    public Object getItem(int i) {
        return mCategory.getStickerItems().get(startIndex + i);
    }

    @Override
    public long getItemId(int i) {
        return startIndex + i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        StickerViewHolder viewHolder;
        if (view == null) {
            RelativeLayout rl = new RelativeLayout(mContext);
            rl.setLayoutParams(new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, (int) mPerHeight));

            ImageView imageView = new ImageView(mContext);
            imageView.setImageResource(R.drawable.emoji_tab_emoji);
            RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
            params.width = (int) mIvSize;
            params.height = (int) mIvSize;
            params.addRule(RelativeLayout.CENTER_IN_PARENT);
            imageView.setLayoutParams(params);

            rl.addView(imageView);

            viewHolder = new StickerViewHolder();
            viewHolder.mImageView = imageView;

            view = rl;
            view.setTag(viewHolder);
        } else {
            viewHolder = (StickerViewHolder) view.getTag();
        }

        int index = startIndex + i;
        StickerItem sticker = null;
        if(mCategory.getStickerItems() != null){
            if (index >= mCategory.getStickerItems().size()) {
                return view;
            }

            sticker = mCategory.getStickerItems().get(index);
            if (sticker == null) {
                return view;
            }
        }


        String stickerBitmapUri = null;
        if (sticker != null) {
            stickerBitmapUri = StickerManager.getInstance().getStickerBitmapUri(sticker.getCategory(), sticker.getName());
        }
        EmotionKit.getImageLoader().displayImage(mContext, stickerBitmapUri, viewHolder.mImageView);

        return view;
    }

    class StickerViewHolder {
        public ImageView mImageView;
    }
}
