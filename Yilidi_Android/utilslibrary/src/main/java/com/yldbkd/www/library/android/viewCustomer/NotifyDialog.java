package com.yldbkd.www.library.android.viewCustomer;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.library.android.R;

public class NotifyDialog extends Dialog {
    private TextView contentView;
    private Button confirmBtn;

    public NotifyDialog(Context context, View.OnClickListener confirmClickListener) {
        super(context);
        setCancelable(false);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.notify_dialog_layout);
        setCanceledOnTouchOutside(false);
        initViews();
        initListener(confirmClickListener);
    }

    private void initViews() {
        contentView = (TextView) findViewById(R.id.content_view);
        confirmBtn = (Button) findViewById(R.id.confirm_button);
    }

    private void initListener(View.OnClickListener confirmClickListener) {
        confirmBtn.setOnClickListener(confirmClickListener);
    }

    public void setData(String content, String confirmText) {
        contentView.setText(content);
        confirmBtn.setText(confirmText);
    }

    public void setData(String content) {
        contentView.setText(content);
    }
}
