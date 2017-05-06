//
//  MyOrderSectionFooterView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MyOrderSectionFooterView.h"
const CGFloat perButtonWith = 76.0f;
const CGFloat perButtonHorizonalGap = 10.0f;
const CGFloat mostRightbuttonToEdgeGap = 10.0f;
@interface MyOrderSectionFooterView()
@property (weak, nonatomic) IBOutlet UILabel *orderDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderOperationButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteOrderButton;
@end

@implementation MyOrderSectionFooterView




#pragma mark -------------------UIConfigure Method----------------------
#pragma mark - deleteOrderButton

- (void)_setDeleteButtonHidden:(BOOL)deleButtonHidden {
    self.deleteOrderButton.hidden = deleButtonHidden;
}
/**
 *  删除按钮在第几个位置，从右到左，
 */
- (void)_setDeleteButtonPlaceAtIndex:(NSInteger)atIndex {
//  self.deleteOrderButton
}

- (CGFloat)_getToRightEdgeAtIndex:(NSInteger)atIndex{
      CGFloat bottonToRightGap =   (perButtonWith + perButtonHorizonalGap) *  (atIndex - 1)+mostRightbuttonToEdgeGap;
    return bottonToRightGap;
}

#pragma mark - order operator button


@end
