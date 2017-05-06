//
//  ImageCropperPicker.m
//  imageCropper
//
//  Created by thinker on 16/1/26.
//  Copyright © 2016年 thinker. All rights reserved.
//

#import "ImageCropperPicker.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@interface ImageCropperPicker ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

@end

@implementation ImageCropperPicker

- (instancetype)init
{
    if (self = [super init])
    {
        self.delegate = self;
        self.navigationBar.barTintColor = [UIColor darkGrayColor];
    }
    return self;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
        // 裁剪
    UIImage *selectImage = [self imageByScalingToMaxSize:image];
    VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:selectImage cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
    imgEditorVC.delegate = self;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        imgEditorVC.navHeight = 0;
    }
    else{
        imgEditorVC.navHeight = 64;
    }
    [self pushViewController:imgEditorVC animated:YES];

}


#pragma mark - VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    if ([self.dataSource respondsToSelector:@selector(imageCropper:didFinished:)])
    {
        [self.dataSource imageCropper:cropperViewController didFinished:editedImage];
    }
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    if ([self.dataSource respondsToSelector:@selector(imageCropperDidCancel:)])
    {
        [self.dataSource imageCropperDidCancel:cropperViewController];
    }
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}

#pragma mark image scale utility

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}




@end
