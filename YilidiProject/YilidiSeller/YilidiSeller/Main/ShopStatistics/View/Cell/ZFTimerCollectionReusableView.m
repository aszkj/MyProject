//
//  ZFTimerCollectionReusableView.m
//  YilidiSeller
//
//  Created by yld on 16/6/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ZFTimerCollectionReusableView.h"

@implementation ZFTimerCollectionReusableView


- (void)updateTimer:(NSArray*)array;
{
    self.timerLabel.text = [NSString stringWithFormat:@"%@年%@月",array[0],array[1]];

}

- (void)awakeFromNib {
    // Initialization code
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com