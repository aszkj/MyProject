package com.yldbkd.www.buyer.android.fragment;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RatingBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.EvalutionShowActivity;
import com.yldbkd.www.buyer.android.activity.PreviewImageActivity;
import com.yldbkd.www.buyer.android.adapter.ProductEvalutionAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.bean.ProductImage;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.banner.BannerBean;
import com.yldbkd.www.library.android.banner.BannerView;
import com.yldbkd.www.library.android.banner.BannerViewAdapter;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商品页面Fragment
 * <p/>
 * Created by linghuxj on 15/11/7.
 */
public class ProductFragment extends BaseFragment {

    private SaleProduct product;
    private boolean hasDetail;

    private static final float DEFAULT_SCALE = 0.6f;

    //    private HttpBack<Store> storeHttpBack;

    private BannerView bannerView;
    private TextView storeNameView;
    private RatingBar storeRatingBar;
    //    private RatingBar storeStarView;
    //    private Button storeBtn;
    private TextView storeBusinessView;
    private TextView storeTransferView;
    private ImageView storeInfoIcon;
    private LinearLayout mLlNoProductDetail;
    private View.OnClickListener listener;

    private Handler proHandler;
    private RelativeLayout mMoreEvalution;
    private RelativeLayout mNoEvalution;
    private HttpBack<Page<Evalution>> evalutiontHttpBack;
    private List<Evalution> evalutionList = new ArrayList<>();
    private ListView mProductEvalutionListView;
    private ProductEvalutionAdapter mProductEvalutionAdapter;
    private TextView mEvalutionCount;
    private View footerView;
    private View headerView;
    private EvalutionHandler evalutionHandler = new EvalutionHandler(this);

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        product = (SaleProduct) bundle.getSerializable(Constants.BundleName.PRODUCT_INFO);
        hasDetail = bundle.getBoolean(Constants.BundleName.HAS_PRODUCT_DETAIL, false);
    }

    @Override
    public int setLayoutId() {
        initRequest();
        return R.layout.product_fragment;
    }

    @Override
    public void initView(View view) {
        mProductEvalutionListView = (ListView) view.findViewById(R.id.product_evalution_list_view);
        //评价头部
        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        headerView = inflater.inflate(R.layout.product_evalution_header_view, mProductEvalutionListView, false);
        loadHeader(headerView);
        mProductEvalutionListView.addHeaderView(headerView);
        //评价底部
        inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        footerView = inflater.inflate(R.layout.product_evalution_bottom_view, mProductEvalutionListView, false);
        loadFooter(footerView);
        mProductEvalutionListView.addFooterView(footerView);
    }

    private void loadHeader(View headerView) {
        bannerView = (BannerView) headerView.findViewById(R.id.product_banner_view);
        bannerView.setBannerHeightScale(DEFAULT_SCALE);
        TextView productNameView = (TextView) headerView.findViewById(R.id.product_name_view);
        productNameView.setText(product.getSaleProductName());

        TextView productRetailPriceView = (TextView) headerView.findViewById(R.id.product_retail_price_view);
        TextView productPromtionalPriceView = (TextView) headerView.findViewById(R.id.product_promotional_price_view);
        productRetailPriceView.setText(MoneyUtils.toPrice(product.getRetailPrice()));
        TextChangeUtils.setMoneyText(getActivity(), productPromtionalPriceView, MoneyUtils.toPrice(product.getPromotionalPrice()), R.style.TextAppearance_Normal_Red);

        TextView productSpecView = (TextView) headerView.findViewById(R.id.product_spec_view);
        productSpecView.setText(String.format(getResources().getString(R.string.product_detail_spec),
                product.getSaleProductSpec()));

        TextView actName = (TextView) headerView.findViewById(R.id.act_name);
        if (product.getActivityInfoList() == null || product.getActivityInfoList().size() == 0) {
            actName.setVisibility(View.GONE);
        } else {
            actName.setVisibility(View.VISIBLE);
            actName.setText(product.getActivityInfoList().get(0).getActName());
        }

        mMoreEvalution = (RelativeLayout) headerView.findViewById(R.id.rl_more_product_evalution);
        mNoEvalution = (RelativeLayout) headerView.findViewById(R.id.rl_no_product_evalution);
        mEvalutionCount = (TextView) headerView.findViewById(R.id.evalution_count);
    }

    private void loadFooter(View footerView) {
        mLlNoProductDetail = (LinearLayout) footerView.findViewById(R.id.ll_no_product_detail);
        storeNameView = (TextView) footerView.findViewById(R.id.product_store_name_view);
        storeRatingBar = (RatingBar) footerView.findViewById(R.id.store_rating_view);
        storeBusinessView = (TextView) footerView.findViewById(R.id.product_store_business_time_view);
        storeTransferView = (TextView) footerView.findViewById(R.id.product_store_transfer_view);
        storeInfoIcon = (ImageView) footerView.findViewById(R.id.store_info_icon);
        RelativeLayout pullLayout = (RelativeLayout) footerView.findViewById(R.id.pull_layout);
        pullLayout.setVisibility(hasDetail ? View.VISIBLE : View.GONE);
    }

    @Override
    public void initData() {
        if (hasDetail) {
            mLlNoProductDetail.setVisibility(View.GONE);
        } else {
            mLlNoProductDetail.setVisibility(View.VISIBLE);
        }
        initAdapter();
        setStoreData();
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", 1);
        map.put("pageSize", 2);
        map.put("saleProductId", product.getSaleProductId());
        RetrofitUtils.getInstance().getEvalution(ParamUtils.getParam(map), evalutiontHttpBack);
    }

    @Override
    public void initHttpBack() {
        evalutiontHttpBack = new HttpBack<Page<Evalution>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<Evalution> evalutions) {
                if (evalutions == null || evalutions.getTotalRecords() == 0 || evalutions.getList() == null || evalutions.getList().size() == 0) {
                    showEvalutionContent();
                    return;
                }
                mEvalutionCount.setText(String.format(getResources().getString(R.string.product_evaluation_count), String.valueOf(evalutions.getTotalRecords())));
                mMoreEvalution.setVisibility(View.VISIBLE);
                mNoEvalution.setVisibility(View.GONE);
                evalutionList.addAll(evalutions.getList());
                mProductEvalutionAdapter.notifyDataSetChanged();
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                showEvalutionContent();
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                showEvalutionContent();
            }
        };
    }

    private void showEvalutionContent() {
        mMoreEvalution.setVisibility(View.GONE);
        mNoEvalution.setVisibility(View.VISIBLE);
    }

    @Override
    public void initListener() {
        changeBtn();
        mMoreEvalution.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), EvalutionShowActivity.class);
                intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                startActivity(intent);
            }
        });
    }

    private void initAdapter() {
        mProductEvalutionAdapter = new ProductEvalutionAdapter(getActivity(), evalutionList, evalutionHandler);
        mProductEvalutionListView.setAdapter(mProductEvalutionAdapter);

        if (product.getSaleProductImageList() == null || product.getSaleProductImageList().size() == 0) {
            ArrayList<ProductImage> productImages = new ArrayList<>();
            ProductImage productImage = new ProductImage();
            productImage.setSaleProductImageUrl(product.getSaleProductImageUrl());
            productImages.add(productImage);
            product.setSaleProductImageList(productImages);
        }
        List<BannerBean> bannerList = new ArrayList<>();
        for (ProductImage productImage : product.getSaleProductImageList()) {
            BannerBean banner = new BannerBean();
            banner.setImageUrl(productImage.getSaleProductImageUrl());
            bannerList.add(banner);
        }

        BannerViewAdapter adapter = new BannerViewAdapter<BannerBean>(
                bannerView.getContext(), bannerList, ImageView.ScaleType.CENTER_INSIDE) {
            @Override
            public void jumpTo(int position) {
            }
        };
        bannerView.setAdapter(adapter, bannerList);
        bannerView.startPlay();
    }

    private void changeBtn() {
        if (listener == null) {
            listener = new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (proHandler != null) {
                        int[] startLocation = new int[2];
                        view.getLocationInWindow(startLocation);
                        proHandler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, startLocation).sendToTarget();
                    }
                    changeBtn();
                }
            };
        }
    }

    private void setStoreData() {
        Store storeInfo = CommunityUtils.getCurrentStore();
        if (storeInfo != null) {
            storeNameView.setText(storeInfo.getStoreName());
            storeBusinessView.setText(String.format(getResources().getString(R.string.product_store_business),
                    storeInfo.getBusinessHoursBegin().substring(0, 5), storeInfo.getBusinessHoursEnd().substring(0, 5)));
            storeTransferView.setText(storeInfo.getTransCostAmount() == null || storeInfo.getTransCostAmount() == 0 ? String.format(getResources().getString(R.string.product_store_transfer_free)) : String.format(getResources().getString(R.string.product_store_transfer),
                    MoneyUtils.toPrice(storeInfo.getDeduceTransCostAmount()), MoneyUtils.toPrice(storeInfo.getTransCostAmount())));
            if (CommunityUtils.isStoreOn(storeInfo)) {
                storeInfoIcon.setImageResource(R.mipmap.store_on);
            } else {
                storeInfoIcon.setImageResource(R.mipmap.store_off);
            }
            storeRatingBar.setRating(storeInfo.getStoreScore() == null ? 5f : storeInfo.getStoreScore());
        }
    }

    public void setProHandler(Handler proHandler) {
        this.proHandler = proHandler;
    }

    private static class EvalutionHandler extends Handler {
        WeakReference<ProductFragment> fragmentWeakReference;

        public EvalutionHandler(ProductFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final ProductFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.EVALUTIONPICTUREITEM:
                    fragment.addEvalutionPicture(msg.arg1, msg.arg2);
                    break;
            }
        }
    }

    private void addEvalutionPicture(int position1, int position2) {
        Intent intent = new Intent(getActivity(), PreviewImageActivity.class);
        intent.putExtra(Constants.BundleName.PRODUCT_EVALUTION, evalutionList.get(position1));
        intent.putExtra(Constants.BundleName.IMAGE_NUMBER, position2);
        startActivity(intent);
    }
}