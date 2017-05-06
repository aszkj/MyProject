//
//  XKJHServiceNoticeCell.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WebViewCallBackBlk)(CGFloat webViewHeight);

@interface XKJHServiceNoticeCell : UITableViewCell

@property(nonatomic, strong) UILabel *validTimer;
@property(nonatomic, strong) UILabel *restriction;
@property(nonatomic, copy) WebViewCallBackBlk webViewCallBackBlk;

- (void)resetFrame:(NSString *)content;

@end
