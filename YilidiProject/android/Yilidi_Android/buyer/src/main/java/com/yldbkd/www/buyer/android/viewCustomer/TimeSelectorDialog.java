package com.yldbkd.www.buyer.android.viewCustomer;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.LinearLayout;
import com.yldbkd.www.buyer.android.R;

public class TimeSelectorDialog extends Dialog {
    private LinearLayout contentView;
    private Button confirmBtn, cancelBtn;

    public TimeSelectorDialog(Context context, View.OnClickListener clickListener) {
        super(context);
        setCancelable(false);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.time_dialog_layout);
        setCanceledOnTouchOutside(false);
        initViews();
        initListener(clickListener);
    }

    private void initViews() {
        contentView = (LinearLayout) findViewById(R.id.content_view);
        confirmBtn = (Button) findViewById(R.id.confirm_button);
        cancelBtn = (Button) findViewById(R.id.cancel_button);
    }

    private void initListener(View.OnClickListener clickListener) {
        confirmBtn.setOnClickListener(clickListener);
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }

    public void addView(View view, LinearLayout.LayoutParams layoutParams) {
        contentView.addView(view, layoutParams);
    }
}
