//
//  DLShareBottomView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/11/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShareBottomView.h"
#import "UIView+BlockGesture.h"
@implementation DLShareBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{

    [super awakeFromNib];
    WEAK_SELF
    [self.wechatView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
         emptyBlock(weak_self.wechatBlock);
        
    }];
    [self.friendView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        emptyBlock(weak_self.friendsBlock);
        
    }];
    [self.messageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        emptyBlock(weak_self.messageBlock);
        
    }];
}
@end
