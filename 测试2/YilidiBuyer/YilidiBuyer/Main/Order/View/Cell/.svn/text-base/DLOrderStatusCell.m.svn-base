//
//  DLOrderStatusCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderStatusCell.h"
#import "DLInvoiceStatusModel.h"
#import "ProjectStandardUIDefineConst.h"
@implementation DLOrderStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DLInvoiceStatusModel *)model {
    
    self.orderStatus.text = model.statusCodeName;
    self.orderTime.text = model.statusTime;
    self.orderContent.isNeedAtAndPoundSign = YES;
    [self.orderContent setEmojiText:model.statusNote];
    self.orderContent.emojiDelegate = self;
    self.orderContent.backgroundColor = [UIColor clearColor];
    self.orderContent.numberOfLines = 0;
    self.orderContent.commonLinkColor = KCOLOR_PROJECT_BLUE;
}


- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            [Util dialServerNumber:link];
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}


@end
