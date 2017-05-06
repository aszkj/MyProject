//
//  PostCircleController.h
//  jingGang
//
//  Created by wangying on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCircleController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSNumber *nub;
@property int circleId;
@end
