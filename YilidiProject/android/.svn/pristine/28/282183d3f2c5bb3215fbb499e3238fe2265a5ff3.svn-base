package com.yldbkd.www.buyer.android.fragment;

import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;

/**
 * 购物车空页面
 * <p/>
 * Created by linghuxj on 15/11/23.
 */
public class CartEmptyFragment extends BaseFragment {

    private Button emptyBuyBtn;

    @Override
    public int setLayoutId() {
        return R.layout.cart_empty_fragment;
    }

    @Override
    public void initView(View view) {
        view.findViewById(R.id.back_view).setVisibility(View.GONE);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.cart_tab_name));
        emptyBuyBtn = (Button) view.findViewById(R.id.cart_empty_btn);
    }

    @Override
    public void initListener() {
        emptyBuyBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                MainActivity activity = (MainActivity) getActivity();
                activity.changeChecked(MainActivity.HOME);
            }
        });
    }
}
