package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RatingBar;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 产品评论Adapter
 * <p/>
 * Created by lizhg on 17/02/13.
 */
public class EvalutionEditAdapter extends BaseAdapter {

    private List<Evalution> evalutions;
    private List<SaleProduct> saleProducts;
    private LayoutInflater inflater;
    private Handler handler;
    private Context context;
    private ImageAdapter imageAdapter;

    public EvalutionEditAdapter(Context context, List<SaleProduct> saleProducts, Handler handler) {
        this.saleProducts = saleProducts;
        this.context = context;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return saleProducts == null ? 0 : saleProducts.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : saleProducts.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(final int position, View view, ViewGroup viewGroup) {
        final ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.evalution_edit_item, viewGroup, false);
            holder.productImage = (ImageView) view.findViewById(R.id.evalution_product_image);
            holder.ratingView = (RatingBar) view.findViewById(R.id.rating_view);
            holder.evalutionContent = (EditText) view.findViewById(R.id.evalution_content);
            holder.imageRecycleView = (RecyclerView) view.findViewById(R.id.image_recycle_view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        SaleProduct saleProduct = saleProducts.get(position);
        ImageLoaderUtils.load(holder.productImage, saleProduct.getSaleProductImageUrl());

        holder.ratingView.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener() {
            @Override
            public void onRatingChanged(RatingBar ratingBar, float rating, boolean fromUser) {
                handler.obtainMessage(Constants.HandlerCode.EVALUTIONSTART, (int) rating, position)
                        .sendToTarget();
            }
        });
        final ViewHolder holder1 = holder;
        holder.evalutionContent.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (!hasFocus) {
                    handler.obtainMessage(Constants.HandlerCode.EVALUTIONCONTENT, position, 1, holder1.evalutionContent.getText())
                            .sendToTarget();
                }
            }
        });
        //记录最后一次评价内容
        holder.evalutionContent.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                handler.obtainMessage(Constants.HandlerCode.EVALUTIONLASTCONTENT, position, 1, holder1.evalutionContent.getText())
                        .sendToTarget();
            }
        });
        //item重用数据显示
        Evalution evalution = evalutions.get(position);
        holder.ratingView.setRating(evalution.getSaleProductScore());
        holder.evalutionContent.setText(evalution.getEvaluateContent());
        //图片
        InnerRecycleView(holder, position);
        return view;
    }

    public void setEvalutiondata(List<Evalution> evalutiondata) {
        evalutions = evalutiondata;
    }

    private static class ViewHolder {
        private ImageView productImage;
        private EditText evalutionContent;
        private RatingBar ratingView;
        private RecyclerView imageRecycleView;
    }

    private void InnerRecycleView(ViewHolder holder, int position) {
        //指定recycleView高度
        Evalution evalution = evalutions.get(position);
        int count;
        if (evalution == null || evalution.getEvaluateImages() == null
                || evalution.getEvaluateImages().size() == 0) {
            count = 1;
        } else {//两行
            count = (evalution.getEvaluateImages().size() >= 10 ? 10 : evalution.getEvaluateImages().size() + 1);
        }

        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) holder.imageRecycleView.getLayoutParams();
        layoutParams.height = (int) (210f / 3 * DisplayUtils.density + 0.5) * (count % 5 > 0 ? count / 5 + 1 : count / 5);
        layoutParams.width = WindowManager.LayoutParams.MATCH_PARENT;
        holder.imageRecycleView.setLayoutParams(layoutParams);

        GridLayoutManager gridLayoutManager = new GridLayoutManager(context, 5);
        gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        holder.imageRecycleView.setLayoutManager(gridLayoutManager);
        imageAdapter = new ImageAdapter(context, position, evalutions.get(position).getEvaluateImages(), handler, false);
        holder.imageRecycleView.setAdapter(imageAdapter);
    }

    public void refreshData() {
        imageAdapter.notifyDataSetChanged();
    }
}
