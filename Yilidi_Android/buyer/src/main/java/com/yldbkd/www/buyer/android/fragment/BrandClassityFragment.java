package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.SortAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Brand;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.OperationToSqlite;
import com.yldbkd.www.buyer.android.utils.PinYinComparator;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.SideBar;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/14 12:42
 * @描述 品牌分类
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class BrandClassityFragment extends BaseFragment {
    private View backView;
    private TextView titleView;
    private ListView sortListView;
    private SideBar sideBar;
    private TextView dialog;
    private SortAdapter mSortAdapter;
    private HttpBack<List<Brand>> brandHttpBack;
    private List<Brand> brands = new ArrayList<>();
    //根据拼音来排列ListView里面的数据类
    private PinYinComparator pinyinComparator;
    private BuyerApp app;

    @Override
    public int setLayoutId() {
        return R.layout.brand_classity_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        sideBar = (SideBar) view.findViewById(R.id.sidrbar);
        dialog = (TextView) view.findViewById(R.id.dialog);
        sortListView = (ListView) view.findViewById(R.id.brand_listview);
    }

    @Override
    public void initData() {
        app = BuyerApp.getInstance();
        sideBar.setVisibility(View.GONE);

        titleView.setText(getResources().getString(R.string.brand_classify_title));
        // sideBar.setTextView(dialog);//设置相应的字体背景样式
        pinyinComparator = new PinYinComparator();
        initAdapter();
        getDataFromLocal();
    }

    private void initAdapter() {
        mSortAdapter = new SortAdapter(getActivity(), brands);
        sortListView.setAdapter(mSortAdapter);
    }

    @Override
    public void initHttpBack() {
        brandHttpBack = new HttpBack<List<Brand>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Brand> allBrand) {
                brands.clear();
                if (allBrand == null || allBrand.size() == 0) {
                    return;
                }
                //对应品牌设置拼音
                brands.addAll(pinyinComparator.getResourceData(allBrand));
                // 根据a-z进行排序源数据
                Collections.sort(brands, pinyinComparator);
                mSortAdapter.notifyDataSetChanged();
                sideBar.setVisibility(View.VISIBLE);
                //排序完以后子线程本地保存数据
                //saveBrandToSqlite(brands);
                saveBrandToMemory(brands);
            }
        };
    }

    private void saveBrandToMemory(List<Brand> brands) {
        if (app.brandsList == null || app.brandsList.size() == 0) {
            app.brandsList.addAll(brands);
        }
    }

    private void saveBrandToSqlite(final List<Brand> datas) {
        new Thread() {
            @Override
            public void run() {
                OperationToSqlite.saveBrandData(datas);
            }
        }.start();
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BrandType.ALL);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance().searchBrand(ParamUtils.getParam(map), brandHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });

        sortListView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView view, int scrollState) {
            }

            @Override
            public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount,
                                 int totalItemCount) {
                //字母连续断层使不能置顶，例如D（空）F使D到F阶段不存在置顶
                int section;
                try {
                    section = mSortAdapter.getSectionForPosition(firstVisibleItem);
                } catch (Exception e) {
                    return;
                }
                int nextSecPosition = mSortAdapter.getPositionForSection(section + 1);
                //解决断层置顶
                for (int i = 1; i < 30; i++) {
                    //26个英文字母充分循环
                    if (nextSecPosition == -1) {
                        //继续累加
                        int data = section + 1 + i;
                        nextSecPosition = mSortAdapter.getPositionForSection(data);
                    } else {
                        break;
                    }
                }
                //监听滚动,右侧对应进行变化
                int pos = sortListView.getFirstVisiblePosition();
                if (brands == null || brands.size() == 0) {
                    return;
                }
                String chooseBrandPinYin = brands.get(pos).getPinYinName().charAt(0) + "";
                Pattern compile = Pattern.compile("[0-9]*");
                Matcher matcher = compile.matcher(chooseBrandPinYin);
                if (matcher.matches()) {
                    sideBar.setChoose("#");
                } else {
                    sideBar.setChoose(chooseBrandPinYin);
                }
            }
        });
        //设置右侧触摸监听
        sideBar.setOnTouchingLetterChangedListener(new SideBar.OnTouchingLetterChangedListener() {
            @Override
            public void onTouchingLetterChanged(String s) {
                //该字母首次出现的位置
                int position = mSortAdapter.getPositionForSection(s.charAt(0));
                if (position != -1) {
                    sortListView.setSelection(position);
                }
            }
        });
        sortListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {
                Brand brand = mSortAdapter.getItem(position);
                if (brand == null) {
                    return;
                }
                Bundle bundle = new Bundle();
                bundle.putString(Constants.BundleName.BRAND_NAME, brand.getBrandName());
                bundle.putString(Constants.BundleName.BRAND_CODE, brand.getBrandCode());
                getBaseActivity().showFragment(BrandProductFragment.class.getSimpleName(), bundle, true);
            }
        });
    }

    public void getDataFromLocal() {
        if (app.brandsList == null || app.brandsList.size() == 0) {
            initRequest();
        } else {
            brands.clear();
            brands.addAll(app.brandsList);
            mSortAdapter.notifyDataSetChanged();
            sideBar.setVisibility(View.VISIBLE);
        }
    /*    if (OperationToSqlite.isClean()) {
            OperationToSqlite.clean();
            initRequest();
        } else {
            brands.addAll(OperationToSqlite.queryBrandData());
            mSortAdapter.notifyDataSetChanged();
        }*/
    }
}
