package com.yldbkd.www.buyer.android.utils.update;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.View;
import android.view.Window;
import android.widget.ProgressBar;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;

public class DownloadDialog extends Dialog {
    private ProgressBar progress;
    private TextView percent;
    private TextView cancelBtn;

    public DownloadDialog(Context context) {
        super(context);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.update_progress);
        setCancelable(false);
        setCanceledOnTouchOutside(false);
        initViews();
    }

    private void initViews() {
        progress = (ProgressBar) findViewById(R.id.update_progress);
        percent = (TextView) findViewById(R.id.update_progress_text);
        cancelBtn = (TextView) findViewById(R.id.cancel);
    }

    public void setOnClickListener(View.OnClickListener onClickListener) {

        if (onClickListener == null) {
            throw new RuntimeException("onclicklistener must not be null");
        }
        this.dismiss();
        cancelBtn.setOnClickListener(onClickListener);
    }

    public ProgressBar getProgress() {
        return progress;
    }

    public TextView getPercent() {
        return percent;
    }

}
