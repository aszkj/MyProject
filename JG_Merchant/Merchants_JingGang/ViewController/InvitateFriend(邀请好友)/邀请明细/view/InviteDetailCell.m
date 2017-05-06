//
//  InviteDetailCell.m
//  jingGang
//
//  Created by HanZhongchou on 15/12/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "InviteDetailCell.h"
#import "InviteDetailModel.h"
#import "UIImageView+WebCache.h"


@interface InviteDetailCell ()
/**
 *  用户名称label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelUserNickName;
/**
 *  用户注册手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *labelUserPhoneNum;
/**
 *  用户注册日期
 */
@property (weak, nonatomic) IBOutlet UILabel *labelRegisterDate;
/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUserIcon;


@end

@implementation InviteDetailCell

- (void)awakeFromNib {
    
    
    //把头像切成正圆
    self.imageViewUserIcon.layer.cornerRadius = 18.5;
    self.imageViewUserIcon.clipsToBounds = YES;
    // Initialization code
}

- (void)setModel:(InviteDetailModel *)model
{
    _model = model;
    
    self.labelUserNickName.text = [NSString stringWithFormat:@"%@",_model.nickname];
    
    NSString *strRegisterTime = [NSString stringWithFormat:@"%@",_model.registerTime];
    
    strRegisterTime = [strRegisterTime substringWithRange:NSMakeRange(0,10)];
    
    self.labelRegisterDate.text  = [strRegisterTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    
    NSMutableString *strMobile = [NSMutableString stringWithFormat:@"%@",_model.mobile];
    [strMobile replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.labelUserPhoneNum.text = strMobile;
    
    NSString *srtUrl = [NSString stringWithFormat:@"%@",_model.headImgPath];
    NSURL *url = [NSURL URLWithString:srtUrl];
    
    [self.imageViewUserIcon sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
