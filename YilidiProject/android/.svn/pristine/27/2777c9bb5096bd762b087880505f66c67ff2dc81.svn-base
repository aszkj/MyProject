package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.MotionEvent;
import android.view.View;
import android.widget.LinearLayout;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.ClassActivity;
import com.yldbkd.www.buyer.android.activity.SearchActivity;
import com.yldbkd.www.buyer.android.adapter.ClassificationAdapter;
import com.yldbkd.www.buyer.android.adapter.ClassificationTypeAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Classification;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/14 12:40
 * @描述 多级分类
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ClassificationFragment extends BaseFragment {
    private ClearableEditText mSearchTextView;
    private LinearLayout mLlsearch;
    private RecyclerView classificationTypeRecycleView;
    private RecyclerView classificationRecycleView;
    //类目列表
    private ClassificationTypeAdapter classificationTypeAdapter;
    private ClassificationAdapter classificationAdapter;

    private List<Classification> classifyTypeList = new ArrayList<>();
    private List<Classification> classifyList = new ArrayList<>();
    private HttpBack<List<Classification>> classifyHttpBack;
    private HttpBack<List<Classification>> secondClassifyHttpBack;

    private String mClassCode = "";
    private int clickPosition = 0;
    private ClassifyHandler mClassifyHandler = new ClassifyHandler(this);
    private boolean isViewShown = false;
    private boolean isVisibleToUser = false;
    private boolean isFirst = true;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        //获取类型code
        mClassCode = bundle.getString(Constants.BundleName.CLASS_CODE, "");
    }

    @Override
    public int setLayoutId() {
        return R.layout.classification_fragment;
    }

    @Override
    public void initView(View view) {
        mLlsearch = (LinearLayout) view.findViewById(R.id.ll_search_view);
        mSearchTextView = (ClearableEditText) view.findViewById(R.id.search_text_view);
        mSearchTextView.clearFocus();

        classificationTypeRecycleView = (RecyclerView) view.findViewById(R.id.classification_type_recycle_view);
        classificationRecycleView = (RecyclerView) view.findViewById(R.id.classification_recycle_view);

        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        classificationTypeRecycleView.setLayoutManager(linearLayoutManager);

        linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        classificationRecycleView.setLayoutManager(linearLayoutManager);
        //        //分割线
        //        classificationTypeRecycleView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            initRequest(Constants.ClassType.TOP_CLASS, classifyHttpBack);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        if (isFirst) {
            setUserVisibleHint(isVisibleToUser);
            isFirst = false;
        }
    }

    private void initRequest(String type, HttpBack<List<Classification>> httpBack) {
        Map<String, Object> map = new HashMap<>();
        map.put("parentClassCode", type);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).getProductType(ParamUtils.getParam(map), httpBack);
    }

    @Override
    public void initData() {
        initAdapter();
    }

    @Override
    public void initListener() {
        classificationTypeAdapter.setItemClickListener(new ClassificationTypeAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                if (position == clickPosition) {
                    return;
                }
                classifyList.clear();
                classificationAdapter.notifyDataSetChanged();

                clickPosition = position;
                classificationTypeAdapter.setSelectItem(clickPosition);
                initRequest(classifyTypeList.get(clickPosition).getClassCode(), secondClassifyHttpBack);
                classificationTypeAdapter.notifyDataSetChanged();
            }
        });
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
    }

    @Override
    public void initHttpBack() {
        classifyHttpBack = new HttpBack<List<Classification>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Classification> classifications) {
                classifyTypeList.clear();
                if (classifications != null && classifications.size() > 0) {
                    classifyTypeList.addAll(classifications);
                    if (TextUtils.isEmpty(mClassCode)) {
                        //默认选择第一大分类
                        chooseDefaultType(classifications);
                    } else {
                        checkedType();
                    }
                    //传入了mClassCode，但是mClassCode不在我们默认列表中，默认选中第一个
                    if (clickPosition >= classifyTypeList.size()) {
                        chooseDefaultType(classifyTypeList);
                    }
                    //选中的条目
                    classificationTypeAdapter.setSelectItem(clickPosition);
                    initRequest(classifications.get(clickPosition).getClassCode(), secondClassifyHttpBack);
                }
                classificationTypeAdapter.notifyDataSetChanged();
            }
        };
        secondClassifyHttpBack = new HttpBack<List<Classification>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Classification> classifications) {
                classifyList.clear();
                if (classifications == null || classifications.size() == 0) {
                    return;
                }
                classifyList.addAll(classifications);
                classificationAdapter.notifyDataSetChanged();
            }
        };
    }

    private void initAdapter() {
        classificationTypeAdapter = new ClassificationTypeAdapter(classifyTypeList, getActivity());
        classificationTypeRecycleView.setAdapter(classificationTypeAdapter);

        classificationAdapter = new ClassificationAdapter(classifyList, getActivity(), mClassifyHandler);
        classificationRecycleView.setAdapter(classificationAdapter);
    }

    private void checkedType() {
        for (Classification classInfo : classifyTypeList) {
            if (mClassCode.equals(classInfo.getClassCode())) {
                break;
            }
            clickPosition++;
        }
    }

    private void chooseDefaultType(List<Classification> classifications) {
        clickPosition = 0;
        mClassCode = classifications.get(0).getClassCode();
    }

    private static class ClassifyHandler extends Handler {
        WeakReference<ClassificationFragment> fragmentWeakReference;

        public ClassifyHandler(ClassificationFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final ClassificationFragment fragment = fragmentWeakReference.get();
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
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    break;
            }
        }
    }

    private void checkedClassityProduct(int arg1, int arg2) {
        if (classifyList.get(arg1) == null) {
            return;
        }
        Intent intent = new Intent(getActivity(), ClassActivity.class);//传递二级和三级的bean过去
        intent.setAction(ClassificationProductTabFragment.class.getSimpleName());
        intent.putExtra(Constants.BundleName.CLASSITY_DATA, classifyList.get(arg1));//二级数据
        intent.putExtra(Constants.BundleName.CLASSITY_CHECKED, arg2);//选中数据
        startActivity(intent);
    }
}
