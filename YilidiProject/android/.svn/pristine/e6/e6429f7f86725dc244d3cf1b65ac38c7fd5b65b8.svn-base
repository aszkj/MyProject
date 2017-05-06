package com.yldbkd.www.buyer.android.wxapi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.tencent.mm.sdk.constants.ConstantsAPI;
import com.tencent.mm.sdk.modelbase.BaseReq;
import com.tencent.mm.sdk.modelbase.BaseResp;
import com.tencent.mm.sdk.modelmsg.SendAuth;
import com.tencent.mm.sdk.openapi.IWXAPIEventHandler;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.utils.Constants;


/**
 * @author Administrator
 * @version $Rev$
 * @time 2016/9/28 10:39
 * @des
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class WXEntryActivity extends Activity implements IWXAPIEventHandler {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        BuyerApp.iwxapi.handleIntent(getIntent(), this);
    }

    @Override
    public void onReq(BaseReq req) {
    }

    @Override
    public void onResp(BaseResp resp) {
        int errCode = resp.errCode;
        if (resp.getType() == ConstantsAPI.COMMAND_SENDMESSAGE_TO_WX) {//微信分享在分享页面处理
            Intent intent = new Intent();
            intent.setAction(Constants.Receiver.WXSHAREACTION);
            switch (errCode) {
                case BaseResp.ErrCode.ERR_OK:
                    intent.putExtra(Constants.BundleName.SHARERESULT, Constants.ResultCode.SUCCESS);
                    break;
                case BaseResp.ErrCode.ERR_USER_CANCEL:
                    intent.putExtra(Constants.BundleName.SHARERESULT, Constants.ResultCode.CANCEL);
                    break;
                case BaseResp.ErrCode.ERR_AUTH_DENIED:
                default:
                    intent.putExtra(Constants.BundleName.SHARERESULT, Constants.ResultCode.FAILURE);
                    break;
            }
            this.sendBroadcast(intent);
        } else if (resp.getType() == ConstantsAPI.COMMAND_SENDAUTH) {//微信授权登陆在登录页面处理
            Intent intent = new Intent();
            intent.setAction(Constants.Receiver.WXLOGINACTION);
            switch (errCode) {
                case BaseResp.ErrCode.ERR_OK:
                    intent.putExtra(Constants.BundleName.LOGINRESULT, Constants.ResultCode.SUCCESS);
                    intent.putExtra(Constants.BundleName.LOGINCODE, ((SendAuth.Resp) resp).code);
                    break;
                case BaseResp.ErrCode.ERR_USER_CANCEL:
                    intent.putExtra(Constants.BundleName.LOGINRESULT, Constants.ResultCode.CANCEL);
                    break;
                case BaseResp.ErrCode.ERR_AUTH_DENIED:
                default:
                    intent.putExtra(Constants.BundleName.LOGINRESULT, Constants.ResultCode.FAILURE);
                    break;
            }
            this.sendBroadcast(intent);
        }
        this.finish();
    }
}
