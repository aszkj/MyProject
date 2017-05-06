package com.yldbkd.www.seller.android.wxapi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.tencent.mm.sdk.constants.ConstantsAPI;
import com.tencent.mm.sdk.modelbase.BaseReq;
import com.tencent.mm.sdk.modelbase.BaseResp;
import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.yldbkd.www.seller.android.utils.Constants;

/**
 * 微信支付回调
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class WXPayEntryActivity extends Activity implements IWXAPIEventHandler {

    public static final int SUCCESS = 0;
    public static final int FAILURE = -1;
    public static final int CANCEL = -2;
    public static final String ACTION = "wxPayAction";
    public static final String CODE = "wxPayCode";

    private IWXAPI api;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        api = WXAPIFactory.createWXAPI(this, Constants.WX_APP_ID);
        api.handleIntent(getIntent(), this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        api.handleIntent(intent, this);
    }

    @Override
    public void onReq(BaseReq baseReq) {
    }

    @Override
    public void onResp(BaseResp baseResp) {
        if (baseResp.getType() == ConstantsAPI.COMMAND_PAY_BY_WX) {
            Intent intent = new Intent();
            intent.setAction(ACTION);
            switch (baseResp.errCode) {
                case SUCCESS:
                    intent.putExtra(CODE, SUCCESS);
                    break;
                case CANCEL:
                    intent.putExtra(CODE, CANCEL);
                    break;
                case FAILURE:
                default:
                    intent.putExtra(CODE, FAILURE);
                    break;
            }
            this.sendBroadcast(intent);
        }
        this.finish();
    }
}
