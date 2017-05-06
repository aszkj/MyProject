package com.yldbkd.www.buyer.android.utils.update;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Handler;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.library.android.common.AppManager;

public class UpdateDialog extends Dialog {
    private TextView contentView, newVersionView, newVersionSizeView;
    private Button updateBtn, exitBtn;
    private boolean ifForce;
    private UpdateInfoBean updateInfo;
    private Handler handler;

    public UpdateDialog(Context context, UpdateInfoBean updateInfo, boolean ifForce, Handler handler) {
        super(context);
        this.ifForce = ifForce;
        this.updateInfo = updateInfo;
        this.handler = handler;
        setCancelable(false);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.update_dialog_layout);
        setCanceledOnTouchOutside(false);
        initViews();
    }

    private void initViews() {
        newVersionView = (TextView) findViewById(R.id.content_new_version);
        newVersionSizeView = (TextView) findViewById(R.id.content_new_size);
        contentView = (TextView) findViewById(R.id.content_new_desc);
        updateBtn = (Button) findViewById(R.id.confirm_button);
        exitBtn = (Button) findViewById(R.id.cancel_button);
        updateBtn.setText("立即更新");
        newVersionView.setText("是否升级到" + updateInfo.getVersionName()+"版本？");
        newVersionSizeView.setText("新版本大小：" + updateInfo.getSize());
        contentView.setText(updateInfo.getDesc());
    }

    public void setContent(String str) {
        contentView.setText(str);
    }

    public void setOnClickListener(View.OnClickListener onClickListener) {

        if (onClickListener == null) {
            throw new RuntimeException("onclicklistener must not be null");
        }
        updateBtn.setOnClickListener(onClickListener);
        exitBtn.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                if (ifForce) {
                    dismiss();
                    AppManager.getAppManager().appExit();
                } else {
                    dismiss();
                    if (handler != null) {
                        handler.obtainMessage(UpdateManager.CHECK_VERSION_FINISH).sendToTarget();
                    }
                }
            }
        });
    }
}
