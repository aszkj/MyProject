//
//  HeadImgCell.m
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "HeadImgCell.h"
#import "UIView+BlockGesture.h"

@implementation HeadImgCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self _createUI];
    
    return self;
}

- (void)_createUI {

    UILabel *headerLabel = [XKO_CreateUIViewHelper createLabelWithFont:[UIFont customFontOfSize:14] fontColor:nil text:@"头像"];
    [self.contentView addSubview:headerLabel];
    
    //头像描边
    UIView *avartBgView = [UIView new];
    avartBgView.backgroundColor = UIColorFromRGB(0xeeeeee);
    avartBgView.layer.cornerRadius = 31;
    avartBgView.layer.masksToBounds = YES;
    [self.contentView addSubview:avartBgView];
    
    self.headerImgView = [UIImageView new];
    self.headerImgView.layer.cornerRadius = 30;
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.userInteractionEnabled = YES;
    self.headerImgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.headerImgView];
    WEAK_SELF
    [self.headerImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        //更换头像
        if (weak_self.updateHeaderImgBlock) {
            weak_self.updateHeaderImgBlock();
        }
    }];

    //personalCenter_right
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
    [self.contentView addSubview:rightImageView];
    
    //底部cell分割视图
    UIView *bottomSeperateView = [UIView new];
    bottomSeperateView.backgroundColor = kGetColor(241, 243, 248);
    [self.contentView addSubview:bottomSeperateView];
    
    
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self.contentView);
        
    }];
    
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [avartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(62, 62));
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(rightImageView.mas_left).with.offset(-10);
        
    }];
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.center.mas_equalTo(avartBgView);
        
    }];

    
    [bottomSeperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
}

@end
