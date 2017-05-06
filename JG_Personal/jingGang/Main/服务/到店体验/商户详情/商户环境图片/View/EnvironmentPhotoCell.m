//
//  EnvironmentPhotoCell.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "EnvironmentPhotoCell.h"
#import "urlManagerHeader.h"

@implementation EnvironmentPhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        CGFloat width = frame.size.width - 2;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, width, 98)];
        img.image = IMAGE(@"ask_back_pic.jpg");
        img.contentMode =  UIViewContentModeScaleAspectFill;
        img.userInteractionEnabled = YES;
        [self.contentView addSubview:img];
        self.environmentImg = img;
        
//        UIView *transparentView = [UIView new];
//        transparentView.backgroundColor = kGetColorWithAlpha(0, 0, 0, 0.7);
//        [self.contentView addSubview:transparentView];
//        [transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_bottom).with.offset(-1);
//            make.left.equalTo(self.mas_left);
//            make.size.mas_equalTo(CGSizeMake(frame.size.width, 25));
//        }];
//        
//        _titleName = [UILabel new];
//        _titleName.font = kFontSize14;
//        _titleName.textColor = [UIColor whiteColor];
//        [transparentView addSubview:_titleName];
//        [_titleName mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.centerX.equalTo(transparentView.mas_centerX);
//            make.centerY.equalTo(transparentView.mas_centerY);
//            make.size.mas_equalTo(CGSizeMake(80, 14));
//        }];
    }
    return self;
}

@end
