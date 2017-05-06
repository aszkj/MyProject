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
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Classification;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.DisplayUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 11:14
 * @描述 多级分类Adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述 ${TODO}$
 */
public class ClassificationAdapter extends RecyclerView.Adapter<ClassificationAdapter.ViewHolder> {

    private Handler handler;
    private Context context;
    private List<Classification> classTypes;
    private LayoutInflater inflater;
    private int clickPosition = -1;

    public ClassificationAdapter(List<Classification> classTypes, Context context, Handler handler) {
        this.classTypes = classTypes;
        this.context = context;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.classification_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        List<Classification> subClassList = null;
        int typeCount = 0;
        Classification classification = classTypes.get(position);
        holder.mSecondName.setText(classification.getClassName());
        if (classification.getSubClassList() == null || classification.getSubClassList().size() == 0) {
            subClassList = null;
            typeCount = 0;
        } else {
            subClassList = classification.getSubClassList();
            typeCount = classification.getSubClassList().size() > 9 ? 9 : classification.getSubClassList().size();
        }
        //指定recycleView高度
        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) holder.secondRecycleView.getLayoutParams();
        layoutParams.height = (int) (340f / 3 * DisplayUtils.density + 0.5) * (typeCount % 3 > 0 ? typeCount / 3 + 1 : typeCount / 3);
        layoutParams.width = WindowManager.LayoutParams.MATCH_PARENT;
        holder.secondRecycleView.setLayoutParams(layoutParams);

        GridLayoutManager gridLayoutManager = new GridLayoutManager(context, 3);
        gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        holder.secondRecycleView.setLayoutManager(gridLayoutManager);
        ClassificationSecondAdapter secondAdapter = new ClassificationSecondAdapter(subClassList, context);
        holder.secondRecycleView.setAdapter(secondAdapter);

        holder.mSecondName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.CLASSIFY_SECOND, position)
                        .sendToTarget();
            }
        });
        secondAdapter.setItemClickListener(new ClassificationSecondAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int i) {
                handler.obtainMessage(Constants.HandlerCode.CLASSIFY_THIRD, position, i)
                        .sendToTarget();
            }
        });
    }

    @Override
    public int getItemCount() {
        return classTypes == null ? 0 : classTypes.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView mSecondName;
        private RecyclerView secondRecycleView;

        public ViewHolder(View itemView) {
            super(itemView);
            mSecondName = (TextView) itemView.findViewById(R.id.classification_second_name);
            secondRecycleView = (RecyclerView) itemView.findViewById(R.id.classification_seconnd_recycle_view);
        }
    }
}
