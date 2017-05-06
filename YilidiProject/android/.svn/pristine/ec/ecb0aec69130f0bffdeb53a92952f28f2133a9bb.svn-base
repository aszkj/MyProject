package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.AccountActivity;
import com.yldbkd.www.buyer.android.activity.CollectionActivity;
import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.MessageActivity;
import com.yldbkd.www.buyer.android.activity.OrderActivity;
import com.yldbkd.www.buyer.android.activity.OrderListTabActivity;
import com.yldbkd.www.buyer.android.activity.SettingActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.ImageUtils;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.viewCustomer.CircleImageView;

import java.io.File;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

/**
 * 我的页面Fragment
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class ProfileFragment extends BaseFragment {

    private RelativeLayout mRlOrder, mRlOrderWaitPay, mRlOrderWaitReceive, mRlOrderEvalution, mRlOrderRefund;
    private RelativeLayout mRlPruse, mRlMoney, mRlLm, mRlCoupon, mRlVouchar;
    private RelativeLayout mRlCollect, mRlShare, mRlShopping, mRlFuns;

    private TextView userNameView;
    private TextView mExpiredDateView;
    private LinearLayout mLlExpiredView;
    private ImageView profileUserImageView;

    private RelativeLayout joinUsLayout, updateMemberLayout;
    private ImageView setting;
    private ImageView message;
    private Integer memberType = 0;

    private CircleImageView mUserLogo;
    //修改头像
    protected static final int CHOOSE_PICTURE = 0;
    protected static final int TAKE_PICTURE = 1;
    private static final int CROP_SMALL_PICTURE = 2;
    protected static final int IMAGEWIDTH = 240;
    protected static final int IMAGEHEIGHT = 240;
    private File mTempFile;
    private File mTakePictureFile;
    private static final String HEADIMAGENAME = "yldheadimage.jpg";
    private ImageUtils imageUtils;
    private HttpBack<User> changeImageHttpBack;
    private UserLogoHandler userLogoHandler = new UserLogoHandler(this);

    @Override
    public void initBundle() {
    }

    @Override
    public int setLayoutId() {
        return R.layout.profile_fragment;
    }

    @Override
    public void initView(View view) {
        mRlOrder = (RelativeLayout) view.findViewById(R.id.profile_order);
        mRlOrderWaitPay = (RelativeLayout) view.findViewById(R.id.profile_order_wait_pay);
        mRlOrderWaitReceive = (RelativeLayout) view.findViewById(R.id.profile_order_wait_receive);
        mRlOrderEvalution = (RelativeLayout) view.findViewById(R.id.profile_order_evalution);
        mRlOrderRefund = (RelativeLayout) view.findViewById(R.id.profile_order_refund);

        mRlPruse = (RelativeLayout) view.findViewById(R.id.profile_pruse);
        mRlMoney = (RelativeLayout) view.findViewById(R.id.profile_money);
        mRlLm = (RelativeLayout) view.findViewById(R.id.profile_lm);
        mRlCoupon = (RelativeLayout) view.findViewById(R.id.profile_coupon);
        mRlVouchar = (RelativeLayout) view.findViewById(R.id.profile_voucher);

        mRlCollect = (RelativeLayout) view.findViewById(R.id.profile_collect_layout);
        mRlShare = (RelativeLayout) view.findViewById(R.id.profile_share_layout);
        mRlShopping = (RelativeLayout) view.findViewById(R.id.profile_shopping_layout);
        mRlFuns = (RelativeLayout) view.findViewById(R.id.profile_funs_layout);

        setting = (ImageView) view.findViewById(R.id.profile_setting);
        message = (ImageView) view.findViewById(R.id.profile_message);
        userNameView = (TextView) view.findViewById(R.id.profile_user_name_view);
        profileUserImageView = (ImageView) view.findViewById(R.id.profile_user_image_view);
        mLlExpiredView = (LinearLayout) view.findViewById(R.id.ll_expired_view);
        mExpiredDateView = (TextView) view.findViewById(R.id.profile_expired_date_view);
        updateMemberLayout = (RelativeLayout) view.findViewById(R.id.profile_update_member_layout);
        joinUsLayout = (RelativeLayout) view.findViewById(R.id.profile_join_layout);

        mUserLogo = (CircleImageView) view.findViewById(R.id.user_logo);
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        if (isVisibleToUser) {
            memberType = UserUtils.getMemberType();
            if (memberType == Constants.MemberType.VIP) {
                mLlExpiredView.setVisibility(View.VISIBLE);
                profileUserImageView.setBackgroundResource(R.mipmap.vip);
            } else {
                profileUserImageView.setBackgroundResource(R.mipmap.common);
                mLlExpiredView.setVisibility(View.GONE);
            }
        }
    }

    @Override
    public void initData() {
        super.initData();
        // 指定照片保存路径,image.jpg为一个临时文件，每次拍照后这个图片都会被替换
        imageUtils = new ImageUtils(null, this);
        //拍照图片保存，裁剪后图片不保存
        mTakePictureFile = imageUtils.getPublicPicturePathFile();
        mTempFile = imageUtils.getPublicPicturePathFile(HEADIMAGENAME);
    }

    @Override
    public void onResume() {
        super.onResume();
        //        if (!UserUtils.isLogin()) {
        //            ((MainActivity) getActivity()).changeChecked(MainActivity.HOME);
        //        }
        if (userNameView == null) {
            return;
        }
        userNameView.setText(UserUtils.getUserName());
        mExpiredDateView.setText(UserUtils.getExpireDate() == null ? "" : String.valueOf(getResources().getString(R.string.profile_expire_date) + UserUtils.getExpireDate()));
        ImageLoaderUtils.load(mUserLogo, UserUtils.getUserIamgeUrl(), R.mipmap.head_image_default);
    }

    @Override
    public void initHttpBack() {
        changeImageHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                if (user == null) {
                    return;
                }
                UserUtils.setUserIamgeUrl(user.getUserImageUrl());
            }
        };
    }

    @Override
    public void initRequest() {
    }

    @Override
    public void initListener() {
        setting.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), SettingActivity.class);
                intent.setAction(SettingFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        message.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), MessageActivity.class);
                intent.setAction(MessageFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        //升级会员
        updateMemberLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, Constants.RuleAgreementType.VIP_ZONE);
                startActivity(intent);
            }
        });
        //加盟合伙人
        joinUsLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, Constants.RuleAgreementType.JOIN);
                startActivity(intent);
            }
        });
        //修改头像
        mUserLogo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                imageUtils.showChoosePicDialog(mTakePictureFile, false);
            }
        });
        mRlOrder.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoOrderList(0);
            }
        });
        mRlOrderWaitPay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoOrderList(1);
            }
        });
        mRlOrderWaitReceive.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoOrderList(2);
            }
        });
        mRlOrderEvalution.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoOrderList(3);
            }
        });
        mRlOrderRefund.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), OrderActivity.class);
                intent.setAction(OrderListFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        mRlPruse.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                linkTo(AccountActivity.class, null,
                        Constants.RequestCode.ACCOUNT_LOGIN_CODE, true);
            }
        });
        mRlMoney.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                linkTo(AccountActivity.class, null,
                        Constants.RequestCode.ACCOUNT_LOGIN_CODE, true);
            }
        });
        mRlLm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                linkTo(AccountActivity.class, null,
                        Constants.RequestCode.ACCOUNT_LOGIN_CODE, true);
            }
        });
        mRlCoupon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoCouponPage(Constants.TicketType.YOUHUI);
            }
        });
        mRlVouchar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                gotoCouponPage(Constants.TicketType.DIYONG);
            }
        });
        mRlCollect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), CollectionActivity.class));
            }
        });
        mRlShare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, Constants.RuleAgreementType.SHARE_PAGE);
                startActivity(intent);
            }
        });
        mRlShopping.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.no_finish));
            }
        });
        mRlFuns.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.no_finish));
            }
        });
    }

    private void gotoOrderList(int page) {
        Intent intent = new Intent(getActivity(), OrderListTabActivity.class);
        intent.putExtra(Constants.BundleName.ORDER_STATUS, page);
        startActivity(intent);
    }

    private void gotoCouponPage(int type) {
        Intent intent = new Intent(getActivity(), AccountActivity.class);
        intent.putExtra(Constants.BundleName.COUPON_TYPE, type);
        startActivity(intent);
    }

    private void linkTo(Class clazz, String fragmentName, int requestCode, boolean isNeedLogin) {
        Intent intent;
        if (isNeedLogin && !UserUtils.isLogin()) {
            intent = new Intent(getActivity(), LoginActivity.class);
            intent.setAction(LoginFragment.class.getSimpleName());
            startActivityForResult(intent, requestCode);
        } else {
            intent = new Intent(getActivity(), clazz);
            intent.setAction(fragmentName);
            startActivity(intent);
        }
    }

    private void requestChangeImage(String imageUrl) {
        Map<String, Object> map = new HashMap<>();
        map.put("userImageUrl", imageUrl);
        RetrofitUtils.getInstance().modifyUserInfo(ParamUtils.getParam(map), changeImageHttpBack);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) { // 如果返回码是可以用的
            switch (requestCode) {
                case TAKE_PICTURE:
                    imageUtils.startPhotoZoom(Uri.fromFile(mTakePictureFile), IMAGEWIDTH, IMAGEHEIGHT, false); //对图片进行裁剪
                    break;
                case CHOOSE_PICTURE:
                    imageUtils.startPhotoZoom(data.getData(), IMAGEWIDTH, IMAGEHEIGHT, false); //对图片进行裁剪
                    break;
                case CROP_SMALL_PICTURE:
                    if (data != null) {
                        imageUtils.setImageToView(data, mTempFile, Constants.UpLoadImageAddress.UESRLOGOREQUESTURL, userLogoHandler, Constants.HandlerCode.USERLOGORESULT, Constants.HandlerCode.USERLOGOTemp, Constants.HandlerCode.EVALUTIONPICTURERESULTFAIL); // 让刚才选择裁剪得到的图片显示在界面上
                        imageUtils.refreshTheAlbum(mTakePictureFile, getActivity());//刷新内存相册
                    }
                    break;
            }
        }
    }

    private static class UserLogoHandler extends Handler {
        WeakReference<ProfileFragment> fragmentWeakReference;

        public UserLogoHandler(ProfileFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final ProfileFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.USERLOGORESULT:
                    fragment.updateUserLogoImageUrl(msg.obj.toString());
                    fragment.deleteTempFile();
                    break;
                case Constants.HandlerCode.USERLOGOTemp:
                    fragment.showUserLogo((Bitmap) msg.obj);
                    break;
                case Constants.HandlerCode.EVALUTIONPICTURERESULTFAIL:
                    fragment.deleteTempFile();
                    break;
            }
        }
    }

    private void deleteTempFile() {
        //删除头像临时文件
        if (mTempFile.exists()) {
            mTempFile.delete();
        }
    }

    private void showUserLogo(Bitmap bitmap) {
        mUserLogo.setImageBitmap(bitmap);
    }

    private void updateUserLogoImageUrl(String url) {
        requestChangeImage(url);
    }
}
