package com.devyy.flutter.yim.view;

import android.os.Bundle;
import android.os.Handler;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.devyy.flutter.yim.R;
import com.devyy.flutter.yim.emoticon.EmoticonKeyBoard;
import com.devyy.flutter.yim.emoticon.EmoticonLayout;
import com.devyy.flutter.yim.emoticon.IEmotionExtClickListener;
import com.devyy.flutter.yim.emoticon.IEmotionSelectedListener;
import com.google.android.material.appbar.AppBarLayout;
import com.hyphenate.EMCallBack;
import com.hyphenate.EMMessageListener;
import com.hyphenate.chat.EMClient;
import com.hyphenate.chat.EMConversation;
import com.hyphenate.chat.EMMessage;
import com.hyphenate.chat.EMTextMessageBody;


import java.util.LinkedList;
import java.util.List;

/**
 * "YIM" -> "item" 聊天页面
 */
public class ChatFragmentTo2 extends Fragment implements View.OnClickListener {

    private static final String TAG = "ChatFragmentTo2";
    private static final String TO_USER_NAME = "kolzb002";
    private static final String CHAT_BEAN = "chat_bean";

    private RecyclerView mRecyclerView;
    private ChatAdapter mAdapter;
    Handler handler = new Handler();

//    private ChatTest mChat;
    private List<EMMessage> mMessageList = new LinkedList<>();

    // include_toolbar.xml
    private AppBarLayout appBar;
    private TextView tvToolbarTitle;
    private ImageView ivToolbarBack;
    private ImageView ivToolbarMore;

    // 底部输入框
    private ImageView ivVoice;
    private EditText etInput;
    private ImageView ivEmoji;
    private ImageView ivMore;
    private Button btnSend;

    // 自定义 Emoticon 控件
    private EmoticonKeyBoard mEmotionKeyboard;
    private LinearLayout mLlContent;
    private FrameLayout mFlEmotionView;
    private EmoticonLayout mElEmotion;
    private ConstraintLayout mLlMore;

    // include_extra_keyboard.xml
    private LinearLayout llAlbum;
    private LinearLayout llCamera;
    private LinearLayout llVoiceCall;
    private LinearLayout llLocation;
    private LinearLayout llRedPacket;
    private LinearLayout llVoiceInput;
    private LinearLayout llContactCard;
    private LinearLayout llFiles;

    public static ChatFragmentTo2 newInstance() {
//        Bundle args = new Bundle();
//        args.putSerializable(CHAT_BEAN, chat);
//
//        ChatFragmentTo2 fragment = new ChatFragmentTo2();
//        fragment.setArguments(args);
        return new ChatFragmentTo2();
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        mChat = (ChatTest) getArguments().getSerializable(CHAT_BEAN);

    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.module_fragment_chat, container, false);

        mRecyclerView = (RecyclerView) v.findViewById(R.id.rv_chat_content);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));

        bindView(v);
        bindListener();
//        tvToolbarTitle.setText(mChat.getUserName());
//        appBar.setMinimumHeight(HomeFragment.titleBarHeight);
        tvToolbarTitle.setText(TO_USER_NAME);

        EMClient.getInstance().chatManager().addMessageListener(msgListener);
        updateUI();
        initEmotionKeyboard();

        return v;
    }

    private void updateUI() {

        EMConversation conversation = EMClient.getInstance().chatManager().getConversation(TO_USER_NAME);

        //获取此会话的所有消息
        if (null != conversation && null != conversation.getAllMessages()) {
            mMessageList = conversation.getAllMessages();
        }


        mAdapter = new ChatAdapter(mMessageList);
        mRecyclerView.setAdapter(mAdapter);
    }

    private void bindView(View v) {
        appBar = (AppBarLayout) v.findViewById(R.id.yim_toolbar);
        tvToolbarTitle = (TextView) v.findViewById(R.id.tv_toolbar_title);
        ivToolbarBack = (ImageView) v.findViewById(R.id.iv_toolbar_back);
        ivToolbarMore = (ImageView) v.findViewById(R.id.iv_toolbar_more);

        ivVoice = (ImageView) v.findViewById(R.id.iv_chat_voice);
        etInput = (EditText) v.findViewById(R.id.et_chat_input);
        ivEmoji = (ImageView) v.findViewById(R.id.iv_chat_emoji);
        ivMore = (ImageView) v.findViewById(R.id.iv_chat_more);
        btnSend = (Button) v.findViewById(R.id.btn_chat_send);

        mLlContent = (LinearLayout) v.findViewById(R.id.llContent);
        mFlEmotionView = (FrameLayout) v.findViewById(R.id.flEmotionView);
        mElEmotion = (EmoticonLayout) v.findViewById(R.id.elEmotion);
        mLlMore = (ConstraintLayout) v.findViewById(R.id.llMore);

        llAlbum = (LinearLayout) v.findViewById(R.id.rl_album);
        llCamera = (LinearLayout) v.findViewById(R.id.rl_camera);
        llVoiceCall = (LinearLayout) v.findViewById(R.id.rl_voice_call);
        llLocation = (LinearLayout) v.findViewById(R.id.rl_location);
        llRedPacket = (LinearLayout) v.findViewById(R.id.rl_red_packet);
        llVoiceInput = (LinearLayout) v.findViewById(R.id.rl_voice_input);
        llContactCard = (LinearLayout) v.findViewById(R.id.rl_contact_card);
        llFiles = (LinearLayout) v.findViewById(R.id.rl_files);
    }

    private void bindListener() {
        ivToolbarBack.setOnClickListener(this);

        etInput.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                if (etInput.getText().toString().trim().length() > 0) {
                    btnSend.setVisibility(View.VISIBLE);
                    ivMore.setVisibility(View.GONE);
//                    RongIMClient.getInstance().sendTypingStatus(mConversationType, mSessionId, TextMessage.class.getAnnotation(MessageTag.class).value());
                } else {
                    btnSend.setVisibility(View.GONE);
                    ivMore.setVisibility(View.VISIBLE);
                }

            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });

        // 发送按钮
        btnSend.setOnClickListener(this);

        mElEmotion.attachEditText(etInput);
        mElEmotion.setEmotionSelectedListener(new IEmotionSelectedListener() {
            @Override
            public void onEmojiSelected(String key) {
                Log.i(TAG, "onEmojiSelected() 调用");
            }

            @Override
            public void onStickerSelected(String categoryName, String stickerName, String stickerBitmapPath) {
                Log.i(TAG, "onStickerSelected() 调用");
            }
        });
        mElEmotion.setEmotionAddVisiable(true);
        mElEmotion.setEmotionSettingVisiable(true);
        mElEmotion.setEmotionExtClickListener(new IEmotionExtClickListener() {
            @Override
            public void onEmotionAddClick(View view) {
                Log.i(TAG, "onEmotionAddClick() 调用");
            }

            @Override
            public void onEmotionSettingClick(View view) {
                Log.i(TAG, "onEmotionSettingClick() 调用");
            }
        });

        llAlbum.setOnClickListener(this);
        llCamera.setOnClickListener(this);
        llVoiceCall.setOnClickListener(this);
        llLocation.setOnClickListener(this);
        llRedPacket.setOnClickListener(this);
        llVoiceInput.setOnClickListener(this);
        llContactCard.setOnClickListener(this);
        llFiles.setOnClickListener(this);
    }

    private void initEmotionKeyboard() {
        mEmotionKeyboard = EmoticonKeyBoard.with(getActivity());
        mEmotionKeyboard.bindToEditText(etInput);
        mEmotionKeyboard.bindToContent(mLlContent);
        mEmotionKeyboard.setEmotionLayout(mFlEmotionView);
        mEmotionKeyboard.bindToEmotionButton(ivEmoji, ivMore);
        mEmotionKeyboard.setOnEmotionButtonOnClickListener(view -> {
            switch (view.getId()) {
                case R.id.iv_chat_emoji:
                    handler.postDelayed(() -> mRecyclerView.scrollToPosition(mRecyclerView.getAdapter().getItemCount() - 1), 50);
                    etInput.clearFocus();
                    if (!mElEmotion.isShown()) {
                        if (mLlMore.isShown()) {
                            mElEmotion.setVisibility(View.VISIBLE);
                            ivEmoji.setImageResource(R.drawable.chat_keyboard);
                            mLlMore.setVisibility(View.GONE);
                            return true;
                        }
                    } else if (mElEmotion.isShown() && !mLlMore.isShown()) {
                        // 置换成键盘按钮
                        ivEmoji.setImageResource(R.drawable.chat_emoji);
                        return false;
                    }
                    mElEmotion.setVisibility(View.VISIBLE);
                    ivEmoji.setImageResource(R.drawable.chat_keyboard);
                    mLlMore.setVisibility(View.GONE);
                    break;
                case R.id.iv_chat_more:
                    handler.postDelayed(() -> mRecyclerView.scrollToPosition(mRecyclerView.getAdapter().getItemCount() - 1), 50);
                    etInput.clearFocus();
                    if (!mLlMore.isShown()) {
                        if (mElEmotion.isShown()) {
                            mLlMore.setVisibility(View.VISIBLE);
                            mElEmotion.setVisibility(View.GONE);
                            ivEmoji.setImageResource(R.drawable.chat_emoji);
                            return true;
                        }
                    }
                    mLlMore.setVisibility(View.VISIBLE);
                    mElEmotion.setVisibility(View.GONE);
                    ivEmoji.setImageResource(R.drawable.chat_emoji);
                    break;
            }
            return false;
        });
    }

    protected EMCallBack messageStatusCallback = new EMCallBack() {
        @Override
        public void onSuccess() {
            Log.i(TAG, "发送成功");
//            if(isMessageListInited) {
//                messageList.refresh();
//            }
        }

        @Override
        public void onError(int code, String error) {
            Log.i(TAG, "发送失败" + String.valueOf(code));
//            if(isMessageListInited) {
//                messageList.refresh();
//            }
        }

        @Override
        public void onProgress(int progress, String status) {
            Log.i(TAG, "发送中: " + progress);
//            if(isMessageListInited) {
//                messageList.refresh();
//            }
        }
    };

    private void refreshRecyclerView() {
        getActivity().runOnUiThread(() -> {
            mAdapter.notifyItemInserted(mMessageList.size() - 1);
            mRecyclerView.scrollToPosition(mMessageList.size() - 1);
        });
    }

    private EMMessageListener msgListener = new EMMessageListener() {
        @Override
        public void onMessageReceived(List<EMMessage> messages) {
            // 收到消息
            Log.i(TAG, "收到消息");
            for (EMMessage emMessage : messages) {
                mMessageList.add(emMessage);
                refreshRecyclerView();
            }
        }

        @Override
        public void onCmdMessageReceived(List<EMMessage> messages) {
            Log.i(TAG, "收到透传消息");
        }

        @Override
        public void onMessageRead(List<EMMessage> messages) {
            Log.i(TAG, "收到已读回执");
        }

        @Override
        public void onMessageDelivered(List<EMMessage> messages) {
            Log.i(TAG, "收到已送达回执");
        }

        @Override
        public void onMessageRecalled(List<EMMessage> messages) {

        }

        @Override
        public void onMessageChanged(EMMessage message, Object change) {
            Log.i(TAG, "消息状态变动");
        }
    };

    @Override
    public void onClick(View view) {
        int id = view.getId();
        switch (id) {
            case R.id.iv_toolbar_back:
//                Intent intent = new Intent(getActivity(), HomeActivity.class);
//                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                startActivity(intent);
//                getActivity().finish();
                break;
            case R.id.iv_toolbar_more:
                Toast.makeText(getActivity(), "聊天信息页面（待实现）", Toast.LENGTH_SHORT).show();
                break;
            case R.id.btn_chat_send:
                String input = etInput.getText().toString().trim();
                // 创建一条文本消息，content为消息文字内容，toChatUsername为对方用户或者群聊的id，后文皆是如此
                EMMessage message = EMMessage.createTxtSendMessage(input, TO_USER_NAME);
//                // 如果是群聊，设置chattype，默认是单聊
//                if (chatType == CHATTYPE_GROUP)
//                    message.setChatType(ChatType.GroupChat);
                message.setMessageStatusCallback(messageStatusCallback);
                //发送消息
                EMClient.getInstance().chatManager().sendMessage(message);
                etInput.setText("");
                mMessageList.add(message);
                refreshRecyclerView();
                break;
            case R.id.rl_album:
                Log.i(TAG, "点击 “相册”");
                break;
            case R.id.rl_camera:
                Log.i(TAG, "点击 “拍摄”");
                break;
            case R.id.rl_voice_call:
                Log.i(TAG, "点击 “视频通话”");
                break;
            case R.id.rl_location:
                Log.i(TAG, "点击 “位置”");
                break;
            case R.id.rl_red_packet:
                Log.i(TAG, "点击 “红包");
                break;
            case R.id.rl_voice_input:
                Log.i(TAG, "点击 “语音输入”");
                break;
            case R.id.rl_contact_card:
                Log.i(TAG, "点击 “名片”");
                break;
            case R.id.rl_files:
                Log.i(TAG, "点击 “文件”");
                break;
        }
    }


    // 发送消息内部类
    public class SendMsgHolder extends RecyclerView.ViewHolder {

        private TextView tvSend;

        public SendMsgHolder(LayoutInflater inflater, ViewGroup parent) {
            super(inflater.inflate(R.layout.item_text_send, parent, false));

            tvSend = (TextView) itemView.findViewById(R.id.tvText);
        }

        public void bind(EMMessage message) {
            String content = ((EMTextMessageBody) message.getBody()).getMessage();
            tvSend.setText(content);
        }
    }

    // 接收消息内部类
    public class ReceiveMsgHolder extends RecyclerView.ViewHolder {

        private TextView tvReceive;

        public ReceiveMsgHolder(LayoutInflater inflater, ViewGroup parent) {
            super(inflater.inflate(R.layout.item_text_receive, parent, false));

            tvReceive = (TextView) itemView.findViewById(R.id.tvText);
        }

        public void bind(EMMessage message) {
            String content = ((EMTextMessageBody) message.getBody()).getMessage();
            tvReceive.setText(content);
        }
    }

    // RecyclerView.Adapter 内部类
    public class ChatAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

        private static final int MESSAGE_TYPE_RECV_TXT = 0;
        private static final int MESSAGE_TYPE_SENT_TXT = 1;

        private List<EMMessage> mEmMessages;

        public ChatAdapter(List<EMMessage> messages) {
            mEmMessages = messages;
        }

        @Override
        public int getItemViewType(int position) {
            EMMessage message = mEmMessages.get(position);
            if (message.direct() == EMMessage.Direct.SEND) {
                return MESSAGE_TYPE_SENT_TXT;
            } else {
                return MESSAGE_TYPE_RECV_TXT;
            }
        }

        @NonNull
        @Override
        public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            if (viewType == MESSAGE_TYPE_SENT_TXT) {
                LayoutInflater layoutInflater = LayoutInflater.from(getActivity());
                return new SendMsgHolder(layoutInflater, parent);
            } else {
                LayoutInflater layoutInflater = LayoutInflater.from(getActivity());
                return new ReceiveMsgHolder(layoutInflater, parent);
            }
        }

        @Override
        public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
            EMMessage message = mEmMessages.get(position);
            if (holder instanceof SendMsgHolder) {
                ((SendMsgHolder) holder).bind(message);
            } else {
                ((ReceiveMsgHolder) holder).bind(message);
            }

        }

        @Override
        public int getItemCount() {
            return mEmMessages.size();
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        EMClient.getInstance().chatManager().removeMessageListener(msgListener);
    }
}
