package com.yldbkd.www.buyer.android.utils;

import android.graphics.drawable.BitmapDrawable;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.PopupWindow;


public class Pw {
	private PopupWindow mPopupWindow;

	public Pw(View view) {
		mPopupWindow = new PopupWindow(view, LayoutParams.MATCH_PARENT,
				400);
		mPopupWindow.setBackgroundDrawable(new BitmapDrawable());// 必须设置background才能消失
		/*
		 * mPopupWindow.setBackgroundDrawable(getResources().getDrawable(
		 * R.drawable.bg_frame));
		 */
		mPopupWindow.setOutsideTouchable(true);
		// 自定义动画
		//mPopupWindow.setAnimationStyle(R.style.PopupAnimation);
		mPopupWindow.update();
		mPopupWindow.setTouchable(true);
		mPopupWindow.setFocusable(true);
	}


	public Pw(View view,int height) {
		mPopupWindow = new PopupWindow(view, LayoutParams.MATCH_PARENT,
				height);
		mPopupWindow.setBackgroundDrawable(new BitmapDrawable());// 必须设置background才能消失
		/*
		 * mPopupWindow.setBackgroundDrawable(getResources().getDrawable(
		 * R.drawable.bg_frame));
		 */
		mPopupWindow.setOutsideTouchable(true);
		// 自定义动画
		//mPopupWindow.setAnimationStyle(R.style.PopupAnimation);
		mPopupWindow.update();
		mPopupWindow.setTouchable(true);
		mPopupWindow.setFocusable(true);
	}

	public void showPopupWindow(View view) {
		if (!mPopupWindow.isShowing()) {
			// mPopupWindow.showAsDropDown(view,0,0);
			mPopupWindow.showAtLocation(view, Gravity.BOTTOM, 0, 0);
		}
	}

	public void hidePopupWindow(){
		mPopupWindow.dismiss();
	}

}

