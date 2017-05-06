//
//  PersonalInfoViewController.h
//  WeimiSP
//
//  Created by thinker on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateHeadImageViewBlock)(UIImage *);
typedef void (^UpdateNameBlock)(NSString *);
typedef void (^UpdateTelBlock)(NSString *);

@interface PersonalInfoViewController : UIViewController

@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tel;

@property (nonatomic, copy) UpdateHeadImageViewBlock updateHeadImageBlock;
@property (nonatomic, copy) UpdateNameBlock updateNameBlock;
@property (nonatomic, copy) UpdateTelBlock updateTelBlock;

@end
