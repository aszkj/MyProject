package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ClassBean;

import java.util.List;

/**
 * 类型分类数据adapter
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class ClassAdapter extends BaseAdapter<ClassAdapter.ViewHolder> {

    private Context context;
    private List<ClassBean> classList;
    private LayoutInflater inflater;

    public ClassAdapter(Context context, List<ClassBean> classList) {
        this.context = context;
        this.classList = classList;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        ClassBean classBean = classList.get(position);
        boolean isCheck = classBean.isCheck();
        holder.classNameLayout.setBackgroundResource(isCheck ? R.color.white : R.color.dividerColor);
        holder.classNameView.setText(classBean.getClassName());
        holder.classNameView.setBackgroundResource(isCheck ? R.drawable.yellow_bg : R.color.transparent);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_class, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return classList == null ? 0 : classList.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        RelativeLayout classNameLayout;
        TextView classNameView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.classNameLayout = (RelativeLayout) itemView.findViewById(R.id.ll_product_class_name);
            this.classNameView = (TextView) itemView.findViewById(R.id.tv_product_class_name);
        }
    }
}
