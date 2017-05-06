//
//  JGBloodPressureTestErrorView.h
//  jingGang
//
//  Created by dengxf on 16/2/19.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGBloodPressureTestErrorView;

typedef void(^ShowViewBlock)(JGBloodPressureTestErrorView *errorView);

typedef void(^DismissViewBlock)(JGBloodPressureTestErrorView *errorView);

typedef void(^CloseViewActionBlock)(void);

@interface JGBloodPressureTestErrorView : UIView

@property (copy , nonatomic) ShowViewBlock showViewBlock;

@property (copy , nonatomic) DismissViewBlock dismissViewBlock;
     
@property (copy , nonatomic) CloseViewActionBlock closeViewActionBlock;


- (void)showView;

- (void)dissMissCompleted:(void(^)())completed;
@end
