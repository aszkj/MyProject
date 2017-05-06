package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.AddressActivity;
import com.yldbkd.www.buyer.android.activity.CalcCenterActivity;
import com.yldbkd.www.buyer.android.adapter.CartProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.AddressBase;
import com.yldbkd.www.buyer.android.bean.Cart;
import com.yldbkd.www.buyer.android.bean.CartConfirm;
import com.yldbkd.www.buyer.android.bean.CartInfo;
import com.yldbkd.www.buyer.android.bean.CartStore;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.LocationUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.CartSectionView;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 购物车页面
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class CartFragment extends BaseFragment implements CartSectionView.OnItemSelectListener {

    private RelativeLayout backView;
    private TextView titleView;
    private ImgTxtButton mRightView;
    private boolean isEdit = false;

    private RelativeLayout addressEmptyLayout;
    private RelativeLayout addressDetailLayout;
    private TextView addressConsigneeView, addressPhoneView, addressDetailView;
    private TextView storeName;
    private TextView storeTransfer;
    private RelativeLayout cartBottomLayout;

    private LinearLayout emptyLayout;
    private Button emptyBuyBtn;
    private ListView cartListView;
    private CartProductAdapter productAdapter;
    private RelativeLayout layoutPrice;
    private Button delectProductBtn;
    private Button moveProductToCollectBtn;

    private List<SaleProduct> products = new ArrayList<>();
    private Integer addressId;
    private HttpBack<Cart> cartHttpBack;
    private HttpBack<CartConfirm> purchaseHttpBack;
    private AddressBase saveAddress;

    private Map<Integer, CartInfo> cartInfo;

    private CommonDialog removeDialog;

    private LinearLayout allCheckLayout;
    private ImageView allCheckView;
    private Button confirmBtn;
    private TextView totalAmtView;
    private TextView transferView;

    private boolean allCheckFlag = true;
    private boolean isShowAddressDetail = false;
    //footer
    private ClearableEditText noteView;
    private String note;

    private CartStore mCartStore;
    private static final Integer MAX_SIZE = 128;
    private int firstCartCount = -1;
    private LocationUtils location = LocationUtils.getInstance();
    private double mLatitude;
    private double mLongitude;
    //自提
    private LinearLayout mLlToke;
    private TextView mTvStoreName;
    private TextView mTvStoreTime;
    private TextView mTvStoreAddress;
    private boolean isToke = false;

    private CartSectionView mCartSectionView;
    private long mTransCount;
    private long mDeduceTransCostAmount;
    private String mStoreName;
    private String mBusinessHoursBegin;
    private String mBusinessHoursEnd;
    private String mStoreAddress;
    private String mStorePickUpTimeNote;
    private String mCurrentCommunityName;
    private String mDeliveryTimeNote;
    private Integer mCurrentStoreId;
    private Integer mStoreId;
    private String mStoreStatus;

    private HttpBack<AddressBase> addressDetailHttpBack;

    @Override
    public void initBundle() {
        //定位
        location.init(getActivity());
        location.registerLocationListener(new LocationListener());
    }

    @Override
    public int setLayoutId() {
        return R.layout.cart_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        mRightView = (ImgTxtButton) view.findViewById(R.id.right_view);

        emptyLayout = (LinearLayout) view.findViewById(R.id.cart_empty_layout);
        emptyBuyBtn = (Button) view.findViewById(R.id.cart_empty_btn);
        cartListView = (ListView) view.findViewById(R.id.cart_list_view);
        allCheckLayout = (LinearLayout) view.findViewById(R.id.cart_all_check_layout);
        allCheckView = (ImageView) view.findViewById(R.id.cart_all_checkbox);
        confirmBtn = (Button) view.findViewById(R.id.cart_confirm_btn);
        totalAmtView = (TextView) view.findViewById(R.id.cart_total_amount_view);
        transferView = (TextView) view.findViewById(R.id.cart_transfer_view);
        cartBottomLayout = (RelativeLayout) view.findViewById(R.id.cart_bottom_layout);

        layoutPrice = (RelativeLayout) view.findViewById(R.id.layout_price);
        delectProductBtn = (Button) view.findViewById(R.id.delete_product_btn);
        moveProductToCollectBtn = (Button) view.findViewById(R.id.move_product_collect_btn);
    }

    @Override
    public void initData() {
        titleView.setText(getResources().getString(R.string.cart_tab_name));
        mRightView.setText(getResources().getString(R.string.butten_edit));
        mRightView.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
        showEditView();
        mCurrentCommunityName = CommunityUtils.getCurrentCommunityName();
        mCurrentStoreId = CommunityUtils.getCurrentStoreId();
        initAdapter();
    }

    @Override
    public void onResume() {
        super.onResume();
        checkAddress();
        if (firstCartCount != CartUtils.getCartCount()) {
            initRequest();
            location.startLoc();
        }
    }

    private void showEditView() {
        delectProductBtn.setVisibility(isEdit ? View.VISIBLE : View.GONE);
        //多商品收藏暂时不做
        moveProductToCollectBtn.setVisibility(View.GONE);
        confirmBtn.setVisibility(isEdit ? View.GONE : View.VISIBLE);
        layoutPrice.setVisibility(isEdit ? View.GONE : View.VISIBLE);
    }

    private void checkAddress() {
        if (addressId != null && addressId != 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("addressId", addressId);
            RetrofitUtils.getInstance(true).getAddressDetail(ParamUtils.getParam(map), addressDetailHttpBack);
        }
    }

    private void initAdapter() {
        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View headerView = inflater.inflate(R.layout.cart_list_header, cartListView, false);
        loadHeaderLayout(headerView);
        cartListView.addHeaderView(headerView);
        View footerView = inflater.inflate(R.layout.cart_list_footer, cartListView, false);
        loadFooterLayout(footerView);
        productAdapter = new CartProductAdapter(products, getActivity(), new CartHandler(this));
        cartListView.setAdapter(productAdapter);
    }

    @Override
    public void initHttpBack() {
        cartHttpBack = new HttpBack<Cart>(getBaseActivity()) {

            @Override
            public void onSuccess(Cart cart) {
                if (cart == null) {
                    emptyLayout.setVisibility(View.VISIBLE);
                    cartListView.setVisibility(View.GONE);
                    return;
                }
                addressConfirm(cart.getConsigneeAddress());//默认地址

                List<CartStore> cartStores = cart.getShopCartList();
                if (cartStores == null || cartStores.size() == 0) {
                    emptyLayout.setVisibility(View.VISIBLE);
                    cartListView.setVisibility(View.GONE);
                    mRightView.setVisibility(View.GONE);
                    return;
                }
                mRightView.setVisibility(View.VISIBLE);
                //单店铺
                mCartStore = cartStores.get(0);

                mTransCount = (mCartStore == null || mCartStore.getTransCostAmount() == null ||
                        mCartStore.getTransCostAmount() == 0 ? 0 : mCartStore.getTransCostAmount());
                mDeduceTransCostAmount = (mCartStore == null || mCartStore.getDeduceTransCostAmount() == null ||
                        mCartStore.getDeduceTransCostAmount() == 0 ? 0 : mCartStore.getDeduceTransCostAmount());
                if (mCartStore != null) {
                    mStoreName = mCartStore.getStoreName();
                    mBusinessHoursBegin = mCartStore.getBusinessHoursBegin();
                    mBusinessHoursEnd = mCartStore.getBusinessHoursEnd();
                    mStoreAddress = mCartStore.getAddressDetail();
                    mStorePickUpTimeNote = mCartStore.getPickUpTimeNote();
                }
                mStoreId = mCartStore.getStoreId();
                mStoreStatus = mCartStore.getStoreStatus();

                products.clear();
                products.addAll(mCartStore.getSaleProductList());
                setCartData();

                storeName.setText(String.valueOf(mStoreName));
                storeTransfer.setText((mTransCount == 0 || mDeduceTransCostAmount == 0)
                        ? String.format(getResources().getString(R.string.product_store_transfer_free))
                        : (String.format(getResources().getString(R.string.cart_delivery_method_send_tips),
                        MoneyUtils.toIntPrice(mDeduceTransCostAmount))));

                CartUtils.setCartInfo(mCartStore.getSaleProductList());
                firstCartCount = CartUtils.getCartCount();

                if (CommunityUtils.getIsTokeByMyself()) {//自提免配送费
                    onTokenSelect();
                } else {
                    mDeliveryTimeNote = mCartStore.getDeliveryTimeNote();
                    setTransferee(mTransCount, mDeduceTransCostAmount);
                }
                productAdapter.notifyDataSetChanged();
            }
        };
        purchaseHttpBack = new HttpBack<CartConfirm>(getBaseActivity()) {
            @Override
            public void onSuccess(CartConfirm cartConfirm) {
                if (cartConfirm == null) {
                    ToastUtils.show(getActivity(), R.string.http_exception);
                    return;
                }
                KeyboardUtils.close(getActivity());
                if (!CommunityUtils.isStoreOn(CommunityUtils.getCurrentStore())) {
                    String sendTime = CommunityUtils.notifyStoreBusinessSendTime(CommunityUtils.getCurrentStore());
                    if (TextUtils.isEmpty(sendTime)) {
                        return;
                    }
                    ToastUtils.show(getActivity(), isToke ? getString(R.string.store_notice_toke_show) :
                            String.format(getString(R.string.store_notice_show), sendTime));
                }
                Intent intent = new Intent(getActivity(), CalcCenterActivity.class);
                intent.setAction(ConfirmCartFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.PURCHASE_INFO, cartConfirm);
                intent.putExtra(Constants.BundleName.ADDRESS_ID, addressId);
                intent.putExtra(Constants.BundleName.PRODUCT_COUNT, getTotalCount());
                startActivity(intent);
            }
        };
        addressDetailHttpBack = new HttpBack<AddressBase>(getBaseActivity()) {
            @Override
            public void onSuccess(AddressBase addressDetail) {
                if (addressDetail == null) {
                    addressId = 0;
                    addressConfirm(null);
                    return;
                }
                if (CommunityUtils.getCurrentStoreId().intValue() != addressDetail.getCommunity().getStoreInfo().getStoreId().intValue()) {
                    addressConfirm(null);
                } else {
                    addressConfirm(addressDetail);
                }
            }

            @Override
            public void onFailure(String msg) {
                addressId = 0;
                addressConfirm(null);
            }

            @Override
            public void onTimeOut() {
                addressId = 0;
                addressConfirm(null);
            }
        };
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });
        mRightView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isEdit = !isEdit;
                mRightView.setText(getResources().getString(isEdit ? R.string.butten_finish : R.string.butten_edit));
                showEditView();
            }
        });

        moveProductToCollectBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });

        emptyBuyBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });
        allCheckLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                allCheck(!allCheckFlag);
            }
        });
    }

    private void loadHeaderLayout(View headerView) {
        mCartSectionView = (CartSectionView) headerView.findViewById(R.id.cart_sectionview);
        addressEmptyLayout = (RelativeLayout) headerView.findViewById(R.id.cart_address_empty_layout);
        addressDetailLayout = (RelativeLayout) headerView.findViewById(R.id.cart_address_detail_layout);
        addressConsigneeView = (TextView) headerView.findViewById(R.id.cart_address_detail_consignee_view);
        addressPhoneView = (TextView) headerView.findViewById(R.id.cart_address_detail_phone_view);
        addressDetailView = (TextView) headerView.findViewById(R.id.cart_address_detail_view);
        storeName = (TextView) headerView.findViewById(R.id.tv_store_name);
        storeTransfer = (TextView) headerView.findViewById(R.id.tv_store_transfer_desc);
        //自提
        mLlToke = (LinearLayout) headerView.findViewById(R.id.cart_toke_layout);
        mTvStoreName = (TextView) headerView.findViewById(R.id.store_name_view);
        mTvStoreTime = (TextView) headerView.findViewById(R.id.store_time_view);
        mTvStoreAddress = (TextView) headerView.findViewById(R.id.store_address_view);
        mLlToke.setVisibility(View.GONE);

        addressEmptyLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                firstCartCount = CartUtils.getCartCount();
                Intent intent = new Intent(getActivity(), AddressActivity.class);
                intent.setAction(AddressListFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.CART_SELECT_ADDRESS, true);
                startActivityForResult(intent, Constants.RequestCode.CART_ADDRESS_CODE);
            }
        });
        addressDetailLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                firstCartCount = CartUtils.getCartCount();
                Intent intent = new Intent(getActivity(), AddressActivity.class);
                intent.setAction(AddressListFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.CART_SELECT_ADDRESS, true);
                startActivityForResult(intent, Constants.RequestCode.CART_ADDRESS_CODE);
            }
        });
        mCartSectionView.setOnItemSelectListener(this);
    }

    private void loadFooterLayout(View footerView) {
        noteView = (ClearableEditText) footerView.findViewById(R.id.cart_note_view);
        noteView.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View view, boolean b) {
                if (!b) {
                    ClearableEditText noteView = ((ClearableEditText) view);
                    note = noteView.getText().toString();
                    if (note.length() > MAX_SIZE) {
                        note = note.substring(0, MAX_SIZE);
                    }
                }
            }
        });
    }

    /**
     * 判断地址信息使用情况
     */
    private void addressConfirm(AddressBase address) {
        if (address == null) {
            addressEmptyLayout.setVisibility(isToke ? View.GONE : View.VISIBLE);
            addressDetailLayout.setVisibility(View.GONE);
            isShowAddressDetail = false;
        } else {
            addressEmptyLayout.setVisibility(View.GONE);
            addressDetailLayout.setVisibility(isToke ? View.GONE : View.VISIBLE);
            addressId = address.getAddressId();
            addressConsigneeView.setText(address.getConsigneeName());
            addressPhoneView.setText(address.getPhoneNo());
            addressDetailView.setText(address.getAddress());
            isShowAddressDetail = true;
        }
    }

    private void setCartData() {
        totalAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(getTotalAmount())));
        Integer totalCount = getTotalCount();
        if (totalCount <= 0) {
            confirmBtn.setBackgroundResource(R.color.dividerColor);
            confirmBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
            confirmBtn.setOnClickListener(null);
            //删除操作
            delectProductBtn.setBackgroundResource(R.color.lightText);
            delectProductBtn.setOnClickListener(null);
        } else {
            confirmBtn.setBackgroundResource(R.color.cart_total_price);
            confirmBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
            confirmBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    firstCartCount = CartUtils.getCartCount();
                    confirmCart();
                }
            });
            //删除操作
            delectProductBtn.setBackgroundResource(R.color.colorPrimary);
            delectProductBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    List<Integer> deleteProductIds = getDeleteProductIds();
                    if (deleteProductIds == null || deleteProductIds.size() == 0) {
                        ToastUtils.showShort(getActivity(), "请选择商品");
                        return;
                    }
                    deleteComfirm(deleteProductIds);
                }
            });
        }
        confirmBtn.setText(String.format(getResources().getString(R.string.cart_confirm_btn),
                totalCount > 99 ? "99+" : totalCount));
    }

    @Override
    public void initRequest() {
        if (mCurrentStoreId == null || CartUtils.getCartInfo() == null
                || CartUtils.getCartInfo().size() == 0) {
            emptyLayout.setVisibility(View.VISIBLE);
            cartListView.setVisibility(View.GONE);
            cartBottomLayout.setVisibility(View.GONE);
            mRightView.setVisibility(View.GONE);
            return;
        }
        mRightView.setVisibility(View.VISIBLE);

        Map<String, Object> map = new HashMap<>();
        map.put("cartInfo", CartUtils.getCartInfo());
        map.put("storeId", mCurrentStoreId);
        map.put("communityId", CommunityUtils.getCurrentCommunityId());
        RetrofitUtils.getInstance(true).confirmCart(ParamUtils.getParam(map), cartHttpBack);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.CART_ADDRESS_CODE == requestCode) {
            if (resultCode == Activity.RESULT_OK) {
                saveAddress = (AddressBase) data.getSerializableExtra(Constants.BundleName.ADDRESS_INFO);
                addressConfirm(saveAddress);
            }
        }
    }

    private void allCheck(boolean allCheckFlag) {
        for (SaleProduct product : products) {
            if (product.getProductStatus() == Constants.ProductStatus.OFF_LINE
                    || product.getProductStatus() == Constants.ProductStatus.DELETE)
                continue;
            product.setIsCheck(allCheckFlag);
        }
        allCheckView.setBackgroundResource(allCheckFlag ? R.mipmap.checkbox_checked :
                R.mipmap.checkbox_unchecked);
        setCartData();
        productAdapter.notifyDataSetChanged();
        this.allCheckFlag = allCheckFlag;
    }

    private void confirmCart() {
        if (!validateCart()) {
            return;
        }
        if (Constants.StoreStatus.PAUSE.equals(mStoreStatus)) {
            ToastUtils.show(getActivity(), getResources().getString(R.string.store_status_pause));
            return;
        }
        cartInfo = getCartInfo();
        Map<String, Object> map = new HashMap<>();
        map.put("cartInfo", CartUtils.getCartInfo(cartInfo));
        if (isToke) {
            map.put("storeId", mStoreId);
        } else {
            map.put("addressId", addressId);
        }
        map.put("deliveryModeCode", isToke ? Constants.DeliveryType.PICKUP : Constants.DeliveryType.DELIVERY);
        map.put("longitude", mLongitude);
        map.put("latitude", mLatitude);
        RetrofitUtils.getInstance(true).settlementOrder(ParamUtils.getParam(map), purchaseHttpBack);
    }

    private boolean validateCart() {
        if (!isToke && (addressId == null || addressId == 0)) {
            ToastUtils.showShort(getActivity(), R.string.cart_address_empty);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(note)) {
            ToastUtils.showShort(getActivity(), R.string.cart_note_error_notify);
            return false;
        }
        return true;
    }

    private void toProCheck(int position) {
        SaleProduct product = products.get(position);
        if (CartUtils.checkedProductType(product) != Constants.CartProductStatus.NORMAL) {
            return;
        }
        product.setIsCheck(!product.isCheck());
        productAdapter.changeProductCheck(getViewByPosition(cartListView, position), position);
        setCartData();
        for (SaleProduct saleProduct : products) {
            if (!saleProduct.isCheck()) {
                allCheckView.setBackgroundResource(R.mipmap.checkbox_unchecked);
                allCheckFlag = false;
                return;
            }
        }
        allCheckView.setBackgroundResource(R.mipmap.checkbox_checked);
        allCheckFlag = true;
    }

    private void addCart(int position) {
        SaleProduct product = products.get(position);
        product.setCartNum(product.getCartNum() + 1);
        View view = getViewByPosition(cartListView, position);
        productAdapter.changeCartProduct(view, position);
        setCartData();
    }

    private void removeCart(final int position) {
        final SaleProduct product = products.get(position);
        int num = product.getCartNum() - 1;
        if (num == 0) {
            deleteProductCart(position);
        } else {
            product.setCartNum(num);
            CartUtils.removeCart(product);
            productAdapter.changeCartProduct(getViewByPosition(cartListView, position), position);
            setCartData();
        }
    }

    private void deleteProductCart(final int position) {
        final SaleProduct product = products.get(position);
        if (removeDialog != null && removeDialog.isShowing()) {
            return;
        }
        removeDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                product.setCartNum(0);
                CartUtils.removeCartProducts(product.getSaleProductId());

                products.remove(position);
                removeDialog.dismiss();
                setCartData();
                productAdapter.notifyDataSetChanged();
                checkedCartProductIsEmpty();
            }
        });
        removeDialog.setData(getResources().getString(R.string.remove_cart_notify),
                getResources().getString(R.string.remove_cart_confirm));
        removeDialog.show();
    }

    private Map<Integer, CartInfo> getCartInfo() {
        Map<Integer, CartInfo> map = null;
        for (SaleProduct product : products) {
            if (CartUtils.checkedProductType(product) != Constants.CartProductStatus.NORMAL
                    || !product.isCheck()) {
                continue;
            }
            if (map == null) {
                map = new HashMap<>();
            }
            map.put(product.getSaleProductId(), CartUtils.getCartInfoBean(product.getCartNum(), product.getActId()));
        }
        return map;
    }

    private List<Integer> getDeleteProductIds() {
        List<Integer> delProductIds = new ArrayList<>();
        for (SaleProduct saleProduct : products) {
            if (!saleProduct.isCheck()) {
                continue;
            }
            delProductIds.add(saleProduct.getSaleProductId());
        }
        return delProductIds;
    }

    private void deleteComfirm(final List<Integer> saleProductIds) {
        if (removeDialog != null && removeDialog.isShowing()) {
            return;
        }
        removeDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                deleteProducts(saleProductIds);
                removeDialog.dismiss();
            }
        });
        removeDialog.setData(getResources().getString(R.string.remove_cart_notify),
                getResources().getString(R.string.remove_cart_confirm));
        removeDialog.show();
    }

    private void deleteProducts(List<Integer> saleProductIds) {
        CartUtils.removeCartProducts(saleProductIds);
        removeProductList(saleProductIds);

        setCartData();
        productAdapter.notifyDataSetChanged();
        checkedCartProductIsEmpty();
    }

    private void checkedCartProductIsEmpty() {
        if (products.size() == 0) {
            emptyLayout.setVisibility(View.VISIBLE);
            cartBottomLayout.setVisibility(View.GONE);
            cartListView.setVisibility(View.GONE);
            mRightView.setVisibility(View.GONE);
        }
    }

    private void removeProductList(List<Integer> saleProductIds) {
        List<SaleProduct> deleteProducts = new ArrayList<>();
        for (Integer productId : saleProductIds) {
            for (SaleProduct saleProduct : products) {
                if (saleProduct.getSaleProductId().intValue() == productId.intValue()) {
                    deleteProducts.add(saleProduct);
                    continue;
                }
            }
        }
        products.removeAll(deleteProducts);
    }

    private Long getTotalAmount() {
        Long total = 0L;
        for (SaleProduct product : products) {
            if (product.isCheck()
                    && CartUtils.checkedProductType(product) == Constants.CartProductStatus.NORMAL) {
                total += product.getCartNum() * product.getOrderPrice();
            }
        }
        return total;
    }

    private Integer getTotalCount() {
        Integer total = 0;
        for (SaleProduct product : products) {
            if (product.isCheck()
                    && CartUtils.checkedProductType(product) == Constants.CartProductStatus.NORMAL) {
                total += product.getCartNum();
            }
        }
        return total;
    }

    private static class CartHandler extends Handler {
        private WeakReference<CartFragment> fragmentWeakReference;

        CartHandler(CartFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            CartFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.CART_PRO_CHECK_FLASH:
                    fragment.toProCheck((Integer) msg.obj);
                    break;
                case Constants.HandlerCode.CART_PRO_PLUS:
                    SaleProduct product = fragment.products.get((Integer) msg.obj);
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj);
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    fragment.addCart((Integer) msg.obj);
                    break;
                case Constants.HandlerCode.CART_PRO_MINUS:
                    fragment.removeCart((Integer) msg.obj);
                    break;
                case Constants.HandlerCode.CART_PRO_DELETE:
                    fragment.deleteProductCart((Integer) msg.obj);
                    break;
            }
        }
    }

    @Override
    public void onPause() {
        super.onPause();
        location.stopLoc();
    }

    private class LocationListener implements BDLocationListener {
        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                mLatitude = bdLocation.getLatitude();
                mLongitude = bdLocation.getLongitude();
                location.stopLoc();
            }
        }
    }

    public View getViewByPosition(ListView listView, int pos) {
        pos += listView.getHeaderViewsCount();
        final int firstListItemPosition = listView.getFirstVisiblePosition();
        final int lastListItemPosition = firstListItemPosition + listView.getChildCount() - 1;

        if (pos < firstListItemPosition || pos > lastListItemPosition) {
            return listView.getAdapter().getView(pos, null, listView);
        } else {
            final int childIndex = pos - firstListItemPosition;
            return listView.getChildAt(childIndex);
        }
    }

    private void setTransferee(long transCount, long deduceTransCostAmount) {
        transferView.setText(transCount == 0 || deduceTransCostAmount == 0
                ? String.format(getResources().getString(R.string.product_store_transfer_free))
                : (String.format(getResources().getString(R.string.cart_transfer_fee),
                MoneyUtils.toIntPrice(deduceTransCostAmount))));
    }

    @Override
    public void onTokenSelect() {
        transferView.setText(getResources().getString(R.string.cart_toke_free));
        storeName.setText(String.valueOf(mStoreName));

        addressDetailLayout.setVisibility(View.GONE);
        addressEmptyLayout.setVisibility(View.GONE);
        mLlToke.setVisibility(View.VISIBLE);
        mTvStoreName.setText(String.format(getResources().getString(R.string.cart_toke_store_name),
                String.valueOf(mStoreName)));
        mTvStoreTime.setText(String.format(getResources().getString(R.string.product_store_business),
                mBusinessHoursBegin, mBusinessHoursEnd));
        mTvStoreAddress.setText(String.format(getResources().getString(R.string.cart_toke_store_address),
                String.valueOf(mStoreAddress)));
        isToke = true;
    }

    @Override
    public void onSendSelect() {
        if (CommunityUtils.getIsTokeByMyself()) {
            return;
        }
        setTransferee(mTransCount, mDeduceTransCostAmount);
        storeName.setText(String.valueOf(mStoreName));

        addressDetailLayout.setVisibility(isShowAddressDetail ? View.VISIBLE : View.GONE);
        addressEmptyLayout.setVisibility(isShowAddressDetail ? View.GONE : View.VISIBLE);
        mLlToke.setVisibility(View.GONE);
        isToke = false;
    }
}
