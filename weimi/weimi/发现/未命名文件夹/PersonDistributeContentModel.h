//
//  PersonDistributeContentModel.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DistributeTextType, //文字
    DistributeTextImageType,//文字和图片
    DistributeImageType,//图片
    DistributeSoundType,//语音
} DistributeContentType;
#define kContentToLeft 61
#define kImageItemGap 5
#define kDistributeImageHeight 70


@interface PersonDistributeContentModel : NSObject

@property (nonatomic, assign)DistributeContentType distributeContentType;

@property(nonatomic) NSString* type;

//发布的文字
@property (nonatomic, copy)NSString *distributeText;

//发布的图片，一张
@property (nonatomic, copy)NSString *distributePhotoUrl;

//发布的图片数组，多张
@property (nonatomic, copy)NSArray *distributePhotoUrlArr;

@property (nonatomic, assign)CGFloat contentHeight;




@end
