package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Handler;
import android.os.Message;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.DatePicker;
import android.widget.ImageView;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.ImageUtils;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.YLDDatePickerDialog;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.io.File;
import java.lang.ref.WeakReference;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/20 18:26
 * @描述 个人资料
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class UserInfoFragment extends BaseFragment {
    private View backView;
    private TextView titleView;
    private RelativeLayout mRlUserLogo;
    private ImageView userLogoImage;
    private RelativeLayout mRlNickName;
    private TextView mNickName;
    private RelativeLayout mRlSex;
    private TextView mSex;
    private RelativeLayout mRlBirthday;
    private TextView mBirthday;
    private RelativeLayout mRlUserLevel;
    private TextView mUserLevel;
    //头像
    private static final String HEADIMAGENAME = "yldheadimage.jpg";
    protected static final int CHOOSE_PICTURE = 0;
    protected static final int TAKE_PICTURE = 1;
    private static final int CROP_SMALL_PICTURE = 2;
    protected static final int IMAGEWIDTH = 240;
    protected static final int IMAGEHEIGHT = 240;
    private ImageUtils imageUtils;
    private File mTakePictureFile;
    private File mTempFile;
    private UserLogoHandler userLogoHandler = new UserLogoHandler(this);
    private HttpBack<User> updateImageHttpBack;
    //性别
    private int newSex;
    private PopupWindow mGenderPopupWindow;
    private View popupEmptyView;
    private TextView chooseMale;
    private TextView chooseFemale;
    private TextView cancel;
    //生日
    private boolean isSex = false;
    private String newBirthday;
    private int mYear, mMonth, mDay;
    private HttpBack<BaseModel> updateUserInfoHttpBack;
    private YLDDatePickerDialog yLDDatePickerDialog;

    @Override
    public int setLayoutId() {
        return R.layout.userinfo_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.setting_userinfo));
        mRlUserLogo = (RelativeLayout) view.findViewById(R.id.rl_user_logo);
        userLogoImage = (ImageView) view.findViewById(R.id.user_logo);
        mRlNickName = (RelativeLayout) view.findViewById(R.id.rl_nickname);
        mNickName = (TextView) view.findViewById(R.id.tv_nickname);
        mRlSex = (RelativeLayout) view.findViewById(R.id.rl_gender);
        mSex = (TextView) view.findViewById(R.id.tv_sex);
        mRlBirthday = (RelativeLayout) view.findViewById(R.id.rl_birthday);
        mBirthday = (TextView) view.findViewById(R.id.tv_birthday);
        mRlUserLevel = (RelativeLayout) view.findViewById(R.id.rl_user_level);
        mUserLevel = (TextView) view.findViewById(R.id.tv_user_level);
    }

    @Override
    public void initData() {
        imageUtils = new ImageUtils(null, this);
        //拍照图片保存，裁剪后图片不保存
        mTakePictureFile = imageUtils.getPublicPicturePathFile();
        mTempFile = imageUtils.getPublicPicturePathFile(HEADIMAGENAME);
        ImageLoaderUtils.load(userLogoImage, ImageUtils.getImageUrl(UserUtils.getUserIamgeUrl()), R.mipmap.default_head_little);
        mNickName.setText(TextUtils.isEmpty(UserUtils.getNickName()) ? getResources().getString(R.string.nickname_empty) : UserUtils.getNickName());
        showSexToView();
        showBirthdayToView();
        mUserLevel.setText(UserUtils.getMemberType() == 1 ? getResources().getString(R.string.profile_vip) : getResources().getString(R.string.profile_common));
        mUserLevel.setTextColor(ContextCompat.getColor(getActivity(), UserUtils.getMemberType() == 1 ? R.color.colorPrimary : R.color.secondaryText));
        getDefaultDate();
    }

    private void showSexToView() {
        mSex.setText(UserUtils.getSex() == 2 ? getResources().getString(R.string.female) : getResources().getString(R.string.male));
    }

    private void showBirthdayToView() {
        mBirthday.setText(TextUtils.isEmpty(UserUtils.getBirthday()) ? getResources().getString(R.string.text_isempty) : UserUtils.getBirthday());
    }

    @Override
    public void initHttpBack() {
        updateImageHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                if (user == null) {
                    return;
                }
                UserUtils.setUserIamgeUrl(user.getUserImageUrl());
            }
        };
        updateUserInfoHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                if (isSex) {
                    UserUtils.setGender(newSex);
                    showSexToView();
                } else {
                    UserUtils.setBirthday(newBirthday);
                    refreshBirthdayDefault();
                    showBirthdayToView();
                }
            }
        };
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        mRlUserLogo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                imageUtils.showChoosePicDialog(mTakePictureFile, false);
            }
        });
        mRlNickName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(UpdateNickNameFragment.class.getSimpleName(), null, true);
            }
        });
        mRlSex.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showPopUpWindow();
            }
        });
        mRlBirthday.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showDatePicker();
            }
        });
        mRlUserLevel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });
    }

    private void getDefaultDate() {
        if (TextUtils.isEmpty(UserUtils.getBirthday()) || UserUtils.getBirthday().length() < 10) {
            Calendar ca = Calendar.getInstance();
            mYear = ca.get(Calendar.YEAR);
            mMonth = ca.get(Calendar.MONTH);
            mDay = ca.get(Calendar.DAY_OF_MONTH);
        } else {
            refreshBirthdayDefault();
        }
    }

    private void checkSvaeData(int sex, String birthday) {
        if (isSex) {
            if (UserUtils.getSex() == sex) {
                return;
            }
            newSex = sex;
            svaeSexRequest(sex);
        } else {
            if (TextUtils.isEmpty(birthday) || birthday.equals(UserUtils.getBirthday())) {
                return;
            }
            newBirthday = birthday;
            svaeBirthdayRequest(birthday);
        }
    }

    private void svaeBirthdayRequest(String date) {
        Map<String, Object> map = new HashMap<>();
        map.put("birthday", date);
        RetrofitUtils.getInstance(true).modifyUserInfo(ParamUtils.getParam(map), updateUserInfoHttpBack);
    }

    private void svaeSexRequest(int sex) {
        Map<String, Object> map = new HashMap<>();
        map.put("userSex", sex);
        RetrofitUtils.getInstance(true).modifyUserInfo(ParamUtils.getParam(map), updateUserInfoHttpBack);
    }

    private void requestUpdateUserLogo(String imageUrl) {
        Map<String, Object> map = new HashMap<>();
        map.put("userImageUrl", imageUrl);
        RetrofitUtils.getInstance().modifyUserInfo(ParamUtils.getParam(map), updateImageHttpBack);
    }

    private void refreshBirthdayDefault() {
        mYear = Integer.valueOf(UserUtils.getBirthday().substring(0, 4));
        mMonth = Integer.valueOf(UserUtils.getBirthday().substring(5, 7)) - 1;
        mDay = Integer.valueOf(UserUtils.getBirthday().substring(8, UserUtils.getBirthday().length()));
    }

    public void showDatePicker() {
        yLDDatePickerDialog = new YLDDatePickerDialog(getActivity(), AlertDialog.THEME_HOLO_LIGHT,
                new YLDDatePickerDialog.OnDateSetListener() {
                    @Override
                    public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                        isSex = false;
                        String month = (monthOfYear + 1) < 10 ? "0" + (monthOfYear + 1) : String.valueOf(monthOfYear + 1);
                        String day = (dayOfMonth) < 10 ? "0" + dayOfMonth : String.valueOf(dayOfMonth);
                        checkSvaeData(0, String.format(getResources().getString(R.string.birthday_date_formet), year, month, day));
                    }
                }, mYear, mMonth, mDay);
        yLDDatePickerDialog.setCanceledOnTouchOutside(true);
        yLDDatePickerDialog.myShow();
        WindowManager.LayoutParams params = yLDDatePickerDialog.getWindow().getAttributes();
        params.width = DisplayUtils.screenWidth;
        params.gravity = Gravity.BOTTOM;
        yLDDatePickerDialog.getWindow().setAttributes(params);
    }

    private void popupWindowDismiss() {
        if (mGenderPopupWindow != null && mGenderPopupWindow.isShowing()) {
            mGenderPopupWindow.dismiss();
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mGenderPopupWindow != null && mGenderPopupWindow.isShowing()) {
            cleanPopupWindow();
        }
    }

    private void cleanPopupWindow() {
        mGenderPopupWindow.dismiss();
        mGenderPopupWindow = null;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) { // 如果返回码是可以用的
            switch (requestCode) {
                case TAKE_PICTURE:
                    imageUtils.startPhotoZoom(Uri.fromFile(mTakePictureFile), IMAGEWIDTH, IMAGEHEIGHT, false); // 对图片进行裁剪
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

    private void showPopUpWindow() {
        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.popupwindow_gender_layout, null);
        if (mGenderPopupWindow == null) {
            mGenderPopupWindow = new PopupWindow(view);
            mGenderPopupWindow.setHeight(WindowManager.LayoutParams.MATCH_PARENT);
            mGenderPopupWindow.setWidth(WindowManager.LayoutParams.MATCH_PARENT);
        }
        mGenderPopupWindow.setFocusable(true);
        mGenderPopupWindow.setOutsideTouchable(true);
        mGenderPopupWindow.setBackgroundDrawable(new ColorDrawable(0x00000000));
        mGenderPopupWindow.showAtLocation(view, Gravity.BOTTOM, 0, 0);
        mGenderPopupWindow.showAsDropDown(view);

        popupEmptyView = view.findViewById(R.id.empty_popupwindow);
        chooseMale = (TextView) view.findViewById(R.id.choose_male_tv);
        chooseFemale = (TextView) view.findViewById(R.id.choose_female_tv);
        cancel = (TextView) view.findViewById(R.id.cancel);
        chooseMale.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isSex = true;
                popupWindowDismiss();
                checkSvaeData(1, null);
            }
        });
        chooseFemale.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isSex = true;
                popupWindowDismiss();
                checkSvaeData(2, null);
            }
        });
        cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                popupWindowDismiss();
            }
        });
        popupEmptyView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                popupWindowDismiss();
            }
        });
    }

    private static class UserLogoHandler extends Handler {
        WeakReference<UserInfoFragment> fragmentWeakReference;

        public UserLogoHandler(UserInfoFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final UserInfoFragment fragment = fragmentWeakReference.get();
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
        userLogoImage.setImageBitmap(bitmap);
    }

    private void updateUserLogoImageUrl(String url) {
        requestUpdateUserLogo(url);
    }
}
