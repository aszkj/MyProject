//
//  GFtieziViewController.h
//  jingGang
//
//  Created by thinker on 15/6/23.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommentRereshBlcok2)(BOOL success);

@interface GFtieziViewController : UIViewController

@property (nonatomic,copy)CommentRereshBlcok2 commentBlcock;
@property (nonatomic,copy)NSString        *titleName;

@property int circleId;

@end
