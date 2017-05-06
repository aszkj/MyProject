package com.yldbkd.www.buyer.android.viewCustomer;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import com.yldbkd.www.buyer.android.R;

/**
 * 默认的三选项的对话框
 * <p/>
 * Created by linghuxj on 15/11/24.
 */
public class ThreeSelectorDialog extends Dialog {
    private Context context;
    private Button firstBtn, secondBtn, cancelBtn;

    public ThreeSelectorDialog(Context context, View.OnClickListener firstClickListener, View.OnClickListener
            secondClickListener) {
        super(context);
        this.context = context;
        setCancelable(false);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.three_selector_dialog);
        setCanceledOnTouchOutside(false);
        initViews();
        initListener(firstClickListener, secondClickListener);
    }

    private void initViews() {
        firstBtn = (Button) findViewById(R.id.first_button);
        secondBtn = (Button) findViewById(R.id.second_button);
        cancelBtn = (Button) findViewById(R.id.cancel_button);
    }

    private void initListener(View.OnClickListener firstClickListener, View.OnClickListener secondClickListener) {
        firstBtn.setOnClickListener(firstClickListener);
        secondBtn.setOnClickListener(secondClickListener);
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }

    public void setData(String firstText, String secondText) {
        firstBtn.setText(firstText);
        secondBtn.setText(secondText);
    }

    public void setData(int firstTextResId, int secondTextResId) {
        firstBtn.setText(context.getResources().getString(firstTextResId));
        secondBtn.setText(context.getResources().getString(secondTextResId));
    }

    public void setVisiableItem(Integer itemPosition) {
        if (itemPosition == null) {
            return;
        }
        if (itemPosition == 1) {
            secondBtn.setVisibility(View.GONE);
        } else if (itemPosition == 2) {
            firstBtn.setVisibility(View.GONE);
        }
    }
}
