package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.RatingBar;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.viewCustomer.CircleImageView;

import java.util.List;

/**
 * 产品评论Adapter
 * <p/>
 * Created by lizhg on 17/02/13.
 */
public class ProductEvalutionAdapter extends BaseAdapter {

    private List<Evalution> evalutions;
    private LayoutInflater inflater;
    private Handler handler;
    private Context context;

    public ProductEvalutionAdapter(Context context, List<Evalution> evalutions, Handler handler) {
        this.evalutions = evalutions;
        this.context = context;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return evalutions == null ? 0 : evalutions.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : evalutions.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(final int position, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.evalution_show_item, viewGroup, false);
            holder.evaluationUserLogo = (CircleImageView) view.findViewById(R.id.evaluation_user_logo);
            holder.evaluationUserName = (TextView) view.findViewById(R.id.evaluation_user_name);
            holder.ratingView = (RatingBar) view.findViewById(R.id.rating_view);
            holder.evaluationTime = (TextView) view.findViewById(R.id.evaluation_time);
            holder.evaluationContent = (TextView) view.findViewById(R.id.evaluation_content);
            holder.imageRecycleView = (RecyclerView) view.findViewById(R.id.image_recycle_view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        Evalution evalution = evalutions.get(position);
        ImageLoaderUtils.load(holder.evaluationUserLogo, evalution.getUserImageUrl());
        holder.evaluationUserName.setText(evalution.getUserName());
        holder.evaluationTime.setText(evalution.getCreateTime().substring(0, evalution.getCreateTime().length() - 3));
        holder.evaluationContent.setText(evalution.getEvaluateContent());
        holder.ratingView.setRating(evalution.getSaleProductScore());
        //图片
        InnerRecycleView(holder, position);
        return view;
    }

    private static class ViewHolder {
        private CircleImageView evaluationUserLogo;
        private TextView evaluationUserName;
        private TextView evaluationTime;
        private TextView evaluationContent;
        private RatingBar ratingView;
        private RecyclerView imageRecycleView;
    }

    private void InnerRecycleView(ViewHolder holder, int position) {
        //指定recycleView高度
        Evalution evalution = evalutions.get(position);
        int count;
        if (evalution == null || evalution.getEvaluateImages() == null
                || evalution.getEvaluateImages().size() == 0) {
            count = 0;
        } else {//两行
            count = (evalution.getEvaluateImages().size() >= 10 ? 10 : evalution.getEvaluateImages().size());
        }

        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) holder.imageRecycleView.getLayoutParams();
        layoutParams.height = (int) (210f / 3 * DisplayUtils.density + 0.5) * (count % 5 > 0 ? count / 5 + 1 : count / 5);
        layoutParams.width = WindowManager.LayoutParams.MATCH_PARENT;
        holder.imageRecycleView.setLayoutParams(layoutParams);

        GridLayoutManager gridLayoutManager = new GridLayoutManager(context, 5);
        gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        holder.imageRecycleView.setLayoutManager(gridLayoutManager);
        ImageAdapter imageAdapter = new ImageAdapter(context, position, evalutions.get(position).getEvaluateImages(), handler, true);
        holder.imageRecycleView.setAdapter(imageAdapter);
    }
}
