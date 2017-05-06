package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.MotionEvent;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.ClassActivity;
import com.yldbkd.www.buyer.android.activity.SearchActivity;
import com.yldbkd.www.buyer.android.adapter.BrandAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Brand;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/14 12:41
 * @描述 品牌
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class BrandFragment extends BaseFragment {
    private ClearableEditText mSearchTextView;
    private LinearLayout mLlsearch;
    private RecyclerView recycleView;
    private RelativeLayout mRlMoreBrand;

    private List<Brand> brands = new ArrayList<>();
    private BrandAdapter brandAdapter;
    private HttpBack<List<Brand>> brandHttpBack;
    private boolean isViewShown = false;
    private boolean isVisibleToUser;

    @Override
    public int setLayoutId() {
        return R.layout.brand_fragment;
    }

    @Override
    public void initView(View view) {
        mLlsearch = (LinearLayout) view.findViewById(R.id.ll_search_view);
        mSearchTextView = (ClearableEditText) view.findViewById(R.id.search_text_view);

        mRlMoreBrand = (RelativeLayout) view.findViewById(R.id.rl_more_brand);
        recycleView = (RecyclerView) view.findViewById(R.id.brand_recycle_view);

        GridLayoutManager gridLayoutManager = new GridLayoutManager(getActivity(), 4);
        gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recycleView.setLayoutManager(gridLayoutManager);
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            initRequest();
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    @Override
    public void initHttpBack() {
        brandHttpBack = new HttpBack<List<Brand>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Brand> brand) {
                brands.clear();
                if (brand == null || brand.size() == 0) {
                    return;
                }
                brands.addAll(brand);
                brandAdapter.notifyDataSetChanged();
            }
        };
    }

    @Override
    public void initData() {
        initAdapter();
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BrandType.HOT);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance().searchBrand(ParamUtils.getParam(map), brandHttpBack);
    }

    private void initAdapter() {
        brandAdapter = new BrandAdapter(brands, getActivity());
        recycleView.setAdapter(brandAdapter);
    }

    @Override
    public void initListener() {
        mLlsearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(SearchFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        mSearchTextView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_DOWN) {
                    Intent intent = new Intent(getActivity(), SearchActivity.class);
                    intent.setAction(SearchFragment.class.getSimpleName());
                    startActivity(intent);
                    return true;
                }
                return false;
            }
        });

        mRlMoreBrand.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {//品牌分类
                Intent intent = new Intent(getActivity(), ClassActivity.class);
                intent.setAction(BrandClassityFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        brandAdapter.setItemClickListener(new BrandAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Brand brand = brands.get(position);
                if (brand == null) {
                    return;
                }
                Intent intent = new Intent(getActivity(), ClassActivity.class);
                intent.setAction(BrandProductFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.BRAND_NAME, brand.getBrandName());
                intent.putExtra(Constants.BundleName.BRAND_CODE, brand.getBrandCode());
                startActivity(intent);
            }
        });
    }
}
