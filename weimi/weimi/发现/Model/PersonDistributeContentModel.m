//
//  PersonDistributeContentModel.m
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "PersonDistributeContentModel.h"
#import "NSString+Teshuzifu.h"

@implementation PersonDistributeContentModel


-(CGFloat )contentHeight {
    
    CGFloat textPartHeight = 0.0;
    CGFloat imgPartHeight = 0.0;

    if (self.distributeText) {//有文字
        CGSize size = [self.distributeText getSizeWithWidth:(kScreenWidth-kContentToLeft-kImageItemGap*2) font:[UIFont customFontOfSize:14]];
        textPartHeight = size.height;
    }
    
    if (self.distributePhotoUrlArr.count >= 1) {//有图片
        NSInteger imageCount = self.distributePhotoUrlArr.count;
        NSInteger imageItemNumber = imageCount / 3 + imageCount % 3;
        imgPartHeight = imageItemNumber * kDistributeImageHeight + kImageItemGap * (imageItemNumber + 1);

    }

    return textPartHeight + imgPartHeight;
}

@end
