//
//  DLInputRecieveGoodsCodeView.m
//  YilidiSeller
//
//  Created by yld on 16/6/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInputRecieveGoodsCodeView.h"
#import "Util.h"
#import "UIView+BlockGesture.h"

const CGFloat inputRecieveCodeHeight = 80;

@interface DLInputRecieveGoodsCodeView()
@property (weak, nonatomic) IBOutlet UITextField *recieveCodeTextFiled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputRecieveCodeViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputRecieveCodeViewToTopConstraint;

@end

@implementation DLInputRecieveGoodsCodeView

- (void)awakeFromNib {
    self.maskView.userInteractionEnabled = YES;
    self.inputRecieveCodeViewToTopConstraint.constant = -inputRecieveCodeHeight;
    [self layoutIfNeeded];
    WEAK_SELF
    [self.maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self close];
    }];
}

- (IBAction)makeSureInputCodeAction:(id)sender {
    
    if (isEmpty(self.recieveCodeTextFiled.text)) {
        [Util ShowAlertWithOnlyMessage:@"请输入收货码"];
        return;
    }
    [self close];
    emptyBlock(self.sureInputCodeBlock,self.recieveCodeTextFiled.text);
    
}

- (void)show {
    self.recieveCodeTextFiled.text=@"";
    [self performSelector:@selector(_showDelay) withObject:nil afterDelay:0.1];
    self.hidden = NO;
    
}

- (void)_showDelay {
    [self _showInputViewAnimationToTopEdges:0];

}

- (void)close {
    [self.recieveCodeTextFiled resignFirstResponder];
    [self _showInputViewAnimationToTopEdges:-inputRecieveCodeHeight];
    [self performSelector:@selector(delayHidden) withObject:nil afterDelay:0.3];
}

- (void)delayHidden {
    self.hidden = YES;
}

-(void)_showInputViewAnimationToTopEdges:(CGFloat)topEdges {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.inputRecieveCodeViewToTopConstraint.constant = topEdges;
        [self layoutIfNeeded];
    }];
}


@end
