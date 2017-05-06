//
//  ZhengZhuangListVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SHANSHI_COMIN,
    FACE_CLICK_COMIN,
    FIGURE_CLICK_COMIN,
    ZhengZhuang_COMIN,
}ComminType;

typedef enum : NSUInteger {
    FACE_CLICK_MAN,
    FACE_CLICK_WOMEN,
}FaceClickType;

@interface ZhengZhuangListVC : UIViewController

@property (nonatomic,assign)ComminType comminType;
@property(nonatomic,assign)BOOL isJingGang;
@property (nonatomic,assign)NSNumber* ID;

@property(nonatomic,assign)NSInteger isOKCLick;
@property (nonatomic,assign)long fen_lie_ID;

@property (nonatomic,assign)FaceClickType faceClickType;


@end
