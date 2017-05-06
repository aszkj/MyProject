package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RatingBar;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/8 10:43
 * @描述 显示商品评价内容
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class EvalutionShowAdapter extends RecyclerView.Adapter<EvalutionShowAdapter.ViewHolder> {
    private List<Evalution> evalutions;
    private Context context;
    private LayoutInflater inflater;

    public EvalutionShowAdapter(Context context, List<Evalution> evalutions) {
        this.context = context;
        this.evalutions = evalutions;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.evalution_show_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        Evalution evalution = evalutions.get(0);
        ImageLoaderUtils.load(holder.evaluationUserLogo, evalution.getUserImageUrl());
        holder.evaluationUserName.setText(evalution.getUserName());
        holder.evaluationTime.setText(evalution.getCreateTime());
        holder.evaluationContent.setText(evalution.getEvaluateContent());
        holder.ratingView.setRating(evalution.getSaleProductScore());
    }

    @Override
    public int getItemCount() {
        return evalutions == null ? 10 : 10;
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        private ImageView evaluationUserLogo;
        private TextView evaluationUserName;
        private TextView evaluationTime;
        private TextView evaluationContent;
        private RatingBar ratingView;

        public ViewHolder(View itemView) {
            super(itemView);
            evaluationUserLogo = (ImageView) itemView.findViewById(R.id.evaluation_user_logo);
            evaluationUserName = (TextView) itemView.findViewById(R.id.evaluation_user_name);
            ratingView = (RatingBar) itemView.findViewById(R.id.rating_view);
            evaluationTime = (TextView) itemView.findViewById(R.id.evaluation_time);
            evaluationContent = (TextView) itemView.findViewById(R.id.evaluation_content);
        }
    }

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    private OnItemClickListener itemClickListener;

    public void setItemClickListener(OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }
}
