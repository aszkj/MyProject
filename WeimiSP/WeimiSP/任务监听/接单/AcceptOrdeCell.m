//
//  AcceptOrdeCell.m
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrdeCell.h"
#import "NIBadgeView.h"
#import "UIView+Design.h"
#import "YYText.h"
#import "NSDate+Addition.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSString+Teshuzifu.h"
#import "UIColor+UIImage.h"
#import "AcceptOrdeEntity.h"

#define kColorOfTabSelectTextImage    [UIColor colorFromHexRGB:@"59C4F0"]   //#232222   选中时tab文字颜色

@interface AcceptOrdeCell ()

@property (nonatomic) UIImageView *leftImg;
@property (nonatomic, strong) MASConstraint *bottomConstraint;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation AcceptOrdeCell

#define rightSpace 11.0
#define avatarWidth 40
#define contentImageWidth 90.0
#define bottomSpace 13.0
#define contentTextColor UIColorFromRGB(0x999999)

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self creatUI];
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    
    CGFloat totalHeight = 0;
    [_contentLabel setNeedsLayout];
    [_contentLabel layoutIfNeeded];
    size = _contentLabel.frame.size;
    size.height = _contentLabel.maxY;

    totalHeight += size.height;
    totalHeight += 20;
    
//    CGFloat totalHeight = 20;
//    totalHeight += [self.contentLabel sizeThatFits:size].height;
//    totalHeight += 40;
    
    return CGSizeMake(size.width, totalHeight);
}

- (void)setContentText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    _contentLabel.attributedText = attributedString;
}

#pragma mark - set UI content

- (void)setEntity:(AcceptOrdeEntity *)entity
{
    NSString *timeString = entity.message_time;
    _timeLabel.text = timeString;
    
    NSString *contentString = entity.message_content;
    [self setContentText:contentString];
//    _contentLabel.text = contentString;
//    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:contentString];
//    [contentText addAttribute:NSForegroundColorAttributeName
//                          value:kColorOfTabSelectTextImage
//                          range:NSMakeRange(0, 5)];
//    
//    _contentLabel.attributedText = contentText;

}

#pragma mark - event response

- (void)deleteAction
{
    if (_deleteBlock) {
        _deleteBlock();
    }
}

- (void)deleteMessage {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要删除该条信息吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];

}

#pragma mark - set UI init

- (void)creatUI
{
    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.deleteImageBtn];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];
    
    UIView *superview = self.contentView;
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview).with.offset(11);
        make.top.equalTo(superview).with.offset(13);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];

    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImg.mas_right).with.offset(11);
        make.centerY.equalTo(_leftImg);
        make.width.equalTo(@200);
        make.height.equalTo(@15);
    }];
    
    [_deleteImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview).with.offset(-13);
        make.top.equalTo(@8);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel);
        make.top.equalTo(_timeLabel.mas_bottom).with.offset(11);
        make.right.equalTo(_deleteImageBtn);
        make.bottom.equalTo(superview).with.offset(-14).priority(MASLayoutPriorityDefaultMedium);

    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(0.3));
    }];
}

- (UIImageView *)leftImg {
    
    if (_leftImg == nil) {
        _leftImg = [XKO_CreateUIViewHelper createUIImageViewWithImageName:@"order_message"];
    }
    
    return _leftImg;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [XKO_CreateUIViewHelper createLabelWithFont:kFontSize15 fontColor:UIColorFromRGB(0x333333) text:@""];
    }
    return _timeLabel;
}

- (UIButton *)deleteImageBtn {
    if (_deleteImageBtn == nil) {
        _deleteImageBtn = [XKO_CreateUIViewHelper createUIButtonWithImageName:@"order_delete"];
        [_deleteImageBtn addTarget:self action:@selector(deleteMessage) forControlEvents:UIControlEventTouchUpInside];
        _deleteImageBtn.layer.cornerRadius = 10;
        _deleteImageBtn.layer.masksToBounds = YES;
    }
    return _deleteImageBtn;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = UIColorFromRGB(0x333333);
        _contentLabel.font = [UIFont CustomFontOfSize:15];
        _contentLabel.preferredMaxLayoutWidth = kScreenWidth - rightSpace * 4;
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0Xd3d3d3);
    }
    return _lineView;
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self deleteAction];
    }
}

@end

@implementation WeimiAcceptOrdeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}



@end

