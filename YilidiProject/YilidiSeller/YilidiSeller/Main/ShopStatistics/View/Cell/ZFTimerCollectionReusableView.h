//
//  ZFTimerCollectionReusableView.h
//  YilidiSeller
//
//  Created by yld on 16/6/18.
//  Copyright © 2016年 yld. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ZFTimerCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (void)updateTimer:(NSArray*)array;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com