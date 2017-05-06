package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.SectionIndexer;
import android.widget.TextView;

import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.Brand;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/29 10:14
 * @描述 品牌分类Adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class SortAdapter extends BaseAdapter implements SectionIndexer {
    private List<Brand> list = null;
    private Context mContext;

    public SortAdapter(Context context, List<Brand> list) {
        this.mContext = context;
        this.list = list;
    }

    public void updateListView(List<Brand> list) {
        this.list = list;
        notifyDataSetChanged();
    }

    public int getCount() {
        return this.list.size();
    }

    public Brand getItem(int position) {
        return list.get(position);
    }

    public long getItemId(int position) {
        return position;
    }

    public View getView(final int position, View view, ViewGroup arg2) {
        ViewHolder viewHolder = null;
        if (view == null) {
            viewHolder = new ViewHolder();
            view = LayoutInflater.from(mContext).inflate(R.layout.sort_item, null);
            viewHolder.brandNme = (TextView) view.findViewById(R.id.brand_name);
            viewHolder.pinyinFalg = (TextView) view.findViewById(R.id.pinyin_falg);
            viewHolder.brandImage = (ImageView) view.findViewById(R.id.brand_classity_image);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        Brand brand = list.get(position);
        //// 获取首字母的assii值
        int section = getSectionForPosition(position);
        //通过首字母的assii值来判断是否显示字母
        int positionForSelection = getPositionForSection(section);
        viewHolder.pinyinFalg.setOnClickListener(null);
        if (position == positionForSelection) {
            viewHolder.pinyinFalg.setVisibility(View.VISIBLE);
            viewHolder.pinyinFalg.setText(brand.getPinYinName());
        } else {
            viewHolder.pinyinFalg.setVisibility(View.GONE);
        }
        ImageLoaderUtils.load(viewHolder.brandImage, brand.getBrandLogoImageUrl(), R.mipmap.no_picture_rect);
        viewHolder.brandNme.setText(brand.getBrandName());
        return view;
    }

    final static class ViewHolder {
        TextView pinyinFalg;
        TextView brandNme;
        ImageView brandImage;
    }

    public int getSectionForPosition(int position) {
        return list.get(position).getPinYinName().charAt(0);
    }

    public int getPositionForSection(int section) {
        for (int i = 0; i < getCount(); i++) {
            String sortStr = list.get(i).getPinYinName();
            char firstChar = sortStr.toUpperCase().charAt(0);
            if (firstChar == section) {
                return i;
            }
        }
        return -1;
    }

    @Override
    public Object[] getSections() {
        return null;
    }
}
