package com.yldbkd.www.seller.android.adapter;


import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;

/**
 * 类型分类数据adapter
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class StatisticsDateAdapter extends BaseAdapter<StatisticsDateAdapter.ViewHolder> {

    private Context context;
    private int[] strings;
    private LayoutInflater inflater;

    public StatisticsDateAdapter(Context context, int[] strings) {
        this.context = context;
        this.strings = strings;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        boolean isLast = position == getCount() - 1;
        holder.stringView.setTextColor(ContextCompat.getColor(context, isLast ? R.color.colorRed :
                R.color.primaryText));
        holder.stringView.setText(context.getString(strings[position]));
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_statistics_date, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return strings == null ? 0 : strings.length;
    }

    class ViewHolder extends BaseAdapter.Holder {

        TextView stringView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.stringView = (TextView) itemView.findViewById(R.id.tv_statistics_date);
        }
    }
}
