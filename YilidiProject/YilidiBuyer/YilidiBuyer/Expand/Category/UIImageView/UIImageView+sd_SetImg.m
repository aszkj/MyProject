//
//  UIImageView+sd_SetImg.m
//  YilidiSeller
//
//  Created by yld on 16/3/26.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "UIImageView+sd_SetImg.h"

@implementation UIImageView (sd_SetImg)
-(void)sd_SetImgWithUrlStr:(NSString *)urlStr
        placeHolderImgName:(NSString *)placeHolderImgName

{
    if (isEmpty(urlStr)) {
        urlStr = @"";
    }
    if (isEmpty(placeHolderImgName)) {
        placeHolderImgName = @"placeHolder_square";
    }
    UIImage *placeHolderImage = IMAGE(placeHolderImgName);
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeHolderImage];
}

-(void)sd_SetImgWithUrlStr:(NSString *)urlStr
        placeHolderImgName:(NSString *)placeHolderImgName
                   options:(SDWebImageOptions)options

{
    if (isEmpty(urlStr)) {
        urlStr = @"";
    }
    if (isEmpty(placeHolderImgName)) {
        placeHolderImgName = @"placeHolder_square";
    }
    UIImage *placeHolderImage = IMAGE(placeHolderImgName);
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeHolderImage options:options];
}


@end
