package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Community;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/10/22 12:05
 * @描述 余额、积分明细
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class AccountListAdapter extends BaseAdapter {

    private List<Community> mDatas;
    private LayoutInflater inflater;
    private Context context;

    public AccountListAdapter(List<Community> datas, Context context) {
        mDatas = datas;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
    }

    @Override
    public int getCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : mDatas.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.account_list_item, viewGroup, false);
            holder.accountNote = (TextView) view.findViewById(R.id.account_note_tv);
            holder.accountNoteDate = (TextView) view.findViewById(R.id.account_note_date_tv);
            holder.accountNoteMoney = (TextView) view.findViewById(R.id.account_note_money_tv);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        holder.accountNote.setText(String.valueOf("注册有礼"));
        holder.accountNoteDate.setText(String.valueOf("2016-12-12 10:10:10"));
        holder.accountNoteMoney.setText(String.valueOf("+10.00"));
        return view;
    }

    private static class ViewHolder {
        TextView accountNote;
        TextView accountNoteDate;
        TextView accountNoteMoney;
    }
}
