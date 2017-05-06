//
//  DLBrandHeadView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBrandHeadView.h"

@implementation DLBrandHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)moreButtonClick:(id)sender {
    
    emptyBlock(self.headBlock);
}

@end
