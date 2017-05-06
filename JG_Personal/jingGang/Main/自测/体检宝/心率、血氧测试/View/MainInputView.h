//
//  MainInputView.h
//  jingGang
//
//  Created by 张康健 on 15/7/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMDownloadIndicator.h"

//结果回调block
typedef void(^InputResultBlock)(NSInteger heartRateOrOxenValue);
@interface MainInputView : UIView
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint  *topViewToTopConstraint;
@property (weak, nonatomic  ) IBOutlet UITextField         *textField;
@property (weak, nonatomic  ) IBOutlet UIView              *topView;
@property (weak, nonatomic  ) IBOutlet UILabel             *toplabel;
@property (weak, nonatomic  ) IBOutlet UITextField         *typeTextFiled;
@property (weak, nonatomic  ) IBOutlet UILabel             *typeLabel;
@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint  *middleEdgeConstraint;
@property (nonatomic, strong) InputResultBlock              inputResultBlock;

//心率还是血氧
@property (nonatomic, assign) BOOL                          isOxen;

@end
