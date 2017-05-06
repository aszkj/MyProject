//
//  RemoteNotificationView.m
//  YilidiBuyer
//
//  Created by mm on 17/4/6.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "RemoteNotificationView.h"
#import "UIImageView+sd_SetImg.h"

@interface RemoteNotificationView ()
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContentLabelToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContentLabelToRightConstraint;

@end

@implementation RemoteNotificationView

- (void)setMessageModel:(PushMessageModel *)messageModel {
    _messageModel = messageModel;
    [self assignData];
}

- (void)assignData {
    CGFloat messageContentLabelToTopEdge;
    if (self.messageModel.messageTitle) {
        self.messageTitleLabel.hidden = NO;
        self.messageTitleLabel.text = self.messageModel.messageTitle;
        messageContentLabelToTopEdge = 28;
    }else {
        self.messageTitleLabel.hidden = YES;
        messageContentLabelToTopEdge =12;
    }
    self.messageContentLabel.text = self.messageModel.messageContent;
    self.messageContentLabelToTopConstraint.constant = messageContentLabelToTopEdge;
     CGFloat messageContentLabelToRightEdge;
    if (self.messageModel.messageImageUrl) {
        self.messageImgView.hidden = NO;
        [self.messageImgView sd_SetImgWithUrlStr:self.messageModel.messageImageUrl placeHolderImgName:nil];
        messageContentLabelToRightEdge = 38;
    }else {
        self.messageImgView.hidden = YES;
        messageContentLabelToRightEdge = 6;
    }
    self.messageContentLabelToRightConstraint.constant = messageContentLabelToRightEdge;
    
}

@end
