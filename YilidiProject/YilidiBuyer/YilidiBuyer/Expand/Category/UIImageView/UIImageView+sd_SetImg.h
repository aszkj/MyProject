//
//  UIImageView+sd_SetImg.h
//  YilidiSeller
//
//  Created by yld on 16/3/26.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (sd_SetImg)
-(void)sd_SetImgWithUrlStr:(NSString *)urlStr
        placeHolderImgName:(NSString *)placeHolderImgName;

-(void)sd_SetImgWithUrlStr:(NSString *)urlStr
        placeHolderImgName:(NSString *)placeHolderImgName
                   options:(SDWebImageOptions)options;

@end
