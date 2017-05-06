//
//  comsultationTableViewCell.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "comsultationTableViewCell.h"
#import "ReactiveCocoa.h"
#import "UIButton+WebCache.h"

@interface comsultationTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation comsultationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    @weakify(self)
    
    [[self._sex_lab rac_signalForSelector:@selector(layoutSubviews)] subscribeNext:^(id x) {
        @strongify(self)
        self.widthConstraint.constant = CGRectGetWidth(self._sex_lab.frame) + 16;
        [self.contentView setNeedsLayout];
    }];
//    self._head_btn.imageView.layer.cornerRadius = CGRectGetHeight(self._head_btn.frame) / 2;
//    self._head_btn.imageView.clipsToBounds = YES;
    self.bg_head_img.layer.cornerRadius = 44;
    self.bg_head_img.clipsToBounds = YES;
    self._head_btn.layer.cornerRadius = 40;
    self._head_btn.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setEntity:(NSDictionary *)dic {
    NSURL * img_url = [NSURL URLWithString:[dic objectForKey:@"headImgPath"]];
    [self._head_btn sd_setBackgroundImageWithURL:img_url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"per_defult_head"]];
    self._name_lab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    self._dis_lab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]];
    if ([self._dis_lab.text isEqualToString:@"(null)"]) {
        self._dis_lab.text = @"该医生暂无介绍";
    }
    self._sex_lab.text = [dic objectForKey:@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
