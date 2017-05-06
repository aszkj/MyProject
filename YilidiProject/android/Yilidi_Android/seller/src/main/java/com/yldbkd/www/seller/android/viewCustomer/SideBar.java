package com.yldbkd.www.seller.android.viewCustomer;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.seller.android.R;

import java.util.Arrays;

/**
 * @author Administrator
 * @version $Rev$
 * @time 2016/12/12 16:03
 * @des ${TODO}
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes ${TODO}
 */
public class SideBar extends View {
    //触摸事件
    private OnTouchingLetterChangedListener onTouchingLetterChangedListener;
    //26个字母
    public static String[] b = {"A", "B", "C", "D", "E", "F", "G", "H", "I",
            "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
            "W", "X", "Y", "Z", "#"};
    private int choose = 0;// 默认选中第一个
    private Paint paint = new Paint();
    private Paint rectPaint = new Paint();
    private TextView mTextDialog;

    public void setTextView(TextView mTextDialog) {
        this.mTextDialog = mTextDialog;
    }

    public void setChoose(String str) {
        int index = Arrays.asList(b).indexOf(str);
        if (index == choose) {
            return;
        }
        choose = index;
        invalidate();
    }


    public SideBar(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public SideBar(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public SideBar(Context context) {
        super(context);
    }

    /**
     * 重绘界面
     */
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        //获取焦点改变背景颜色
        int height = getHeight();// 获取对应高度
        int width = getWidth(); //  获取对应宽度
        int singleHeight = height / b.length;// 获取每一个字母的高度

        for (int i = 0; i < b.length; i++) {
            //设置每一个字母的样式
            paint.setColor(Color.parseColor("#A9A9A9"));
            // paint.setColor(Color.WHITE);
            paint.setTypeface(Typeface.DEFAULT_BOLD);
            paint.setAntiAlias(true);
            paint.setTextSize(30);
            // x坐标等于中间-字符串宽度一半
            float xPos = width / 2 - paint.measureText(b[i]) / 2;
            //高度增加递增
            float yPos = singleHeight * i + singleHeight;
            //选中状态
            if (i == choose) {
                paint.setColor(Color.parseColor("#FFFFFF"));
                paint.setFakeBoldText(true);
                rectPaint.setColor(Color.parseColor("#298CCF"));//选中的背景圆圈
                canvas.drawCircle(width / 2, singleHeight * i + singleHeight * 7 / 9, DisplayUtils.density * 10, rectPaint);
            }
            canvas.drawText(b[i], xPos, yPos, paint);
            paint.reset();// 重置画笔
            rectPaint.reset();// 重置画笔
        }
    }


    /**
     * 点击的时候的状态
     */
    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        final int action = event.getAction();
        final float y = event.getY();// 点击Y坐标
        final int oldChoose = choose;
        final OnTouchingLetterChangedListener listener = onTouchingLetterChangedListener;
        final int c = (int) (y / getHeight() * b.length);// 点击y坐标所占总高度的比例*b数组的长度就等于点击b中的个数.

        switch (action) {
            case MotionEvent.ACTION_UP:
                setBackgroundResource(R.color.white);
                //choose = -1;
                invalidate();
                if (mTextDialog != null) {
                    mTextDialog.setVisibility(View.INVISIBLE);
                }
                break;
            default:
                setBackgroundResource(R.color.background);
                if (oldChoose != c) {
                    if (c >= 0 && c < b.length) {
                        if (listener != null) {
                            listener.onTouchingLetterChanged(b[c]);
                        }
                        if (mTextDialog != null) {
                            mTextDialog.setText(b[c]);
                            mTextDialog.setVisibility(View.VISIBLE);
                        }
                        choose = c;
                        invalidate();
                    }
                }

                break;
        }
        return true;
    }

    /**
     * 向外松开的方法
     *
     * @param onTouchingLetterChangedListener
     */
    public void setOnTouchingLetterChangedListener(
            OnTouchingLetterChangedListener onTouchingLetterChangedListener) {
        this.onTouchingLetterChangedListener = onTouchingLetterChangedListener;
    }

    /**
     * 接口
     *
     * @author coder
     */
    public interface OnTouchingLetterChangedListener {
        public void onTouchingLetterChanged(String s);
    }

}
