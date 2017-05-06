//
//  ImgHandler.h
//  YilidiBuyer
//
//  Created by mm on 17/2/28.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadPhotoImgHandler : NSObject

@property (nonatomic,assign)BOOL takePhotoToBig;

@property (nonatomic,strong)UIImage *handledImage;


- (UIImage *)handedImgWithOriginalImage:(UIImage *)originalImage;

#pragma mark - 评价上传图片
- (BOOL)isToBigOfCommentPhoto:(UIImage *)commentPhoto;
//- (UIImage *)handleCommentPhoto:(UIImage *)commentPhoto;
- (UIImage *)getMakeCommentListShowPhoto:(UIImage *)originalTakedPhoto;


#pragma mark - 用户头像上传图片
- (BOOL)isToBigOfUserHeaderPhoto:(UIImage *)userHeaderPhoto;
- (UIImage *)handleUserHeaderPhoto:(UIImage *)userHeaderPhoto;


@end
