package com.devyy.flutter.yim.emoticon;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;


import androidx.annotation.Nullable;
import androidx.viewpager.widget.ViewPager;

import com.devyy.flutter.yim.R;

import java.util.List;

/**
 * EmoticonLayout 软键盘布局（包括表情界面、小圆点条和底部 Tab）
 */
public class EmoticonLayout extends LinearLayout implements View.OnClickListener {

    private static final String TAG = "EmoticonLayout";

    // 小表情布局 3 行 7 列，一页 20 个表情 + 1 个删除键
    public static final int EMOJI_ROWS = 3;
    public static final int EMOJI_COLS = 7;
    public static final int EMOJI_PER_PAGE = 20;

    // 大表情布局 2 行 4 列，一页 8 个表情
    public static final int STICKER_ROWS = 2;
    public static final int STICKER_COLS = 4;
    public static final int STICKER_PER_PAGE = 8;

    private int mMeasuredWidth;
    private int mMeasuredHeight;

    private int mTabPosi = 0;
    private Context mContext;
    private ViewPager mVpEmotion;
    private LinearLayout mLlPageNumber;
    private LinearLayout mLlTabContainer;
    private RelativeLayout mRlEmotionAdd;

    private int mTabCount;
    private SparseArray<View> mTabViewArray = new SparseArray<>();
    private EmoticonTab mSettingTab;
    private IEmotionSelectedListener mEmotionSelectedListener;
    private IEmotionExtClickListener mEmotionExtClickListener;
    private boolean mEmotionAddVisiable = false;
    private boolean mEmotionSettingVisiable = false;


    public EmoticonLayout(Context context) {
        this(context, null);
    }

    public EmoticonLayout(Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public EmoticonLayout(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        mContext = context;
    }


    @Override
    public void onClick(View view) {
        mTabPosi = (int) view.getTag();
        selectTab(mTabPosi);
        Log.i(TAG, "mTabPosi当前值" + mTabPosi);
    }

    public void setEmotionSelectedListener(IEmotionSelectedListener emotionSelectedListener) {
        if (emotionSelectedListener != null) {
            this.mEmotionSelectedListener = emotionSelectedListener;
        } else {
            Log.i(TAG, "IEmotionSelectedListener is null");
        }
    }


    public void setEmotionExtClickListener(IEmotionExtClickListener emotionExtClickListener) {
        if (emotionExtClickListener != null) {
            this.mEmotionExtClickListener = emotionExtClickListener;
        } else {
            Log.i(TAG, "IEmotionSettingTabClickListener is null");
        }
    }


    /**
     * 设置表情添加按钮的显隐
     */
    public void setEmotionAddVisiable(boolean visiable) {
        mEmotionAddVisiable = visiable;
        if (mRlEmotionAdd != null) {
            mRlEmotionAdd.setVisibility(mEmotionAddVisiable ? View.VISIBLE : View.GONE);
        }
    }

    /**
     * 设置表情设置按钮的显隐
     */
    public void setEmotionSettingVisiable(boolean visiable) {
        mEmotionSettingVisiable = visiable;
        if (mSettingTab != null) {
            mSettingTab.setVisibility(mEmotionSettingVisiable ? View.VISIBLE : View.GONE);
        }
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        init();
        initListener();
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        mMeasuredWidth = measureWidth(widthMeasureSpec);
        mMeasuredHeight = measureHeight(heightMeasureSpec);
        setMeasuredDimension(mMeasuredWidth, mMeasuredHeight);
    }


    private int measureWidth(int measureSpec) {
        int result = 0;
        int specMode = MeasureSpec.getMode(measureSpec);
        int specSize = MeasureSpec.getSize(measureSpec);

        if (specMode == MeasureSpec.EXACTLY) {
            result = specSize;
        } else {
            result = EmotionKit.dip2px(200);
            if (specMode == MeasureSpec.AT_MOST) {
                result = Math.min(result, specSize);
            }
        }
        return result;
    }

    private int measureHeight(int measureSpec) {
        int result = 0;
        int specMode = MeasureSpec.getMode(measureSpec);
        int specSize = MeasureSpec.getSize(measureSpec);

        if (specMode == MeasureSpec.EXACTLY) {
            result = specSize;
        } else {
            result = EmotionKit.dip2px(200);
            if (specMode == MeasureSpec.AT_MOST) {
                result = Math.min(result, specSize);
            }
        }
        return result;
    }

    private void init() {
        LayoutInflater inflater = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.emotion_layout, this);
//        View.inflate(mContext, R.layout.emotion_layout, this);

        mVpEmotion = (ViewPager) findViewById(R.id.vpEmotioin);
        mLlPageNumber = (LinearLayout) findViewById(R.id.llPageNumber);
        mLlTabContainer = (LinearLayout) findViewById(R.id.llTabContainer);
        mRlEmotionAdd = (RelativeLayout) findViewById(R.id.rlEmotionAdd);
        setEmotionAddVisiable(mEmotionAddVisiable);

        initTabs();

    }

    private void initTabs() {
        // 默认添加一个表情tab
        EmoticonTab emojiTab = new EmoticonTab(mContext, R.drawable.emoji_tab_emoji);
        mLlTabContainer.addView(emojiTab);
        mTabViewArray.put(0, emojiTab);

        // 添加所有的贴图tab
        List<StickerCategory> stickerCategories = StickerManager.getInstance().getStickerCategories();
        for (int i = 0; i < stickerCategories.size(); i++) {
            StickerCategory category = stickerCategories.get(i);
            EmoticonTab tab = new EmoticonTab(mContext, category.getCoverImgPath());
            mLlTabContainer.addView(tab);
            mTabViewArray.put(i + 1, tab);
        }

        // 最后添加一个表情设置Tab
        mSettingTab = new EmoticonTab(mContext, R.drawable.emoji_tab_setting);
        StateListDrawable drawable = new StateListDrawable();
        Drawable unSelected = mContext.getResources().getDrawable(R.color.emoticon_tab_normal_color);
        drawable.addState(new int[]{-android.R.attr.state_pressed}, unSelected);
        Drawable selected = mContext.getResources().getDrawable(R.color.emoticon_tab_pressed_color);
        drawable.addState(new int[]{android.R.attr.state_pressed}, selected);
        mSettingTab.setBackground(drawable);
        mLlTabContainer.addView(mSettingTab);
        mTabViewArray.put(mTabViewArray.size(), mSettingTab);
        setEmotionSettingVisiable(mEmotionSettingVisiable);

        selectTab(0);
    }

    private void initListener() {
        if (mLlTabContainer != null) {
            mTabCount = mLlTabContainer.getChildCount() - 1;//不包含最后的设置按钮
            for (int position = 0; position < mTabCount; position++) {
                View tab = mLlTabContainer.getChildAt(position);
                tab.setTag(position);
                tab.setOnClickListener(this);
            }
        }

        mVpEmotion.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                setCurPageCommon(position);
            }

            @Override
            public void onPageSelected(int position) {

            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });

        mRlEmotionAdd.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mEmotionExtClickListener != null) {
                    mEmotionExtClickListener.onEmotionAddClick(v);
                }
            }
        });

        mSettingTab.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mEmotionExtClickListener != null) {
                    mEmotionExtClickListener.onEmotionSettingClick(v);
                }
            }
        });
    }

    private void setCurPageCommon(int position) {
        if (mTabPosi == 0)
            setCurPage(position, (int) Math.ceil(EmojiManager.getDisplayCount() / (float) EmoticonLayout.EMOJI_PER_PAGE));
        else {
            StickerCategory category = StickerManager.getInstance().getStickerCategories().get(mTabPosi - 1);
            if (category.getStickerItems() != null) {
                setCurPage(position, (int) Math.ceil(category.getStickerItems().size() / (float) EmoticonLayout.STICKER_PER_PAGE));
            }

        }
    }


    private void selectTab(int tabPosi) {
        if (tabPosi == mTabViewArray.size() - 1)
            return;

        for (int i = 0; i < mTabCount; i++) {
            View tab = mTabViewArray.get(i);
            tab.setBackgroundResource(R.drawable.shape_tab_normal);
        }
        mTabViewArray.get(tabPosi).setBackgroundResource(R.drawable.shape_tab_press);

        // 显示表情内容
        fillVpEmotioin(tabPosi);
    }

    private void fillVpEmotioin(int tabPosi) {
        EmotionViewPagerAdapter adapter = new EmotionViewPagerAdapter(mMeasuredWidth, mMeasuredHeight, tabPosi, mEmotionSelectedListener);
        mVpEmotion.setAdapter(adapter);
        mLlPageNumber.removeAllViews();
        setCurPageCommon(0);
        if (tabPosi == 0) {
            adapter.attachEditText(mMessageEditText);
        }
    }

    private void setCurPage(int page, int pageCount) {
        int hasCount = mLlPageNumber.getChildCount();
        int forMax = Math.max(hasCount, pageCount);

        ImageView ivCur = null;
        for (int i = 0; i < forMax; i++) {
            if (pageCount <= hasCount) {
                if (i >= pageCount) {
                    mLlPageNumber.getChildAt(i).setVisibility(View.GONE);
                    continue;
                } else {
                    ivCur = (ImageView) mLlPageNumber.getChildAt(i);
                }
            } else {
                if (i < hasCount) {
                    ivCur = (ImageView) mLlPageNumber.getChildAt(i);
                } else {
                    ivCur = new ImageView(mContext);
                    ivCur.setBackgroundResource(R.drawable.selector_view_pager_indicator);
                    LayoutParams params = new LayoutParams(EmotionKit.dip2px(8), EmotionKit.dip2px(8));
                    ivCur.setLayoutParams(params);
                    params.leftMargin = EmotionKit.dip2px(3);
                    params.rightMargin = EmotionKit.dip2px(3);
                    mLlPageNumber.addView(ivCur);
                }
            }

            ivCur.setId(i);
            ivCur.setSelected(i == page);
            ivCur.setVisibility(View.VISIBLE);
        }
    }

    EditText mMessageEditText;

    public void attachEditText(EditText messageEditText) {
        mMessageEditText = messageEditText;
    }

}
