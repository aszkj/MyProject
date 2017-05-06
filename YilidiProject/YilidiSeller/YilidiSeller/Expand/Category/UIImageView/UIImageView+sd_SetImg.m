//
//  UIImageView+sd_SetImg.m
//  YilidiSeller
//
//  Created by yld on 16/3/26.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "UIImageView+sd_SetImg.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (sd_SetImg)
-(void)sd_SetImgWithUrlStr:(NSString *)urlStr
        placeHolderImgName:(NSString *)placeHolderImgName
{
    if (isEmpty(urlStr)) {
        return;
    }
    UIImage *placeHolderImage = nil;
    if (placeHolderImgName) {
        placeHolderImage = [UIImage imageNamed:placeHolderImgName];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeHolderImage];
}


@end
