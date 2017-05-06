package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.adapter.CollectAdapter;
import com.yldbkd.www.buyer.android.adapter.RecyclerBaseAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.DefaultItemDecoration;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static android.app.Activity.RESULT_OK;

/**
 * 收藏页面Fragment
 * <p/>
 * Created by linghuxj on 2017/2/21.
 */

public class CollectFragment extends BaseFragment {

    private static final Integer REFRESH_COMPLETE = 10086;

    private RelativeLayout backView;
    private ImgTxtButton editView;

    private RefreshLayout refreshLayout;
    private RecyclerView recyclerView;
    private CollectAdapter collectAdapter;
    private int pageNum = 0, totalPage = 1;
    private LinearLayout emptyLayout;
    private LinearLayout cartLayout;
    private RelativeLayout cartBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;

    private RelativeLayout bottomLayout;
    private LinearLayout allCheckLayout;
    private ImageView allCheckView;
    private Button delBtn;

    private HttpBack<Page<SaleProduct>> collectHttpBack;
    private HttpBack<BaseModel> delCollectHttpBack;

    private List<SaleProduct> saleProducts = new ArrayList<>();
    private boolean isEdit = false;
    private boolean isAll = false;
    private int index = -1;

    private CartHandler cartHandler = new CartHandler(this);
    private RefreshHandler refreshHandler = new RefreshHandler(this);
    private CommonDialog deleteDialog;
    private boolean isRefreshItem = true;

    @Override
    public int setLayoutId() {
        return R.layout.collect_fragment;
    }

    @Override
    public void initHttpBack() {
        collectHttpBack = new HttpBack<Page<SaleProduct>>() {
            @Override
            public void onSuccess(Page<SaleProduct> saleProductPage) {
                refreshHandler.sendEmptyMessage(REFRESH_COMPLETE);
                if (saleProductPage == null || saleProductPage.getTotalRecords() <= 0) {
                    isEmptyView(true);
                    return;
                }
                isEmptyView(false);
                pageNum = saleProductPage.getPageNum();
                totalPage = saleProductPage.getTotalPages();
                if (pageNum <= 1) {
                    saleProducts.clear();
                }
                List<SaleProduct> saleProductList = saleProductPage.getList();
                for (SaleProduct saleProduct : saleProductList) {
                    saleProduct.setIsCheck(false);
                    saleProducts.add(saleProduct);
                }
                updateAllCheck();
                CartUtils.calculateProductNum(saleProducts);
                collectAdapter.notifyDataSetChanged();
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(REFRESH_COMPLETE);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                refreshHandler.sendEmptyMessage(REFRESH_COMPLETE);
            }
        };
        delCollectHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                collectsRequest(1);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        ((TextView) view.findViewById(R.id.title_view)).setText(R.string.collect_title);
        editView = (ImgTxtButton) view.findViewById(R.id.right_view);
        editView.setVisibility(View.GONE);
        editView.setText(getString(isEdit ? R.string.collect_finish : R.string.collect_edit));

        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_collect);
        refreshLayout.init(getActivity());
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_collect);
        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_collect_empty);

        cartLayout = (LinearLayout) view.findViewById(R.id.cart_bottom);
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);
        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);

        bottomLayout = (RelativeLayout) view.findViewById(R.id.rl_collect_bottom);
        allCheckLayout = (LinearLayout) view.findViewById(R.id.ll_collect_all_check_layout);
        allCheckView = (ImageView) view.findViewById(R.id.iv_collect_all_checkbox);
        delBtn = (Button) view.findViewById(R.id.btn_collect_delete);

        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.getItemAnimator().setSupportsChangeAnimations(false);
        collectAdapter = new CollectAdapter(saleProducts, getActivity(), cartHandler);
        recyclerView.setAdapter(collectAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        editView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isEdit = !isEdit;
                editView.setText(getString(isEdit ? R.string.collect_finish : R.string.collect_edit));
                collectAdapter.setEdit(isEdit);
                bottomLayout.setVisibility(isEdit ? View.VISIBLE : View.GONE);
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                collectsRequest(1);
            }
        });
        refreshLayout.setLoadListener(new RefreshLayout.OnDataLoadListener() {
            @Override
            public void onDataLoad() {
                if (pageNum >= totalPage) {
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    refreshHandler.sendEmptyMessage(REFRESH_COMPLETE);
                    return;
                }
                collectsRequest(++pageNum);
            }
        });
        cartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent;
                if (UserUtils.isLogin()) {
                    intent = new Intent(getActivity(), PurchaseActivity.class);
                    intent.setAction(CartFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(getActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });
        allCheckLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isAll = !isAll;
                for (SaleProduct saleProduct : saleProducts) {
                    saleProduct.setIsCheck(isAll);
                }
                collectAdapter.notifyDataSetChanged();
                setAllCheck(isAll);
            }
        });
        delBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                List<Integer> delProductIds = new ArrayList<>();
                for (SaleProduct saleProduct : saleProducts) {
                    if (!saleProduct.isCheck()) {
                        continue;
                    }
                    delProductIds.add(saleProduct.getProductId());
                }
                deleteComfirm(delProductIds);
            }
        });
        collectAdapter.setItemLongClickListener(new RecyclerBaseAdapter.OnItemLongClickListener() {
            @Override
            public void onItemLongClick(View view, int position) {
                deleteComfirm(saleProducts.get(position).getProductId());
            }
        });
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        collectsRequest(1);
        flushCart();
    }

    private void flushCart() {
        Integer count = CartUtils.getCartCount();
        if (count > 0) {
            cartLayout.setVisibility(View.VISIBLE);
            cartNumBg.setVisibility(View.VISIBLE);
            cartNumView.setVisibility(View.VISIBLE);
            if (count > 99) {
                cartNumView.setText(getString(R.string.num_too_much));
                cartNumView.setTextSize(5f);
            } else {
                cartNumView.setText(String.valueOf(count));
                cartNumView.setTextSize(10f);
            }
        } else {
            cartLayout.setVisibility(View.INVISIBLE);
            cartNumBg.setVisibility(View.INVISIBLE);
            cartNumView.setVisibility(View.INVISIBLE);
        }
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.INVISIBLE : View.VISIBLE);
        editView.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
        if (isEmpty) {
            bottomLayout.setVisibility(View.GONE);
        }
    }

    private void updateAllCheck() {
        boolean isCheckAll = true;
        for (SaleProduct saleProduct : saleProducts) {
            isCheckAll = saleProduct.isCheck();
            if (!isCheckAll) {
                break;
            }
        }
        setAllCheck(isCheckAll);
    }

    private void setAllCheck(boolean isCheckAll) {
        isAll = isCheckAll;
        allCheckView.setBackgroundResource(isCheckAll ? R.mipmap.checkbox_checked :
                R.mipmap.checkbox_unchecked);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.LOGIN_CODE == requestCode && requestCode == RESULT_OK) {
            Intent intent = new Intent(getActivity(), PurchaseActivity.class);
            intent.setAction(CartFragment.class.getSimpleName());
            startActivity(intent);
        }
    }

    private void collectsRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).getCollects(ParamUtils.getParam(map), collectHttpBack);
    }

    private void deleteComfirm(final Integer delProductId) {
        if (deleteDialog != null && deleteDialog.isShowing()) {
            return;
        }
        deleteDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                List<Integer> delProductIds = new ArrayList<>();
                delProductIds.add(delProductId);
                deleteCollectRequest(delProductIds);
                deleteDialog.dismiss();
            }
        });
        deleteDialog.setData(getResources().getString(R.string.collect_delete_dialog_confirm),
                getResources().getString(R.string.dialog_confirm));
        deleteDialog.show();
    }

    private void deleteComfirm(final List<Integer> delProductIds) {
        if (deleteDialog != null && deleteDialog.isShowing()) {
            return;
        }
        deleteDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                deleteCollectRequest(delProductIds);
                deleteDialog.dismiss();
            }
        });
        deleteDialog.setData(getResources().getString(R.string.collect_delete_dialog_confirm),
                getResources().getString(R.string.dialog_confirm));
        deleteDialog.show();
    }

    private void deleteCollectRequest(List<Integer> delProductIds) {
        if (null == delProductIds || delProductIds.size() <= 0) {
            ToastUtils.show(getActivity(), R.string.collect_delete_empty);
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("productIds", listToString(delProductIds, ','));
        RetrofitUtils.getInstance(true).collectCancelSaleProduct(ParamUtils.getParam(map), delCollectHttpBack);
    }

    private static class CartHandler extends Handler {
        private WeakReference<CollectFragment> collectWeakReference;

        public CartHandler(CollectFragment fragment) {
            this.collectWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            CollectFragment fragment = collectWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.PRODUCT_PLUS) {
                fragment.index = msg.arg2;
            }
            SaleProduct product = fragment.saleProducts.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.CART_CHECK_FLASH:
                    product.setIsCheck(!product.isCheck());
                    fragment.updateAllCheck();
                    fragment.collectAdapter.notifyItemChanged(msg.arg2);
                    break;
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj);
                    break;
                case Constants.HandlerCode.CLEANPRODUCTFORVIP:
                    fragment.isRefreshItem = false;
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(fragment.saleProducts);
                    if (fragment.cartLayout.getVisibility() == View.INVISIBLE) {
                        fragment.cartLayout.setVisibility(View.VISIBLE);
                    }
                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    fragment.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(fragment.getBaseActivity(), startLocation, endLocation, fragment.cartNumBg,
                            fragment.cartNumView, null);
                    if (fragment.isRefreshItem) {
                        if (fragment.index > 0) {
                            fragment.collectAdapter.notifyItemChanged(fragment.index);
                            fragment.index = -1;
                        } else {
                            fragment.collectAdapter.notifyDataSetChanged();
                        }
                    } else {
                        fragment.collectAdapter.notifyDataSetChanged();
                    }
                    fragment.isRefreshItem = true;
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    product.setCartNum(product.getCartNum() - 1);
                    CartUtils.removeCart(product);
                    fragment.flushCart();
                    fragment.collectAdapter.notifyItemChanged(msg.arg2);
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    Intent intent = new Intent(fragment.getActivity(), ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                    fragment.startActivity(intent);
            }
        }
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<CollectFragment> collectWeakReference;

        public RefreshHandler(CollectFragment fragment) {
            this.collectWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            CollectFragment fragment = collectWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == REFRESH_COMPLETE) {
                fragment.refreshLayout.setRefreshing(false);
                fragment.refreshLayout.setLoadMore(false);
            }
        }
    }

    public String listToString(List list, char separator) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i));
            if (i < list.size() - 1) {
                sb.append(separator);
            }
        }
        return sb.toString();
    }
}
