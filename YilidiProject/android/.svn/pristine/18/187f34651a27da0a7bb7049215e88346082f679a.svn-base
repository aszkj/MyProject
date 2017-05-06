package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.AccountInfo;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/29 10:14
 * @描述 账本Adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class AccountAdapter extends BaseAdapter {

    private Context context;
    private List<AccountInfo> accountInfo;
    private LayoutInflater inflater;

    public AccountAdapter(List<AccountInfo> accountInfo, Context context) {
        this.context = context;
        this.accountInfo = accountInfo;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return accountInfo == null ? 0 : accountInfo.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : accountInfo.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int position, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.account_item, viewGroup, false);
            holder.accountBalanceTitle = (TextView) view.findViewById(R.id.account_balance_text);
            holder.accountBalance = (TextView) view.findViewById(R.id.account_balance_tv);
            holder.dividerView = (View) view.findViewById(R.id.divider_view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }

        setData(holder, position);
        return view;
    }

    private void setData(final ViewHolder holder, final int position) {
        AccountInfo accountInfo = this.accountInfo.get(position);
        holder.accountBalanceTitle.setText(accountInfo.getAccountName());
        holder.accountBalance.setText(String.valueOf(accountInfo.getAccountNumType() != 1 ? accountInfo.getAccountNum()
                : MoneyUtils.toPrice(accountInfo.getAccountNum())));
        holder.dividerView.setVisibility(position % 2 == 0 ? View.VISIBLE : View.GONE);
    }

    private static class ViewHolder {
        TextView accountBalanceTitle;
        TextView accountBalance;
        View dividerView;
    }
}
