//
//  KJGoodDetailPhotoTextDetailView.h
//  jingGang
//
//  Created by 张康健 on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "HMSegmentedControl+setAttribute.h"
typedef void(^UpBlock)(NSInteger currentSelecteIndex);
@interface KJGoodDetailPhotoTextDetailView : UIView
//顶部tabbar
@property (weak, nonatomic) IBOutlet HMSegmentedControl *ptTopbarControl;

//图文详情web
@property (weak, nonatomic) IBOutlet UIWebView *ptPhotoDetailWeb;


//包装清单web
@property (weak, nonatomic) IBOutlet UIWebView *ptPackageListWeb;


//图文详情webUrlStr
@property (nonatomic, copy)NSString *ptPhotoDetailWebUrlStr;

//包装清单webUrlStr
@property (nonatomic, copy)NSString *ptPackageListWebUrlStr;


//下拉时弹上去了回调block
@property (nonatomic, copy)UpBlock upBlock;


//当前选中的index
@property (nonatomic, assign)NSInteger currentIndex;

@end
