package com.yldbkd.www.buyer.android.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AbsListView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RatingBar;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.EvalutionEditAdapter;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.buyer.android.bean.ImageUrlBean;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.bean.OrderEvalution;
import com.yldbkd.www.buyer.android.utils.BitmapUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.ImageUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;

import java.io.File;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/8 9:43
 * @描述 订单商品评价
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class EvalutionActivity extends BaseActivity {
    private OrderDetail mOrderDetail;
    private View backView;
    private TextView mTitleView;
    private ListView mEvalutionListView;
    private View footerView;
    private RatingBar storeServiceRatingView;
    private RatingBar storeSendRatingView;
    private boolean isAnonymous = false;
    private ImageView mAnonymousEvalutionImage;
    private Button mCommitEvalutionBtn;
    private OrderEvalution orderEvalution = new OrderEvalution();
    private List<Evalution> evalutions = new ArrayList<>();
    private EvalutionEditAdapter mEvalutionEditAdapter;
    private EvalutionHandler evalutionHandler = new EvalutionHandler(this);
    private HttpBack<BaseModel> saveEvalutionHttpBack;
    private CommonDialog giveUpDialog;
    //图片处理
    private int productPosition;
    private int imagePosition;
    protected static final int CHOOSE_PICTURE = 0;
    protected static final int TAKE_PICTURE = 1;

    private File imageFile;
    private ImageUtils imageUtils;
    private int lastIndex = 0;
    private String lastContent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.evalution_activity);
        mOrderDetail = (OrderDetail) getIntent().getSerializableExtra(Constants.BundleName.ORDER_DETAIL);

        initView();
        initData();
        initListener();
        initHttpBack();
        initRequest();
    }

    private void initView() {
        backView = findViewById(R.id.back_view);
        mTitleView = (TextView) findViewById(R.id.title_view);

        mEvalutionListView = (ListView) findViewById(R.id.evalution_edit_view);
        LayoutInflater inflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        footerView = inflater.inflate(R.layout.evalution_edit_item_footer, mEvalutionListView, false);
        loadFooter(footerView);
        mEvalutionListView.addFooterView(footerView);

        mAnonymousEvalutionImage = (ImageView) findViewById(R.id.anonymous_evalution_image);
        mCommitEvalutionBtn = (Button) findViewById(R.id.commit_evalution_btn);
    }

    private void loadFooter(View footerView) {
        storeServiceRatingView = (RatingBar) footerView.findViewById(R.id.store_service_rating_view);
        storeSendRatingView = (RatingBar) footerView.findViewById(R.id.store_send_rating_view);
    }

    private void initData() {
        mTitleView.setText(getResources().getString(R.string.order_evalution_order));
        imageUtils = new ImageUtils(this, null);

        getDefaultEvalution();
        checkedCommitButton();
        initAdapter();
    }

    private void initAdapter() {
        mEvalutionEditAdapter = new EvalutionEditAdapter(this, mOrderDetail.getSaleOrderItemList(), evalutionHandler);
        mEvalutionEditAdapter.setEvalutiondata(orderEvalution.getSaleProductEvaluations());
        mEvalutionListView.setAdapter(mEvalutionEditAdapter);
    }

    private void initHttpBack() {
        saveEvalutionHttpBack = new HttpBack<BaseModel>(this) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                ToastUtils.showShort(EvalutionActivity.this, getResources().getString(R.string.evaluation_success));
                finish();
            }
        };
    }

    public void initRequest() {
    }

    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                giveUpEvalution();
            }
        });
        mAnonymousEvalutionImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isAnonymous = !isAnonymous;
                mAnonymousEvalutionImage.setImageResource(isAnonymous ? R.mipmap.on : R.mipmap.off);
                orderEvalution.setIsAnonymous(isAnonymous ? 1 : 0);
            }
        });
        mCommitEvalutionBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeProductContent(lastIndex, lastContent);
                CommitEvalution();
            }
        });
        storeServiceRatingView.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener() {
            @Override
            public void onRatingChanged(RatingBar ratingBar, float rating, boolean fromUser) {
                changeEvalutionServiceScore(rating);
            }
        });
        storeSendRatingView.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener() {
            @Override
            public void onRatingChanged(RatingBar ratingBar, float rating, boolean fromUser) {
                changeEvalutionDelivesScore(rating);
            }
        });
        //移除子View时候移除子View上面的焦点
        mEvalutionListView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {
                if (SCROLL_STATE_TOUCH_SCROLL == scrollState) {
                    View currentFocus = getCurrentFocus();
                    if (currentFocus != null) {
                        currentFocus.clearFocus();
                    }
                }
            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {

            }
        });
    }

    private void giveUpEvalution() {
        if (giveUpDialog != null && giveUpDialog.isShowing()) {
            return;
        }
        giveUpDialog = new CommonDialog(this, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                giveUpDialog.dismiss();
                onBackPressed();
            }
        });
        giveUpDialog.setData(getResources().getString(R.string.evaluation_dialog_content),
                getResources().getString(R.string.dialog_confirm));
        giveUpDialog.show();
    }

    private void CommitEvalution() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", mOrderDetail.getOrderBaseInfo().getSaleOrderNo());
        map.put("serviceScore", orderEvalution.getServiceScore());
        map.put("deliverScore", orderEvalution.getDeliverScore());
        map.put("isAnonymous", orderEvalution.getIsAnonymous());
        map.put("saleProductEvaluations", orderEvalution.getSaleProductEvaluations());
        RetrofitUtils.getInstance(true).saveEvalution(ParamUtils.getParam(map), saveEvalutionHttpBack);
    }

    public void getDefaultEvalution() {
        orderEvalution.setServiceScore(0f);
        orderEvalution.setDeliverScore(0f);
        orderEvalution.setIsAnonymous(0);
        for (int i = 0; i < mOrderDetail.getSaleOrderItemList().size(); i++) {
            Evalution evalution = new Evalution();
            evalution.setSaleProductId(mOrderDetail.getSaleOrderItemList().get(i).getSaleProductId());
            evalution.setSaleProductScore(0f);
            evalution.setEvaluateContent("");
            List<ImageUrlBean> imageUrls = new ArrayList<>();
            evalution.setEvaluateImages(imageUrls);
            evalutions.add(evalution);
        }
        orderEvalution.setSaleProductEvaluations(evalutions);
    }

    private void changeEvalutionDelivesScore(float score) {
        orderEvalution.setDeliverScore(score);
        checkedCommitButton();
    }

    private void changeEvalutionServiceScore(float score) {
        orderEvalution.setServiceScore(score);
        checkedCommitButton();
    }

    private void changeProductEvalution(int score, int position) {
        orderEvalution.getSaleProductEvaluations().get(position).setSaleProductScore(Float.valueOf(score));
        mEvalutionEditAdapter.setEvalutiondata(orderEvalution.getSaleProductEvaluations());
        checkedCommitButton();
    }

    private void changeProductContent(int position, String content) {
        if (TextUtils.isEmpty(content)) {
            return;
        }
        orderEvalution.getSaleProductEvaluations().get(position).setEvaluateContent(CheckUtils.filterSpecialCharacter(content));
        mEvalutionEditAdapter.setEvalutiondata(orderEvalution.getSaleProductEvaluations());
    }

    private void checkedCommitButton() {
        if (checkedData()) {
            mCommitEvalutionBtn.setBackgroundColor(ContextCompat.getColor(this, R.color.colorYellow));
            mCommitEvalutionBtn.setEnabled(true);
        } else {
            mCommitEvalutionBtn.setBackgroundColor(ContextCompat.getColor(this, R.color.lightText));
            mCommitEvalutionBtn.setEnabled(false);
        }
    }

    private boolean checkedData() {
        if (orderEvalution.getServiceScore() < 1) {
            return false;
        }
        if (orderEvalution.getDeliverScore() < 1) {
            return false;
        }
        for (Evalution evalution : evalutions) {
            if (evalution == null || evalution.getSaleProductScore() == null || evalution.getSaleProductScore() < 1) {
                return false;
            }
        }
        return true;
    }

    private void addEvalutionPicture(int position1, int position2) {
        productPosition = position1;
        imagePosition = position2;
        if (evalutions.get(position1).getEvaluateImages() == null || evalutions.get(position1).getEvaluateImages().size() == 0 ||
                evalutions.get(position1).getEvaluateImages().size() == position2) {
            // 指定照片保存路径
            imageFile = imageUtils.getPublicPicturePathFile();
            imageUtils.showChoosePicDialog(imageFile, true, false);
        } else {
            Intent intent = new Intent(this, PreviewImageActivity.class);
            intent.putExtra(Constants.BundleName.PRODUCT_EVALUTION, orderEvalution.getSaleProductEvaluations().get(position1));
            intent.putExtra(Constants.BundleName.DELETE_IMAGE, true);
            intent.putExtra(Constants.BundleName.IMAGE_NUMBER, position2);
            startActivityForResult(intent, Constants.RequestCode.DELETE_IMAGE_CODE);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) { // 如果返回码是可以用的
            switch (requestCode) {
                case TAKE_PICTURE:
                    if (null == imageFile) {
                        return;
                    }
                    imageUtils.refreshTheAlbum(imageFile, this);//刷新相册
                    getPicturePathAndUpload(imageFile.toString());
                    break;
                case CHOOSE_PICTURE:
                    if (data == null) {
                        return;
                    }
                    getPicturePathAndUpload(imageUtils.getPhoto(data.getData(), this));
                    break;
            }
        }
        if (requestCode == Constants.RequestCode.DELETE_IMAGE_CODE) {
            if (Constants.ResultCode.SUCCESS == resultCode) {
                Evalution evalution = (Evalution) data.getSerializableExtra(Constants.BundleName.PRODUCT_EVALUTION);
                orderEvalution.getSaleProductEvaluations().get(productPosition).setEvaluateImages(evalution.getEvaluateImages());
                refreshImageRecycleView();
            }
        }
    }

    /**
     * 根据文件路径对图片进行处理
     *
     * @param filePath
     */
    private void getPicturePathAndUpload(final String filePath) {
        if (TextUtils.isEmpty(filePath)) {
            return;
        }
        new Thread(new Runnable() {
            @Override
            public void run() {
                String tempPath = filePath;
                BitmapFactory.Options options = BitmapUtils.commpressImage(tempPath, 750f, 2f, 0.5f);
                if (options == null) {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            ToastUtils.showShort(EvalutionActivity.this, getResources().getString(R.string.image_size_error_toast));
                        }
                    });
                    return;
                }
                Bitmap bitmap = BitmapFactory.decodeFile(tempPath, options);
                if (bitmap == null) {
                    addEvalutionPictureFail();
                    return;
                }
                tempPath = BitmapUtils.getImagePath(bitmap);
                BitmapUtils.uploadImage(Constants.UpLoadImageAddress.EVALUTIONREQUESTURL, tempPath, evalutionHandler, Constants.HandlerCode.EVALUTIONPICTURERESULTSUCCESS, Constants.HandlerCode.EVALUTIONPICTURERESULTFAIL);
            }
        }).start();
    }

    private static class EvalutionHandler extends Handler {
        WeakReference<EvalutionActivity> fragmentWeakReference;

        public EvalutionHandler(EvalutionActivity activity) {
            fragmentWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final EvalutionActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.EVALUTIONSTART:
                    activity.changeProductEvalution(msg.arg1, msg.arg2);
                    break;
                case Constants.HandlerCode.EVALUTIONCONTENT:
                    activity.changeProductContent(msg.arg1, msg.obj.toString().trim());
                    break;
                case Constants.HandlerCode.EVALUTIONLASTCONTENT:
                    activity.lastContent = msg.obj.toString().trim();
                    activity.lastIndex = msg.arg1;
                    break;
                case Constants.HandlerCode.EVALUTIONPICTUREITEM:
                    activity.addEvalutionPicture(msg.arg1, msg.arg2);
                    break;
                case Constants.HandlerCode.EVALUTIONPICTURERESULTSUCCESS:
                    activity.addEvalutionPictureResult(msg.obj.toString());
                    break;
                case Constants.HandlerCode.EVALUTIONPICTURERESULTFAIL:
                    activity.addEvalutionPictureFail();
                    break;
            }
        }
    }

    private void addEvalutionPictureFail() {
        ToastUtils.showShort(this, getResources().getString(R.string.uploadimage_error_toast));
    }

    private void addEvalutionPictureResult(String imageUrl) {
        if (orderEvalution.getSaleProductEvaluations().get(productPosition).getEvaluateImages().size() <= imagePosition) {
            List<ImageUrlBean> evaluateImages = orderEvalution.getSaleProductEvaluations().get(productPosition).getEvaluateImages();
            evaluateImages.add(new ImageUrlBean());
        }
        orderEvalution.getSaleProductEvaluations().get(productPosition).getEvaluateImages().get(imagePosition).setImageUrl(imageUrl);
        refreshImageRecycleView();
    }

    private void refreshImageRecycleView() {
        mEvalutionEditAdapter.notifyDataSetChanged();
        mEvalutionEditAdapter.refreshData();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
            giveUpEvalution();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
