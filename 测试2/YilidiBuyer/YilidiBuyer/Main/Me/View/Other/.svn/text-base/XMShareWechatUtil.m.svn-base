//
//  XMShareWechatUtil.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareWechatUtil.h"
#import "WXApi.h"

@interface XMShareWechatUtil()

@property (nonatomic, strong) UIImage *shareImage;

@property (nonatomic, strong) UIImage *thumbImage;

@end

@implementation XMShareWechatUtil



- (void)shareToWeixinSession
{
    
    [self shareToWeixinBase:WXSceneSession];
    
}

- (void)shareToWeixinTimeline
{
    
    [self shareToWeixinBase:WXSceneTimeline];
    
}

- (void)shareToWeixinBase:(enum WXScene)scene
{
    
    
    if (self.imageUrl !=nil) {
        //先查找，存在就直接取缓存，不存在删除之前缓存的再下载
        if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.imageUrl]==nil) {
            [[SDImageCache sharedImageCache]clearMemory];
            WEAK_SELF
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:[NSURL URLWithString:self.imageUrl]
                                  options:0
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     // progression tracking code
                                 }
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                    if (image) {
                                        //原图
                                        weak_self.shareImage  = image;
                                        
                                        //缩略图
                                        weak_self.thumbImage = [self imageByScalingAndCroppingForSize:CGSizeMake(200, 200) withSourceImage:weak_self.shareImage];
                                        
                                        [weak_self  shareCircleFriendsAndFriendsAndMessage:scene];
                                    }
                                    
                                    NSLog(@"下载成功");
                                }];
            
        }else {
        
            //原图
            self.shareImage  = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.imageUrl];
            
            //缩略图
            self.thumbImage = [self imageByScalingAndCroppingForSize:CGSizeMake(200, 200) withSourceImage:self.shareImage];
            
            [self  shareCircleFriendsAndFriendsAndMessage:scene];
            
            
        }
    
   
    }else{
    
        
        self.thumbImage = SHARE_DEFAULTIMG;
        [self  shareCircleFriendsAndFriendsAndMessage:scene];
        
    }
    
    
    
}


- (void)shareCircleFriendsAndFriendsAndMessage:(enum WXScene)scene{

    
    if ([self.shareType integerValue]==1) {
        //文字类型分享
        SendMessageToWXReq* messageReq = [[SendMessageToWXReq alloc] init];
        messageReq.bText = YES;
        messageReq.text = self.shareText;
        messageReq.scene = scene;
        [WXApi sendReq:messageReq];
    }else if ([self.shareType integerValue]==2){
        //图片类型分享
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:self.thumbImage];
        WXImageObject *shareImage = [WXImageObject object];
        [shareImage setImageData:UIImageJPEGRepresentation(self.shareImage, 0.5)];
        message.mediaObject = shareImage;
        SendMessageToWXReq* imageReq = [[SendMessageToWXReq alloc] init];
        imageReq.bText = NO;
        imageReq.message = message;
        imageReq.scene = scene;
        [WXApi sendReq:imageReq];
        
        
    }else {
        //网页类型分享
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:self.thumbImage];
        message.title = self.shareTitle;
        message.description = self.shareText;
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = self.shareUrl;
        message.mediaObject = ext;
        SendMessageToWXReq* webPagereq = [[SendMessageToWXReq alloc] init];
        webPagereq.bText = NO;
        webPagereq.message = message;
        webPagereq.scene = scene;
        [WXApi sendReq:webPagereq];
    }

    
    
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage
{
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
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }

    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;

}



+ (instancetype)sharedInstance
{
    
    static XMShareWechatUtil* util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareWechatUtil alloc] init];
        
    });
    return util;
    
}

- (instancetype)init
{
    
    static id obj=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [super init];
        if (obj) {
            
        }
        
    });
    self=obj;
    return self;
    
}


@end
