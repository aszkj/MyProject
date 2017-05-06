package com.yldbkd.www.buyer.android.viewCustomer;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.library.android.common.TextChangeUtils;

import java.util.ArrayList;
import java.util.List;

public class StoreOffDialog extends Dialog {
    private TextView contentView;

    public StoreOffDialog(Context context) {
        super(context);
        setCancelable(false);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.store_notify_dialog_layout);
        setCanceledOnTouchOutside(false);
        initViews();
    }

    private void initViews() {
        contentView = (TextView) findViewById(R.id.content_view);
        Button cancelBtn = (Button) findViewById(R.id.cancel_button);
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }

    public void setData(String content) {
        contentView.setText(content);
    }
    //时间的样式特殊
    public void setData(Context context, int contentRes, String time) {
        List<Integer> timeStyles = new ArrayList<>();
        timeStyles.add(R.style.TextAppearance_Bigger_Yellow);
        TextChangeUtils.setDifferentText(context, contentView, contentRes, timeStyles, time);
    }
}
