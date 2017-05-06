//
//  JGCloudValueController.h
//  jingGang
//
//  Created by dengxf on 16/1/6.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGUserValueBottomView.h"
@interface JGCloudValueController : UIViewController

- (instancetype)initWithControllerType:(BottomButtonType)buttonType;

@property (copy , nonatomic) NSString *totleValue;

@end
