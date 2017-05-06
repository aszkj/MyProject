package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.MotionEvent;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;

import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.ProductActivity;
import com.yldbkd.www.seller.android.activity.SearchActivity;
import com.yldbkd.www.seller.android.adapter.BrandAdapter;
import com.yldbkd.www.seller.android.adapter.ClassificationSecondAdapter;
import com.yldbkd.www.seller.android.adapter.ClassificationTypeAdapter;
import com.yldbkd.www.seller.android.bean.Brand;
import com.yldbkd.www.seller.android.bean.ClassBean;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/1/3 16:06
 * @描述 分类和品牌
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ClassificationTabFragment extends BaseFragment {
    //title
    private View backView;
    private RadioGroup radioGroup;
    private RadioButton classRadioBtn;
    private RadioButton brandRadioBtn;

    private LinearLayout mLlsearch;
    private ClearableEditText mSearchTextView;
    private View brandLayout;
    private View classificationLayout;
    //分类
    private RecyclerView leftRecyclerView;
    private RecyclerView rightRecyclerView;
    private HttpBack<List<ClassBean>> classifyHttpBack;
    private HttpBack<List<ClassBean>> secondClassifyHttpBack;
    private ClassificationTypeAdapter classificationTypeAdapter;
    private ClassificationSecondAdapter classificationSecondAdapter;
    private List<ClassBean> leftClassifyList = new ArrayList<>();
    private List<ClassBean> rightClassifyList = new ArrayList<>();
    private ClassifyHandler mClassifyHandler = new ClassifyHandler(this);
    private int clickPosition = 0;
    //品牌
    private RelativeLayout mRlMoreBrand;
    private RecyclerView mBrandRecyclerView;
    private HttpBack<List<Brand>> brandHttpBack;
    private BrandAdapter brandAdapter;
    private List<Brand> mBrands = new ArrayList<>();

    @Override
    public int setLayoutId() {
        return R.layout.classification_tab_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.ll_back_radio_bar);
        radioGroup = (RadioGroup) view.findViewById(R.id.rg_class_product);
        classRadioBtn = (RadioButton) view.findViewById(R.id.rb_class_online);
        brandRadioBtn = (RadioButton) view.findViewById(R.id.rb_class_offline);
        classRadioBtn.setText(getResources().getString(R.string.classification_tab_title));
        brandRadioBtn.setText(getResources().getString(R.string.brand_tab_title));

        classificationLayout = view.findViewById(R.id.classification_layout);
        brandLayout = view.findViewById(R.id.brand_layout);
        mLlsearch = (LinearLayout) view.findViewById(R.id.ll_search_view);
        mSearchTextView = (ClearableEditText) view.findViewById(R.id.search_text_view);
        mSearchTextView.clearFocus();
        //分类
        leftRecyclerView = (RecyclerView) view.findViewById(R.id.classification_type_left_recycle_view);
        rightRecyclerView = (RecyclerView) view.findViewById(R.id.classification_type_right_recycle_view);
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        leftRecyclerView.setLayoutManager(linearLayoutManager);

        linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        rightRecyclerView.setLayoutManager(linearLayoutManager);
        //品牌
        mRlMoreBrand = (RelativeLayout) view.findViewById(R.id.rl_more_brand);
        mBrandRecyclerView = (RecyclerView) view.findViewById(R.id.hot_brand_recycle_view);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(getActivity(), 4);
        gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        mBrandRecyclerView.setLayoutManager(gridLayoutManager);

        //得到屏幕的参数
        DisplayUtils.getPixelDisplayMetricsII(getActivity());
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });

        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                switch (checkedId) {
                    case R.id.rb_class_online:
                        classificationLayout.setVisibility(View.VISIBLE);
                        brandLayout.setVisibility(View.GONE);
                        break;
                    case R.id.rb_class_offline:
                        classificationLayout.setVisibility(View.GONE);
                        brandLayout.setVisibility(View.VISIBLE);
                        break;
                }
            }
        });

        mLlsearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(ProductSearchRecordFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        mSearchTextView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_DOWN) {
                    Intent intent = new Intent(getActivity(), SearchActivity.class);
                    intent.setAction(ProductSearchRecordFragment.class.getSimpleName());
                    startActivity(intent);
                    return true;
                }
                return false;
            }
        });
        classificationTypeAdapter.setItemClickListener(new ClassificationTypeAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                if (position == clickPosition) {
                    return;
                }
                rightClassifyList.clear();
                classificationSecondAdapter.notifyDataSetChanged();
                clickPosition = position;
                classificationTypeAdapter.setSelectItem(clickPosition);
                classificationTypeAdapter.notifyDataSetChanged();
                initClassityRequest(leftClassifyList.get(clickPosition).getClassCode(), secondClassifyHttpBack);
            }
        });
        mRlMoreBrand.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {//品牌分类
                getBaseActivity().showFragment(BrandClassityFragment.class.getSimpleName(), null, true);
            }
        });
        brandAdapter.setItemClickListener(new BrandAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Brand brand = mBrands.get(position);
                if (brand == null) {
                    return;
                }
                Intent intent = new Intent(getActivity(), ProductActivity.class);
                intent.setAction(BrandProductFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.BRAND_NAME, brand.getBrandName());
                intent.putExtra(Constants.BundleName.BRAND_CODE, brand.getBrandCode());
                startActivity(intent);
            }
        });
    }

    @Override
    public void initRequest() {
        initClassityRequest(Constants.ClassType.TOP_CLASS, classifyHttpBack);
        initBrandRequest();
    }

    @Override
    public void initHttpBack() {
        classifyHttpBack = new HttpBack<List<ClassBean>>() {
            @Override
            public void onSuccess(List<ClassBean> classifications) {
                leftClassifyList.clear();
                if (classifications != null && classifications.size() > 0) {
                    leftClassifyList.addAll(classifications);
                    //选中的条目
                    classificationTypeAdapter.setSelectItem(0);
                    initClassityRequest(classifications.get(0).getClassCode(), secondClassifyHttpBack);
                }
                classificationTypeAdapter.notifyDataSetChanged();
            }
        };
        secondClassifyHttpBack = new HttpBack<List<ClassBean>>() {
            @Override
            public void onSuccess(List<ClassBean> classifications) {
                rightClassifyList.clear();
                if (classifications == null || classifications.size() == 0) {
                    return;
                }
                rightClassifyList.addAll(classifications);
                classificationSecondAdapter.notifyDataSetChanged();
            }
        };
        brandHttpBack = new HttpBack<List<Brand>>() {
            @Override
            public void onSuccess(List<Brand> brands) {
                mBrands.clear();
                if (brands == null || brands.size() == 0) {
                    return;
                }
                mBrands.addAll(brands);
                brandAdapter.notifyDataSetChanged();
            }
        };
    }

    private void initClassityRequest(String type, HttpBack<List<ClassBean>> httpback) {
        Map<String, Object> map = new HashMap<>();
        map.put("parentClassCode", type);
        RetrofitUtils.getInstance(true).productTypes(ParamUtils.getParam(map), httpback);
    }

    private void initBrandRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BrandType.HOT);
        RetrofitUtils.getInstance().searchBrand(ParamUtils.getParam(map), brandHttpBack);
    }

    @Override
    public void initAdapter() {
        //一级分类
        classificationTypeAdapter = new ClassificationTypeAdapter(leftClassifyList, getActivity());
        leftRecyclerView.setAdapter(classificationTypeAdapter);
        //子分类
        classificationSecondAdapter = new ClassificationSecondAdapter(rightClassifyList, getActivity(), mClassifyHandler);
        rightRecyclerView.setAdapter(classificationSecondAdapter);
        //品牌
        brandAdapter = new BrandAdapter(getActivity(), mBrands);
        mBrandRecyclerView.setAdapter(brandAdapter);
    }

    private static class ClassifyHandler extends Handler {
        WeakReference<ClassificationTabFragment> fragmentWeakReference;

        public ClassifyHandler(ClassificationTabFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final ClassificationTabFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.CLASSIFY_SECOND:
                    fragment.checkedClassityProduct(Integer.valueOf(msg.obj.toString()), 0);
                    break;
                case Constants.HandlerCode.CLASSIFY_THIRD:
                    fragment.checkedClassityProduct(msg.arg1, msg.arg2);
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    break;
            }
        }
    }

    private void checkedClassityProduct(int arg1, int arg2) {
        if (rightClassifyList.get(arg1) == null) {
            return;
        }
        Intent intent = new Intent(getActivity(), ProductActivity.class);
        intent.setAction(ClassProductFragment.class.getSimpleName());
        intent.putExtra(Constants.BundleName.CLASSITY_DATA, rightClassifyList.get(arg1));//二级数据
        intent.putExtra(Constants.BundleName.CLASSITY_CHECKED, arg2);//选中三级数据
        startActivity(intent);
    }
}
