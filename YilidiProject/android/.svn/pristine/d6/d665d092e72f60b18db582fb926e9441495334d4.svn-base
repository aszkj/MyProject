package com.yldbkd.www.seller.android.fragment;

import android.support.v4.content.ContextCompat;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.utils.UserUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 邀请码界面
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class InviteCodeFragment extends BaseFragment {

    private String inviteCode;

    private LinearLayout backView;
    private ImgTxtButton rightView;

    private TextView inviteTextView;
    private Button shareBtn;
    private TextView invite2dView;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_invite;
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_invite));
        rightView = (ImgTxtButton) view.findViewById(R.id.itb_right);
        rightView.setBackgroundResource(R.mipmap.catalog);

        inviteTextView = (TextView) view.findViewById(R.id.tv_invite_code);
        shareBtn = (Button) view.findViewById(R.id.btn_invite_share_code);
        invite2dView = (TextView) view.findViewById(R.id.tv_invite_code_2d);
    }

    @Override
    public void initData() {
        if (UserUtils.getStore() != null) {
            inviteCode = UserUtils.getStore().getInvitationCode();
        }
        inviteTextView.setText(inviteCode);
        TextChangeUtils.setImageText(getActivity(), invite2dView, R.mipmap.invite_up_arrow,
                getString(R.string.invite_code_2d), true);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        rightView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(InviteListFragment.class.getSimpleName(), null, true);
            }
        });
        shareBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
        invite2dView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                show2dView();
            }
        });
    }

    private void show2dView() {
        View view = View.inflate(getActivity(), R.layout.dowload_code_view, null);
        final PopupWindow downloadWindow = new PopupWindow(view, ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT, true);
        downloadWindow.setTouchable(true);
        downloadWindow.setTouchInterceptor(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return false;
            }
        });
        downloadWindow.setBackgroundDrawable(ContextCompat.getDrawable(getActivity(), R.mipmap.transparent));

        TextView textView = (TextView) view.findViewById(R.id.tv_invite_code_2d_code);
        List<Integer> styles = new ArrayList<>();
        styles.add(R.style.TextAppearance_Normal_Blue);
        TextChangeUtils.setDifferentText(getActivity(), textView, R.string.invite_code_2d_content_3,
                styles, inviteCode);

        ImageView closeView = (ImageView) view.findViewById(R.id.iv_invite_code_close);
        closeView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                downloadWindow.dismiss();
            }
        });

        ImageView image2dView = (ImageView) view.findViewById(R.id.iv_invite_image_2d);
        ImageLoaderUtils.load(image2dView, getString(R.string.invite_2d_image_url));

        downloadWindow.showAtLocation(invite2dView, Gravity.BOTTOM, 0, 0);
    }
}
