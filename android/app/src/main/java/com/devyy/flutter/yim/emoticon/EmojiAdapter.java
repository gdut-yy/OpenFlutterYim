package com.devyy.flutter.yim.emoticon;

import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.devyy.flutter.yim.R;

/**
 * Emoji 表情适配器（单表情部分，不包括小圆点条和底部 Tab）
 */
public class EmojiAdapter extends BaseAdapter {

    private Context mContext;

    private int mStartIndex;
    private int mEmotionLayoutWidth;
    private int mEmotionLayoutHeight;

    private final float mPerWidth;
    private final float mPerHeight;
    private final float mIvSize;

    public EmojiAdapter(Context context, int emotionLayoutWidth, int emotionLayoutHeight, int startIndex) {
        mContext = context;
        mStartIndex = startIndex;
        mEmotionLayoutWidth = emotionLayoutWidth;
        mEmotionLayoutHeight = emotionLayoutHeight - EmotionKit.dip2px(62);// 减去布局的 62dp

        mPerWidth = mEmotionLayoutWidth * 1f / EmoticonLayout.EMOJI_COLS;
        mPerHeight = mEmotionLayoutHeight * 1f / EmoticonLayout.EMOJI_ROWS;
        float ivWidth = mPerWidth * 0.6f;
        float ivHeight = mPerHeight * 0.6f;
        mIvSize = Math.min(ivWidth, ivHeight);
    }

    @Override
    public int getCount() {
        int count = EmojiManager.getDisplayCount() - mStartIndex + 1;
        count = Math.min(count, EmoticonLayout.EMOJI_PER_PAGE + 1);
        return count;
    }

    @Override
    public Object getItem(int i) {
        return null;
    }

    @Override
    public long getItemId(int i) {
        return mStartIndex + i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        RelativeLayout rl = new RelativeLayout(mContext);
        rl.setLayoutParams(new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, (int) mPerHeight));
//        rl.setBackgroundColor(Color.RED);

        ImageView emojiThumb = new ImageView(mContext);
        int count = EmojiManager.getDisplayCount();
        int index = mStartIndex + i;
        if (i == EmoticonLayout.EMOJI_PER_PAGE || index == count) {
            emojiThumb.setBackgroundResource(R.drawable.emoji_del);
        } else if (index < count) {
            emojiThumb.setBackground(EmojiManager.getDisplayDrawable(mContext, index));
        }

        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        layoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL);
        layoutParams.width = (int) mIvSize;
        layoutParams.height = (int) mIvSize;
        emojiThumb.setLayoutParams(layoutParams);

        rl.setGravity(Gravity.CENTER);
        rl.addView(emojiThumb);

        return rl;
    }
}
