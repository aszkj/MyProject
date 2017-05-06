package com.yldbkd.www.buyer.android.activity;

import android.content.Intent;

import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.zxing.MipcaActivityCapture;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/7/27 19:00
 * @des 扫描完成后的处理
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class ScanActivity extends MipcaActivityCapture {

    @Override
    public void scanResult(String result) {
        Intent intent = new Intent(ScanActivity.this, ScanResultActivity.class);
        intent.putExtra(Constants.BundleName.SCAN_RESULT, result);
        startActivity(intent);
    }
}
