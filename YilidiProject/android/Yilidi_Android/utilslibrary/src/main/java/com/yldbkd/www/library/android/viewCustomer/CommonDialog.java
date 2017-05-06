package com.yldbkd.www.library.android.viewCustomer;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.text.TextUtils;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.library.android.R;

public class CommonDialog extends Dialog {
    private TextView contentView;
    private Button confirmBtn, cancelBtn;

    public CommonDialog(Context context, View.OnClickListener confirmClickListener) {
        this(context, confirmClickListener, null);
    }

    public CommonDialog(Context context, View.OnClickListener confirmClickListener,
                        View.OnClickListener cancelClickListener) {
        super(context);
        setCancelable(false);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.common_dialog_layout);
        setCanceledOnTouchOutside(false);
        initViews();
        initListener(confirmClickListener, cancelClickListener);
    }

    private void initViews() {
        contentView = (TextView) findViewById(R.id.content_view);
        confirmBtn = (Button) findViewById(R.id.confirm_button);
        cancelBtn = (Button) findViewById(R.id.cancel_button);
    }

    private void initListener(View.OnClickListener confirmClickListener, View.OnClickListener cancelClickListener) {
        confirmBtn.setOnClickListener(confirmClickListener);
        if (cancelClickListener == null) {
            cancelBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    dismiss();
                }
            });
        } else {
            cancelBtn.setOnClickListener(cancelClickListener);
        }
    }

    public void setData(String content, String confirmText) {
        setData(content, confirmText, null);
    }

    public void setData(String content, String confirmText, String cancelText) {
        contentView.setText(content);
        confirmBtn.setText(confirmText);
        if (!TextUtils.isEmpty(cancelText)) {
            cancelBtn.setText(cancelText);
        }
    }
}
