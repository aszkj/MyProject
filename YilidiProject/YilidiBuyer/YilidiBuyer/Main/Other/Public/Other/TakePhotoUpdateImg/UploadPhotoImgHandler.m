//
//  ImgHandler.m
//  YilidiBuyer
//
//  Created by mm on 17/2/28.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "UploadPhotoImgHandler.h"
#import "UIImage+extern.h"
#import "UIImage+ProportionalFill.h"

#define KTakePhotoMaxWidth 375.0f
#define KUserHeaderImgSize 240.0f

typedef NS_ENUM(NSInteger, TakePhotoType) {
    TakePhotoType_Comment,//评价上传图片
    TakePhotoType_UserHeader,//用户头像上传图片
};


@interface UploadPhotoImgHandler ()

@property (nonatomic, assign)CGFloat takePhotoWithToHeightPercent;

@property (nonatomic, assign)TakePhotoType currentTakePhotoType;


@end

@implementation UploadPhotoImgHandler


- (UIImage *)handedImgWithOriginalImage:(UIImage *)originalImage {
    
    if (self.currentTakePhotoType == TakePhotoType_Comment) {
        //这里上传也按照375来，不然很多图片按照750压缩，都大于三兆
        return [self handleCommentPhoto:originalImage isShowInList:YES];
    }else if (self.currentTakePhotoType == TakePhotoType_UserHeader) {
        return [self handleUserHeaderPhoto:originalImage];
    }
    return nil;

}


#pragma mark - 评价上传图片
- (BOOL)isToBigOfCommentPhoto:(UIImage *)commentPhoto {
    
    if (!commentPhoto) {
        self.takePhotoToBig = YES;
        return self.takePhotoToBig;
    }
    self.takePhotoWithToHeightPercent = commentPhoto.size.width / commentPhoto.size.height;
    if (self.takePhotoWithToHeightPercent < 0.5 || self.takePhotoWithToHeightPercent > 2.0) {
        self.takePhotoToBig = YES;
    }else {
        self.takePhotoToBig = NO;
    }
    
    if (commentPhoto.size.width < 300 && commentPhoto.size.height < 300) {
        self.takePhotoToBig = YES;
    }
    
    return self.takePhotoToBig;
}

- (UIImage *)handleCommentPhoto:(UIImage *)commentPhoto isShowInList:(BOOL)isShowInList{
    self.currentTakePhotoType = TakePhotoType_Comment;
    CGFloat maxTakePhotoMaxWidth = isShowInList ? KTakePhotoMaxWidth : KTakePhotoMaxWidth * 2;
    if (commentPhoto.size.width <= maxTakePhotoMaxWidth) {
        return commentPhoto;
    }else {
        return  [commentPhoto imageScaledToSize:CGSizeMake(maxTakePhotoMaxWidth, maxTakePhotoMaxWidth/self.takePhotoWithToHeightPercent)];
    }
    return nil;
}

- (UIImage *)getMakeCommentListShowPhoto:(UIImage *)originalTakedPhoto {
    
      self.currentTakePhotoType = TakePhotoType_Comment;
      return originalTakedPhoto;
//    return [self handleCommentPhoto:originalTakedPhoto isShowInList:YES];
}


#pragma mark - 用户头像上传图片
- (BOOL)isToBigOfUserHeaderPhoto:(UIImage *)userHeaderPhoto {
    //用户头像上传暂时不做比例限制
    self.takePhotoToBig = NO;
    return self.takePhotoToBig;
}

- (UIImage *)handleUserHeaderPhoto:(UIImage *)userHeaderPhoto {
    self.currentTakePhotoType = TakePhotoType_UserHeader;
    userHeaderPhoto = [userHeaderPhoto imageScaledToSize:CGSizeMake(KUserHeaderImgSize, KUserHeaderImgSize)];
    return userHeaderPhoto;

}

-(NSInteger)lengthOfImage:(UIImage *)image {
    
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    
    return [imageData length]/1024;
}

- (void)dealloc {
    DDLogVerbose(@"UploadPhotoImgHandler 释放了");
}

@end
