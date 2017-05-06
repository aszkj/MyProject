package com.yldbkd.www.buyer.android.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.text.method.ScrollingMovementMethod;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.buyer.android.bean.ImageUrlBean;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.ImageUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/8 9:43
 * @描述 图片预览
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class PreviewImageActivity extends BaseActivity {
    private View backView;
    private TextView mTitleView;
    private TextView mLeftTitleView;
    private ImgTxtButton mRightView;

    private int imageNumber;
    private boolean isDelete;
    private Evalution productEvalution;
    private ViewPager viewPager;
    private TextView evalutionContent;
    private CommonDialog removeImageDialog;
    private List<ImageUrlBean> mEvaluateImages;
    private ImageViewAdapter<ImageUrlBean> mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.preview_image_activity);
        productEvalution = (Evalution) getIntent().getSerializableExtra(Constants.BundleName.PRODUCT_EVALUTION);
        imageNumber = getIntent().getIntExtra(Constants.BundleName.IMAGE_NUMBER, 0);
        isDelete = getIntent().getBooleanExtra(Constants.BundleName.DELETE_IMAGE, false);
        mEvaluateImages = productEvalution.getEvaluateImages();
        initView();
        initData();
        initListener();
    }

    private void initView() {
        backView = findViewById(R.id.back_view);
        mTitleView = (TextView) findViewById(R.id.title_view);
        mLeftTitleView = (TextView) findViewById(R.id.left_title_view);
        mRightView = (ImgTxtButton) findViewById(R.id.right_view);
        viewPager = (ViewPager) findViewById(R.id.evalution_image_view_pager);
        evalutionContent = (TextView) findViewById(R.id.evalution_content);
    }

    private void initData() {
        evalutionContent.setMovementMethod(ScrollingMovementMethod.getInstance());
        changeTitlePage(imageNumber);
        evalutionContent.setText(productEvalution.getEvaluateContent());
        mRightView.setBackgroundResource(R.mipmap.delete_image);
        if (isDelete) {
            mTitleView.setVisibility(View.GONE);
            mLeftTitleView.setVisibility(View.VISIBLE);
            mRightView.setVisibility(View.VISIBLE);
        } else {
            mTitleView.setVisibility(View.VISIBLE);
            mLeftTitleView.setVisibility(View.GONE);
            mRightView.setVisibility(View.GONE);
        }
        initAdapter();
    }

    private void initAdapter() {
        mAdapter = new ImageViewAdapter<>(this, mEvaluateImages);
        viewPager.setAdapter(mAdapter);
        viewPager.setCurrentItem(imageNumber);
    }

    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                deleteImageRefreshData();
                onBackPressed();
            }
        });
        viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                imageNumber = position;
                changeTitlePage(position);
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
        mRightView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (removeImageDialog != null && removeImageDialog.isShowing()) {
                    return;
                }
                removeImageDialog = new CommonDialog(PreviewImageActivity.this, new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        removeImageDialog.dismiss();
                        mEvaluateImages.remove(imageNumber);
                        if (mEvaluateImages.size() == 0) {
                            deleteImageRefreshData();
                            finish();
                        } else {
                            mAdapter.destroyItem(viewPager, imageNumber, viewPager.findViewWithTag(viewPager.getCurrentItem()));
                            mAdapter.notifyDataSetChanged();
                            changeTitlePage(viewPager.getCurrentItem());
                        }
                    }
                });
                removeImageDialog.setData(getResources().getString(R.string.remove_image_dialog),
                        getResources().getString(R.string.remove_cart_confirm));
                removeImageDialog.show();
            }
        });
    }

    private void deleteImageRefreshData() {
        if (isDelete) {
            Intent intent = new Intent();
            intent.putExtra(Constants.BundleName.PRODUCT_EVALUTION, productEvalution);
            setResult(Constants.ResultCode.SUCCESS, intent);
        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
            deleteImageRefreshData();
        }
        return super.onKeyDown(keyCode, event);
    }

    private void changeTitlePage(int position) {
        mTitleView.setText(String.format(getResources().getString(R.string.product_detail_image_preview),
                position + 1, productEvalution.getEvaluateImages().size()));
        mLeftTitleView.setText(String.format(getResources().getString(R.string.product_detail_image_preview),
                position + 1, productEvalution.getEvaluateImages().size()));
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }

    public class ImageViewAdapter<T extends ImageUrlBean> extends PagerAdapter {

        private List<T> list;
        private Context context;
        private int count;

        public ImageViewAdapter(Context context, List<T> list) {
            this.context = context;
            this.list = list;
            if (list == null) {
                this.count = 0;
            } else {
                this.count = list.size();
            }
        }

        @Override
        public int getCount() {
            return list == null ? 0 : list.size();
        }

        @Override
        public boolean isViewFromObject(View view, Object o) {
            return view == o;
        }

        @Override
        public Object instantiateItem(ViewGroup container, final int position) {
            ImageUrlBean advert = list.get(position);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            String url = ImageUtils.getImageUrl(advert.getImageUrl());
            ImageView view = new ImageView(context);
            view.setImageDrawable(null);
            view.setAdjustViewBounds(true);
            view.setScaleType(ImageView.ScaleType.FIT_CENTER);
            view.setTag(position);
            view.setBackgroundColor(ContextCompat.getColor(context, R.color.black));
            ImageLoaderUtils.load(view, url, com.yldbkd.www.library.android.R.drawable.no_picture_rect);
            container.addView(view, layoutParams);
            return view;
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView((View) object);
        }

        @Override
        public int getItemPosition(Object object) {
            return POSITION_NONE;
        }

        @Override
        public void notifyDataSetChanged() {
            count = getCount();
            super.notifyDataSetChanged();
        }
    }
}
