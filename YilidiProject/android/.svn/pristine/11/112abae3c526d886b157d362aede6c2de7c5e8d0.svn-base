package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.DataStatisticsOrder;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 类型分类数据adapter
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class StatisticsOrderSettleAdapter extends BaseAdapter<StatisticsOrderSettleAdapter.ViewHolder> {

    private Context context;
    private List<DataStatisticsOrder> statisticsOrders;
    private LayoutInflater inflater;

    public StatisticsOrderSettleAdapter(Context context, List<DataStatisticsOrder> statisticsOrders) {
        this.context = context;
        this.statisticsOrders = statisticsOrders;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        DataStatisticsOrder statisticsOrder = statisticsOrders.get(position);
        holder.dateView.setTextColor(ContextCompat.getColor(context, R.color.secondaryText));
        holder.dateView.setText(statisticsOrder.getStatisticDate().substring(0, 10));
        holder.nameView.setTextColor(ContextCompat.getColor(context, R.color.secondaryText));
        holder.nameView.setText(statisticsOrder.getSaleOrderNo());
        holder.resultView.setTextColor(ContextCompat.getColor(context, R.color.colorRed));
        holder.resultView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(statisticsOrder.getSettleAmount())));
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_statistics, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return statisticsOrders == null ? 0 : statisticsOrders.size();
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
