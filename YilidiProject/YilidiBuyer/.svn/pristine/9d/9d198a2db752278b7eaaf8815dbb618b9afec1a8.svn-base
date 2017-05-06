//
//  TakePhotoUpdateImg.m
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UploadPhotoManager.h"
#import "ALActionSheetView.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "Util.h"
#import "UIViewController+hub.h"


@interface UploadPhotoManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy)GetPhotoBlock getphotoBlock;
@property (nonatomic, copy)UpdateImgBlock updateImgBlock;
@property (nonatomic, strong)UploadPhotoImgHandler *uploadPhotoImgHandler;

@property (nonatomic,weak) UIViewController *takePhotoVC;



@end

@implementation UploadPhotoManager

-(void)uploadPhoto:(GetPhotoBlock)getPhotoBlock upDateImg:(UpdateImgBlock)updateImgBlock
{
    _getphotoBlock = getPhotoBlock;
    _updateImgBlock = updateImgBlock;
    
    //弹出选择sheet
    [self _showPhotoSheet];


}

-(void)updateImage:(UIImage *)image getImgurl:(UpdateImgBlock)updateImgBlock {
    
    _updateImgBlock = updateImgBlock;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [self _upLoadHeadImgWithImgData:imageData];

}

-(void)_showPhotoSheet{
    
    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从相册中选择"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {//拍照
            [self showPickerWithType:UIImagePickerControllerSourceTypeCamera];
        }else if (buttonIndex == 1){//从相册中选
            [self showPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{//取消
            
        }
    }];
    
    [actionSheetView show];
}

- (void)showPickerWithType:(UIImagePickerControllerSourceType)photoType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = photoType;
    picker.allowsEditing = self.allowPhotoEditing;
    picker.delegate = self;
    [self.takePhotoVC presentViewController:picker animated:YES completion:nil];
}

#pragma mark - image piker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
//    image = [self useImage:image];
    ;
    DDLogVerbose(@"原图 -- %@,大小 -- %ldkb",image,[self lengthOfImage:image]);
    UploadPhotoImgHandler *uploadPhotoImgHandler = nil;
    //回调产生的photoblock
    if (self.getphotoBlock) {
       uploadPhotoImgHandler =  self.getphotoBlock(picker,image,editingInfo);
    }
    
    if (uploadPhotoImgHandler.takePhotoToBig) {
        return;
    }else {
        image = [uploadPhotoImgHandler handedImgWithOriginalImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
#warning 这里图片上传上去之后，如果超过2M的话系统会默认旋转90°，这里处理这种情况
    image = [self fixOrientation:image];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    DDLogVerbose(@"处理后上传图 -- %@,大小 -- %ldkb",image,[self lengthOfImage:image]);
    [self _upLoadHeadImgWithImgData:imageData];
#ifdef DEBUG
    
#else
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self saveImage:image withName:[self currentDate]];
        });
#endif
}

- (UIImage *)useImage:(UIImage *)image {
    
    @autoreleasepool {
        DDLogVerbose(@"原图 -- %@,大小 %ldkb",image,[self lengthOfImage:image]);
        // Create a graphics image context
        CGFloat imageCropPercent = 1.0f;
        if ([self lengthOfImage:image] > 500 ) {
            imageCropPercent = 4.0f;
        }
        CGSize newSize = CGSizeMake(image.size.width/imageCropPercent, image.size.height/imageCropPercent);
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this new context, with the desired
        // new size
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        // Get the new image from the context
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        DDLogVerbose(@"压缩后 -- %@,大小 %ldkb",newImage,[self lengthOfImage:newImage]);

        // End the context
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
}

-(NSInteger)lengthOfImage:(UIImage *)image {
    
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    
    return [imageData length]/1024;
}


- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI); break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0); transform = CGAffineTransformScale(transform, -1, 1); break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;

}


#pragma mark - 上传图片 - 生成url
#pragma mark - 上传头像图片
-(void)_upLoadHeadImgWithImgData:(NSData *)imgData{
  [_takePhotoVC MB_showLoadingHubWithText:@"上传中"];
    WEAK_SELF
    [AFNHttpRequestOPManager postUserHeadImageData:imgData imageUrl:[self currentDate] subUrl:self.uploadServerUlr block:^(NSDictionary *resultDic, NSError *error) {
        [_takePhotoVC MB_hideLoadingHub];
        if (error.code==1) {
            NSString *newCommentImgUrl = resultDic[@"entity"];
            if (!newCommentImgUrl || [newCommentImgUrl isEqualToString:@""]) {
                error = [NSError errorWithDomain:@"图片返回地址为空" code:0 userInfo:nil];
            }else {
                error = [NSError errorWithDomain:@"图片上传成功" code:1 userInfo:nil];
            }
            if (self.updateImgBlock) {
                self.updateImgBlock(newCommentImgUrl,error);
            }
        }else{
            NSError *error2 = [NSError errorWithDomain:error.localizedDescription code:0 userInfo:nil];
            if (self.updateImgBlock) {
                self.updateImgBlock(nil,error2);
            }
        }
        
    }];

}

//保存到本地图片
- (void) saveImage:(UIImage *)image withName:(NSString *)imageName {
    NSData *currentImage = UIImageJPEGRepresentation(image, 0.5);
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"photoAlbum"];
    NSString *photoPath = [file stringByAppendingPathComponent:imageName];
    [currentImage writeToFile:photoPath atomically:YES];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

//设置照片的名称保存格式
- (NSString *) currentDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSString *imageFileName = [NSString stringWithFormat:@"%@.png", currentDateString];
    
    return imageFileName;
}

- (UIViewController *)takePhotoVC {
    
    if (!_takePhotoVC) {
        _takePhotoVC = [Util currentViewController];
    }
    return _takePhotoVC;

}

@end
