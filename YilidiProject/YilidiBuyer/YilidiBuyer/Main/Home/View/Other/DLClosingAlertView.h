//
//  DLClosingAlertView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/8/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ClosingBlock)(void);
@interface DLClosingAlertView : UIView

@property (nonatomic,copy)NSString *alertTitle;

@property (nonatomic,strong)ClosingBlock closingBlock;

@end
