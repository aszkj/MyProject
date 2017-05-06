//
//  TakePhotoUpdateImg.h
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//拍照或访问相册后得到的图片block
typedef void(^GetPhotoBlock)(UIImagePickerController *picker,UIImage *image,NSDictionary *editingDic);
//图片上传之后的回调block
typedef void(^UpdateImgBlock)(NSString *updateImgUrl, NSError *updateImgError);

@interface TakePhotoUpdateImg : NSObject

-(void)showInVC:(UIViewController *)takePhotoVC getPhoto:(GetPhotoBlock)getPhotoBlock upDateImg:(UpdateImgBlock)updateImgBlock;

-(void)updateImage:(UIImage *)image getImgurl:(UpdateImgBlock)updateImgBlock;

@end
