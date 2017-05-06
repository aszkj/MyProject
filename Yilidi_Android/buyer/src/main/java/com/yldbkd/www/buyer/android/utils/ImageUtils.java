package com.yldbkd.www.buyer.android.utils;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.provider.MediaStore;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.View;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.viewCustomer.ThreeSelectorDialog;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class ImageUtils {
    private Activity activity;
    private Fragment fragment;
    private ThreeSelectorDialog changePhotoDialog;
    protected static final int CHOOSE_PICTURE = 0;
    protected static final int TAKE_PICTURE = 1;
    private static final int CROP_SMALL_PICTURE = 2;
    private Bitmap bitmap;

    public ImageUtils(Activity activity, Fragment fragment) {
        this.activity = activity;
        this.fragment = fragment;
    }

    /**
     * 显示选择图片对话框(是否需要裁剪)
     */
    public void showChoosePicDialog(File file, Boolean isActivity) {
        showChoosePicDialog(file, isActivity, true);
    }

    public void showChoosePicDialog(final File file, final Boolean isActivity, final Boolean isCut) {
        Context context = isActivity ? activity : fragment.getActivity();
        if (changePhotoDialog != null && changePhotoDialog.isShowing()) {
            return;
        }
        changePhotoDialog = new ThreeSelectorDialog(context, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changePhotoDialog.dismiss();
                pickPictureMethod(isCut, isActivity);
            }
        }, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changePhotoDialog.dismiss();
                Intent openCameraIntent = new Intent(
                        MediaStore.ACTION_IMAGE_CAPTURE);
                openCameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(file));
                getResultMethod(openCameraIntent, isActivity, TAKE_PICTURE);
            }
        });
        changePhotoDialog.setData(context.getResources().getString(R.string.profile_choose_photo), context.getResources().getString(R.string.profile_take_photo));
        changePhotoDialog.show();
    }

    private void pickPictureMethod(Boolean isCut, Boolean isActivity) {
        if (isCut) {
            pickPietureAndCut(isActivity);
        } else {
            pickPietureAndNoCut(isActivity);
        }
    }

    /**
     * 图片不需要裁剪
     */
    private void pickPietureAndNoCut(Boolean isActivity) {
        Intent pickIntent = new Intent(Intent.ACTION_PICK);
        pickIntent.setType("image/*");
        getResultMethod(pickIntent, isActivity, CHOOSE_PICTURE);
    }

    /**
     * 图片需要裁剪
     */
    private void pickPietureAndCut(Boolean isActivity) {
        Intent pickIntent = new Intent(Intent.ACTION_GET_CONTENT);
        pickIntent.addCategory(Intent.CATEGORY_OPENABLE);
        pickIntent.setType("image/*");
        getResultMethod(pickIntent, isActivity, CHOOSE_PICTURE);
    }

    /**
     * 选取图片后的操作
     */
    private void getResultMethod(Intent pickIntent, Boolean isActivity, int choosePicture) {
        if (isActivity) {
            activity.startActivityForResult(pickIntent, choosePicture);
        } else {
            fragment.startActivityForResult(pickIntent, choosePicture);
        }
    }

    /**
     * 裁剪图片方法实现
     */
    public void startPhotoZoom(Uri uri, int width, int height, Boolean isActivity) {
        if (uri == null) {
            return;
        }
        Intent intent = new Intent("com.android.camera.action.CROP");
        // 对图片路径进行兼容性判断处理
        String url = BitmapUtils.getPath(isActivity ? activity : fragment.getActivity(), uri);
        intent.setDataAndType(Uri.fromFile(new File(url)), "image/*");
        // crop=true是设置在开启的Intent中设置显示的VIEW可裁剪
        intent.putExtra("crop", "true");
        // aspectX aspectY 是宽高的比例
        intent.putExtra("aspectX", 1);
        intent.putExtra("aspectY", 1);
        // outputX outputY 是裁剪图片宽高
        intent.putExtra("outputX", width);
        intent.putExtra("outputY", height);
        intent.putExtra("return-data", true);
        getResultMethod(intent, isActivity, CROP_SMALL_PICTURE);
    }

    /**
     * 裁剪之后的图片数据进行显示
     */
    public void setImageToView(Intent data, final String url, final Handler handler, final int handlerCode, int handlerTemlCode, final int handlerFailCode) {
        setImageToView(data, null, url, handler, handlerCode, handlerTemlCode, handlerFailCode);
    }

    public void setImageToView(Intent data, final File file, final String url, final Handler handler, final int handlerCode, int handlerTemlCode, final int handlerFailCode) {
        Bundle extras = data.getExtras();
        if (extras != null) {
            // 取得图片路径做显示
            bitmap = extras.getParcelable("data");
            if (bitmap != null) {
                // 取得图片路径做显示
                if (handler != null && handlerTemlCode > 0) {
                    handler.obtainMessage(handlerTemlCode, bitmap).sendToTarget();
                }
                new Thread() {
                    @Override
                    public void run() {
                        super.run();
                        //上传图片到服务器
                        BitmapUtils.uploadImage(url, BitmapUtils.getImagePath(bitmap, file), handler, handlerCode, handlerFailCode);
                    }
                }.start();
            }
        }
    }

    /**
     * 图片名称
     */
    public String getFileName() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss", Locale.CHINA);
        //根据当前时间生成图片的名称
        return "/" + formatter.format(new Date()) + ".jpg";
    }

    /**
     * 私有文件保存路径
     */
    public File getPathFile(Context context) {
        return getPicturePathFile(context, getFileName());
    }

    /**
     * 私有图片保存路径
     */
    public File getPicturePathFile(Context context, String name) {
        String sdState = Environment.getExternalStorageState();
        //根据当前时间生成图片的名称
        File imageFile;
        if (sdState.equals(Environment.MEDIA_MOUNTED)) {
            //获取与应用相关联的路径
            imageFile = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES);
        } else {
            imageFile = Environment.getExternalStorageDirectory();
        }
        return new File(imageFile, name);
    }

    /**
     * 图片保存路径
     */
    public File getPublicPicturePathFile() {
        return getPublicPicturePathFile(getFileName());
    }

    /**
     * 图片保存路径
     */
    public File getPublicPicturePathFile(String name) {
        String imagePath = Environment.getExternalStorageDirectory().getPath() + "/Pictures";
        File file = new File(imagePath);
        if (!file.exists()) {
            file.mkdir();
        }
        return new File(file, name);
    }

    /**
     * 获取相册图片地址
     */
    public String getPhoto(Uri uri, Activity activity) {
        if (uri == null) {
            return null;
        }
        Cursor cursor = activity.getContentResolver().query(uri, null, null, null, null);
        if (cursor == null) {
            return null;
        }
        cursor.moveToFirst();
        String picturePath = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA));
        cursor.close();
        return picturePath;
    }

    /**
     * 刷新相册
     */
    public void refreshTheAlbum(File file, Context context) {
        ContentValues contentValues = new ContentValues();
        contentValues.put("_data", file.toString());
        contentValues.put("description", "save image ---");
        contentValues.put("mime_type", "image/jpeg");
        ContentResolver contentResolver = context.getContentResolver();
        Uri externalContentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
        contentResolver.insert(externalContentUri, contentValues);
    }

    public static String getImageUrl(String url) {
        if (TextUtils.isEmpty(url)) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        int i = url.lastIndexOf("/");
        //目录
        sb.append(url.substring(0, i + 1));
        //缩略图文件名称
        String imageName = url.substring(i + 1, url.length());
        //原图文件名称
        imageName = imageName.substring(imageName.indexOf("_") + 1, imageName.length());
        sb.append(imageName);
        return sb.toString();
    }
}
