//
//  CommentInfoCell.m
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "CommentInfoCell.h"

@implementation CommentInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self _createUI];
    
    return self;
}

- (void)_createUI {
    
    self.leftLabel = [XKO_CreateUIViewHelper createLabelWithFont:[UIFont customFontOfSize:14] fontColor:nil text:nil];
    [self.contentView addSubview:self.leftLabel];
    
    //personalCenter_right
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
    [self.contentView addSubview:rightImageView];

    self.rightButton = [XKO_CreateUIViewHelper createUIButtonWithTitle:nil titleColor:    kGetColor(181, 181, 181) titleFont:[UIFont customFontOfSize:14] backgroundColor:nil hasRadius:NO targetSelector:nil target:nil];
    self.rightButton.userInteractionEnabled = NO;
    [self.contentView addSubview:self.rightButton];
    
    //底部cell分割视图
    UIView *bottomSeperateView = [UIView new];
    bottomSeperateView.backgroundColor = kGetColor(241, 243, 248);
    [self.contentView addSubview:bottomSeperateView];
    
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightImageView.mas_left).with.offset(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [bottomSeperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
}

@end
