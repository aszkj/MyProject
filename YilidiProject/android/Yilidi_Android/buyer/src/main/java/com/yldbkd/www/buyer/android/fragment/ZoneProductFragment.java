package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.adapter.ZoneProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.SeminarInfo;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.viewCustomer.GridInScrollView;
import com.yldbkd.www.library.android.viewCustomer.ObservableScrollView;
import com.yldbkd.www.library.android.viewCustomer.ScrollViewListener;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 专区产品列表页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/10.
 */
public class ZoneProductFragment extends BaseFragment {
    private View zoneView;

    private RelativeLayout backView;
    private ImageView backImage, dividerLine;
    private TextView titleView;
    private TextView zoneTitleView;
    private RelativeLayout zoneBackView;

    //图片
    private ImageView zoneImage;
    private ImageView zoneSloganImage;
    private ObservableScrollView scrollView;
    private boolean isImageEmpty;
    private View zoneImageShow;
    private View zoneImageHide;

    //购物车
    private RelativeLayout cartBtn;
    private TextView cartNumView;
    private ImageView cartNumBg;
    private ZoneHandler zoneHandler = new ZoneHandler(this);
    private String mZoneCode;

    //刷新数据
    private boolean isRefreshItem = true;
    private List<SaleProduct> saleProductLists = new ArrayList<>();
    private HttpBack<SeminarInfo> seminarHttpBack;
    private ZoneProductAdapter productAdapter;
    private RelativeLayout mNodataRL;
    private GridInScrollView gridView;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        //获取类型code
        mZoneCode = bundle.getString(Constants.BundleName.ZONE_CODE, "");
    }

    @Override
    public int setLayoutId() {
        return R.layout.zone_product_fragment;
    }

    @Override
    public void initView(View view) {
        zoneView = view.findViewById(R.id.zone_view);

        zoneImageHide = view.findViewById(R.id.zone_image_hide);
        titleView = (TextView) view.findViewById(R.id.title_view);
        backView = (RelativeLayout) view.findViewById(R.id.back_view);

        zoneImageShow = view.findViewById(R.id.zone_image_show);

        zoneBackView = (RelativeLayout) view.findViewById(R.id.zone_back_view);
        backImage = (ImageView) view.findViewById(R.id.zone_back_image);
        dividerLine = (ImageView) view.findViewById(R.id.zone_divider_line);
        zoneTitleView = (TextView) view.findViewById(R.id.zone_title_view);

        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);

        zoneImage = (ImageView) view.findViewById(R.id.zone_image);
        zoneSloganImage = (ImageView) view.findViewById(R.id.zone_image_slogan);
        scrollView = (ObservableScrollView) view.findViewById(R.id.scrollview);
        scrollView.smoothScrollTo(0, 0);
        gridView = (GridInScrollView) view.findViewById(R.id.lv_zone_product);
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
    }

    @Override
    public void initData() {
        initAdapter();
        initRequest();
    }

    private void toolBarShow(boolean isShow) {
        zoneImage.setVisibility(isShow ? View.GONE : View.VISIBLE);
        zoneImageHide.setVisibility(isShow ? View.VISIBLE : View.GONE);
        zoneImageShow.setVisibility(isShow ? View.GONE : View.VISIBLE);
    }

    private void initAdapter() {
        productAdapter = new ZoneProductAdapter(saleProductLists, getActivity(), 1, zoneHandler);
        gridView.setAdapter(productAdapter);
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
        CartUtils.calculateProductNum(saleProductLists);
        if (productAdapter != null) {
            productAdapter.notifyDataSetChanged();
        }
    }

    @Override
    public void initHttpBack() {
        seminarHttpBack = new HttpBack<SeminarInfo>() {
            @Override
            public void onSuccess(SeminarInfo seminarInfo) {
                titleView.setText(TextUtils.isEmpty(seminarInfo.getThemeName())
                        ? getResources().getString(R.string.zone_product) :
                        seminarInfo.getThemeName());
                //初始化显示数据--有图片
                zoneTitleView.setText(seminarInfo.getThemeName());
                zoneTitleView.setVisibility(View.GONE);
                backImage.setBackgroundResource(R.mipmap.back_btn_product_detail);
                dividerLine.setVisibility(View.GONE);

                isImageEmpty = TextUtils.isEmpty(seminarInfo.getThemeImageUrl());
                toolBarShow(isImageEmpty);
                if (!isImageEmpty) {
                    ImageLoaderUtils.load(zoneImage, seminarInfo.getThemeImageUrl(), com.yldbkd.www.library.android.R.drawable.no_picture_rect);
                }
                zoneView.setBackgroundColor(getBgColor(seminarInfo.getBaseColor()));

                boolean isEmptySlogan = TextUtils.isEmpty(seminarInfo.getSloganImageUrl());
                zoneSloganImage.setVisibility(isEmptySlogan ? View.GONE : View.VISIBLE);
                if (!isEmptySlogan) {
                    ImageLoaderUtils.load(zoneSloganImage, seminarInfo.getSloganImageUrl(), com.yldbkd.www.library.android.R.drawable.no_picture_rect);
                }

                saleProductLists.clear();
                if (seminarInfo.getSaleProducts() == null || seminarInfo.getSaleProducts().size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    return;
                }
                saleProductLists.addAll(seminarInfo.getSaleProducts());
                CartUtils.calculateProductNum(saleProductLists);
                productAdapter.notifyDataSetChanged();
            }
        };
    }

    @Override
    public void initRequest() {
        request();
    }

    private int getBgColor(String zoneColor) {
        if (zoneColor == null)
            return ContextCompat.getColor(getActivity(), R.color.background);
        if (zoneColor.charAt(0) != '#') {
            zoneColor = String.format(getResources().getString(R.string.color_header_falg), zoneColor);
        }
        try {
            return Color.parseColor(zoneColor);
        } catch (Exception e) {
            return ContextCompat.getColor(getActivity(), R.color.background);
        }
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        zoneBackView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });

        cartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent;
                if (UserUtils.isLogin()) {
                    intent = new Intent(getBaseActivity(), PurchaseActivity.class);
                    intent.setAction(CartFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(getBaseActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });

        scrollView.setScrollViewListener(new ScrollViewListener() {
            @Override
            public void onScrollChanged(ObservableScrollView scrollView, int x, int y, int oldX, int oldY) {
                if (isImageEmpty) {
                    return;
                }
                changeToolBarContext(y > zoneImage.getHeight());
            }
        });
    }

    boolean isAlpha = true;

    private void changeToolBarContext(boolean falg) {
        if (falg) {
            if (!isAlpha)
                return;
            isAlpha = false;
            backImage.setBackgroundResource(R.mipmap.back_btn);
            zoneTitleView.setVisibility(View.VISIBLE);
            dividerLine.setVisibility(View.VISIBLE);
            zoneImageShow.setBackgroundResource(R.color.white);
        } else {
            if (isAlpha)
                return;
            isAlpha = true;
            backImage.setBackgroundResource(R.mipmap.back_btn_product_detail);
            zoneTitleView.setVisibility(View.GONE);
            dividerLine.setVisibility(View.GONE);
            zoneImageShow.setBackgroundResource(R.color.trans_bg);
        }
    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("typeCode", mZoneCode);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).seminarInfo(ParamUtils.getParam(map), seminarHttpBack);
    }

    private static class ZoneHandler extends Handler {
        WeakReference<ZoneProductFragment> fragmentWeakReference;

        public ZoneHandler(ZoneProductFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final ZoneProductFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            SaleProduct product = fragment.saleProductLists.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj, msg.arg2);
                    break;
                case Constants.HandlerCode.CLEANPRODUCTFORVIP:
                    fragment.isRefreshItem = false;
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(fragment.saleProductLists);

                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    fragment.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(fragment.getBaseActivity(), startLocation, endLocation,
                            fragment.cartNumBg, fragment.cartNumView, null);
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    product.setCartNum(product.getCartNum() - 1);
                    CartUtils.removeCart(product);
                    fragment.flushCart();
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    Intent intent = new Intent(fragment.getActivity(), ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                    fragment.startActivity(intent);
                    break;
            }
            if (fragment.isRefreshItem) {
                fragment.productAdapter.changeProductNum(
                        fragment.productAdapter.getItemView(fragment.gridView, msg.arg2), msg.arg2);
            } else {
                fragment.productAdapter.notifyDataSetChanged();
            }
            fragment.isRefreshItem = true;
        }
    }

    public void flushCart() {
        Integer count = CartUtils.getCartCount();
        if (count > 0) {
            cartNumBg.setVisibility(View.VISIBLE);
            cartNumView.setVisibility(View.VISIBLE);
            if (count > 99) {
                cartNumView.setText("99+");
                cartNumView.setTextSize(5f);
            } else {
                cartNumView.setText(String.valueOf(count));
                cartNumView.setTextSize(10f);
            }
        } else {
            cartNumBg.setVisibility(View.INVISIBLE);
            cartNumView.setVisibility(View.INVISIBLE);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == Constants.RequestCode.LOGIN_CODE && resultCode == Activity.RESULT_OK) {
            if (UserUtils.isLogin()) {
                Intent intent = new Intent(getBaseActivity(), MainActivity.class);
                startActivity(intent);
            }
        }
    }
}
