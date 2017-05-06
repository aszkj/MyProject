package com.yldbkd.www.buyer.android.viewCustomer;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.LinearLayout;

import com.yldbkd.www.buyer.android.R;


public class SectionView extends LinearLayout implements OnClickListener {

	private View mViewLeft;
	private View mViewRight;
	Context context;

	public SectionView(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context =context;
		View.inflate(context, R.layout.section_view, this);
		initView();
		initListener();
	}

	public SectionView(Context context) {
		super(context);
	}
	

	private void initView() {
		mViewLeft = findViewById(R.id.sv_left);
		mViewRight = findViewById(R.id.sv_right);
		//默认左边处于选中状态
		mViewLeft.setSelected(true);
	}
	
	private void initListener() {
		mViewLeft.setOnClickListener(this);
		mViewRight.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.sv_left:
			mViewLeft.setSelected(true);
			mViewRight.setSelected(false);
			mListener.onLeftSelect();
			break;
		case R.id.sv_right:
			mViewRight.setSelected(true);
			mViewLeft.setSelected(false);
			mListener.onRightSelect();
			break;
		default:
			break;
		}
	}
	
	OnItemSelectListener mListener;
	public void setOnItemSelectListener(OnItemSelectListener listener){
		mListener = listener;
	}

	public interface OnItemSelectListener{
		void onLeftSelect();
		void onRightSelect();
	}
}
