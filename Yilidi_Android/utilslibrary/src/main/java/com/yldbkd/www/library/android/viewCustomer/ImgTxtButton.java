package com.yldbkd.www.library.android.viewCustomer;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.R;

public class ImgTxtButton extends RelativeLayout {

    private ImageView imgView;
    private TextView textView;

    public ImgTxtButton(Context context) {
        super(context, null);
    }

    public ImgTxtButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);

        LayoutInflater.from(context).inflate(R.layout.button_with_text_n_img, this, true);

        this.imgView = (ImageView) findViewById(R.id.img_view);
        this.textView = (TextView) findViewById(R.id.text_view);

        this.setClickable(true);
        this.setFocusable(true);
    }

    public void setImgResource(int resourceID) {
        this.imgView.setImageResource(resourceID);
        this.imgView.setVisibility(View.VISIBLE);
        this.textView.setVisibility(View.GONE);
    }

    public void setText(String text) {
        this.textView.setText(text);
        this.textView.setVisibility(View.VISIBLE);
        this.imgView.setVisibility(View.GONE);
    }

    public void setTextColor(int color) {
        this.textView.setTextColor(color);
    }

    public void setTextSize(float size) {
        this.textView.setTextSize(size);
    }

    public String getText() {
        return textView.getText().toString();
    }

    public TextView getTextView() {
        return textView;
    }
}
