//
//  DLHomeGotRedPacketView.m
//  YilidiBuyer
//
//  Created by mm on 16/10/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeGotRedPacketView.h"

@interface DLHomeGotRedPacketView()

@property (weak, nonatomic) IBOutlet UIButton *lookMyRedPacketButton;


@end

@implementation DLHomeGotRedPacketView

- (void)awakeFromNib {
    [super awakeFromNib];
    if (iPhone5 || iPhone4) {
        self.lookMyRedPacketButton.titleLabel.font = kSystemFontSize(16);
    }
}

- (IBAction)lookMyRedPacketAction:(id)sender {
    emptyBlock(self.lookMyRedPacketBlock);
    [self _hide];
}

- (IBAction)closeAction:(id)sender {
    [self _hide];
}


- (void)_hide{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
    [self performSelector:@selector(setHidden:) withObject:@(YES) afterDelay:0.6];
}

@end
