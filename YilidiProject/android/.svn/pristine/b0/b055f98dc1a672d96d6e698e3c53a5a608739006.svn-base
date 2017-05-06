package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.DataStatisticsVip;
import com.yldbkd.www.seller.android.utils.Constants;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

/**
 * 类型分类数据adapter
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class StatisticsVipAdapter extends BaseAdapter<StatisticsVipAdapter.ViewHolder> {

    private Context context;
    private List<DataStatisticsVip> dataStatisticsVips;
    private LayoutInflater inflater;

    public StatisticsVipAdapter(Context context, List<DataStatisticsVip> dataStatisticsVips) {
        this.context = context;
        this.dataStatisticsVips = dataStatisticsVips;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        DataStatisticsVip statisticsVip = dataStatisticsVips.get(position);
        holder.dateView.setTextColor(ContextCompat.getColor(context, R.color.secondaryText));
        holder.dateView.setText(statisticsVip.getStatisticDate().substring(0, 10));
        holder.nameView.setTextColor(ContextCompat.getColor(context, R.color.secondaryText));
        holder.nameView.setText(String.valueOf(statisticsVip.getRegistCount()));
        holder.resultView.setTextColor(ContextCompat.getColor(context, R.color.colorRed));
        holder.resultView.setText(String.valueOf(statisticsVip.getVipUserCount()));
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_statistics, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return dataStatisticsVips == null ? 0 : dataStatisticsVips.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        TextView dateView;
        TextView nameView;
        TextView resultView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.dateView = (TextView) itemView.findViewById(R.id.tv_statistics_date);
            this.nameView = (TextView) itemView.findViewById(R.id.tv_statistics_name);
            this.resultView = (TextView) itemView.findViewById(R.id.tv_statistics_result);
        }
    }
}
