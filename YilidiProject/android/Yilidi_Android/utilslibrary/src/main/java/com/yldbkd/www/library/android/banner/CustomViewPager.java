package com.yldbkd.www.library.android.banner;

import android.content.Context;
import android.graphics.PointF;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ViewConfiguration;

public class CustomViewPager extends ViewPager {

	/** 触摸时按下的点 **/
	PointF downP = new PointF();
	/** 触摸时当前的点 **/
	PointF curP = new PointF();
	private int touchSlop;

	public CustomViewPager(Context context, AttributeSet attrs) {
		super(context, attrs);
		initTouchSlop(context);
	}

	public CustomViewPager(Context context) {
		super(context);
		initTouchSlop(context);
	}

	private void initTouchSlop(Context context) {
		touchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
	}

	private boolean isHorizontalMove = false;

	@Override
	public boolean dispatchTouchEvent(MotionEvent ev) {
		float downX = 0;
		float downY = 0;
		switch (ev.getAction()) {
			case MotionEvent.ACTION_DOWN:
				//getParent().requestDisallowInterceptTouchEvent(true);
				break;
			case MotionEvent.ACTION_MOVE:
				if (Math.abs(ev.getX() - downX) > Math.abs(ev.getY() - downY)) {
					isHorizontalMove = true;
					getParent().requestDisallowInterceptTouchEvent(true);
				} else {
					if (!isHorizontalMove) {
						getParent().requestDisallowInterceptTouchEvent(false);
					}
				}
				downX = ev.getX();
				downY = ev.getY();
				break;
			case MotionEvent.ACTION_UP:
			case MotionEvent.ACTION_CANCEL:
				isHorizontalMove = false;
				getParent().requestDisallowInterceptTouchEvent(false);
				break;
		}

		return super.dispatchTouchEvent(ev);
	}

	@Override
	public boolean onInterceptTouchEvent(MotionEvent arg0) {
		// TODO Auto-generated method stub
		// 当拦截触摸事件到达此位置的时候，返回true，
		// 说明将onTouch拦截在此控件，进而执行此控件的onTouchEvent
		curP.x = arg0.getX();
		curP.y = arg0.getY();

		if (arg0.getAction() == MotionEvent.ACTION_DOWN) {
			// 记录按下时候的坐标
			// 切记不可用 downP = curP ，这样在改变curP的时候，downP也会改变
			downP.x = arg0.getX();
			downP.y = arg0.getY();

		} else if (arg0.getAction() == MotionEvent.ACTION_MOVE) {
			if (Math.abs(downP.x - curP.x) > touchSlop) {
				return true; // 只能横向
			} else {
				super.onInterceptTouchEvent(arg0);
			}
		}
		return super.onInterceptTouchEvent(arg0);
	}

	@Override
	public boolean onTouchEvent(MotionEvent arg0) {
		// ToastUtil.show("touch");
		// 当拦截触摸事件到达此位置的时候，返回true，
		// 说明将onTouch拦截在此控件，进而执行此控件的onTouchEvent
		curP.x = arg0.getX();
		curP.y = arg0.getY();

		if (arg0.getAction() == MotionEvent.ACTION_DOWN) {
			// 记录按下时候的坐标
			// 切记不可用 downP = curP ，这样在改变curP的时候，downP也会改变
			downP.x = arg0.getX();
			downP.y = arg0.getY();
			// 此句代码是为了通知他的父ViewPager现在进行的是本控件的操作，不要对我的操作进行干扰
			getParent().requestDisallowInterceptTouchEvent(true);
		}

		if (arg0.getAction() == MotionEvent.ACTION_MOVE) {
			// 此句代码是为了通知他的父ViewPager现在进行的是本控件的操作，不要对我的操作进行干扰
			getParent().requestDisallowInterceptTouchEvent(true);
		}

		if (arg0.getAction() == MotionEvent.ACTION_UP) {
			// 在up时判断是否按下和松手的坐标为一个点
			// 如果是一个点，将执行点击事件，这是我自己写的点击事件，而不是onclick
			if (downP.x == curP.x && downP.y == curP.y) {
				// onSingleTouch();
				// return true;
			}
		}
		return super.onTouchEvent(arg0);
	}

}