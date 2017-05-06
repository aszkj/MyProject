package com.yldbkd.www.buyer.android.viewCustomer;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.yldbkd.www.buyer.android.R;


public class CartSectionView extends LinearLayout {

    private ImageView tokenImageView;
    private ImageView tokenBtn;
    private boolean isToken = false;
    Context context;

    public CartSectionView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        View.inflate(context, R.layout.cart_section_view, this);
        initView();
        initListener();
    }

    public CartSectionView(Context context) {
        super(context);
    }

    private void initView() {
        tokenImageView = (ImageView) findViewById(R.id.token_image_view);
        tokenBtn = (ImageView) findViewById(R.id.token_button);
    }

    private void initListener() {
        tokenBtn.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                isToken = !isToken;
                setSelectView();
            }
        });
    }

    private void setSelectView() {
        if (isToken) {
            tokenImageView.setImageResource(R.mipmap.toke_choose);
            tokenBtn.setImageResource(R.mipmap.token_on);
            mListener.onTokenSelect();
        } else {
            tokenImageView.setImageResource(R.mipmap.toke_normal);
            tokenBtn.setImageResource(R.mipmap.token_off);
            mListener.onSendSelect();
        }
    }

    OnItemSelectListener mListener;

    public void setOnItemSelectListener(OnItemSelectListener listener) {
        mListener = listener;
    }

    public interface OnItemSelectListener {
        void onTokenSelect();

        void onSendSelect();
    }
}
