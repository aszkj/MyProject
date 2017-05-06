//
//  XKJHServiceDetailsCell.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WebViewCallBackBlk)(CGFloat webViewHeight);

@interface XKJHServiceDetailsCell : UITableViewCell

@property(nonatomic, strong) UILabel *detailText;
@property(nonatomic, strong) UIView *detailView;
@property(nonatomic, copy) WebViewCallBackBlk webViewCallBackBlk;

- (void)resetFrame:(NSString *)content;

@end
