//
//  IntegralDetailTableViewCell.m
//  jingGang
//
//  Created by ray on 15/10/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralDetailTableViewCell.h"
#import "IGo.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"

@interface IntegralDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *costIntegral;
@property (weak, nonatomic) IBOutlet UILabel *coutLabel;

@end

@implementation IntegralDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEntity:(id)object {
    IGo *goodsInfo = object;
    CGRect imageFrame = self.goodsImage.frame;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(goodsInfo.images,CGRectGetWidth(imageFrame),CGRectGetHeight(imageFrame))]
                       placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];
    self.goodsName.text = goodsInfo.igoName;
    self.costIntegral.text = goodsInfo.igoInteral.stringValue;
    self.coutLabel.text = [@"x" stringByAppendingString:goodsInfo.count.stringValue];
}

@end
