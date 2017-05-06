//
//  MessageCenterTableViewCell.m
//  WeimiSP
//
//  Created by thinker on 16/2/23.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "MessageCenterTableViewCell.h"

@interface MessageCenterTableViewCell ()

@property (nonatomic, strong) UILabel *cellDateLabel;
@property (nonatomic, strong) UIView *cellContentBackView;
@property (nonatomic, strong) UILabel *cellContentLabel;
@property (nonatomic, strong) UIView *cellLinkView;
@property (nonatomic, strong) UILabel *cellDetailLabel;
@property (nonatomic, strong) UIImageView *cellRightImageView;

@end

@implementation MessageCenterTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


#pragma mark - 实例化UI
- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.cellDateLabel];
    [_cellDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.centerX.equalTo(@0);
        make.height.equalTo(@10);
    }];
    [self.contentView addSubview:self.cellContentBackView];
    [_cellContentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellDateLabel.mas_bottom).with.offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(@0);
    }];
    
    [_cellContentBackView addSubview:self.cellContentLabel];
    [_cellContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
    }];
    
    [_cellContentBackView addSubview:self.cellLinkView];
    [_cellLinkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@-40);
    }];
    [_cellContentBackView addSubview:self.cellRightImageView];
    [_cellContentBackView addSubview:self.cellDetailLabel];
    [_cellDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@40);
        make.bottom.equalTo(@0);
    }];
    
    [_cellRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(_cellDetailLabel.mas_centerY).with.offset(0);
    }];
    
}

#pragma mark - getter

-(UILabel *)cellDateLabel
{
    if (!_cellDateLabel) {
        _cellDateLabel = [[UILabel alloc ]init];
        _cellDateLabel.text = @"2月23日 19:31";
        _cellDateLabel.textAlignment = NSTextAlignmentCenter;
        _cellDateLabel.font = [UIFont CustomFontOfSize:12];
        _cellDateLabel.textColor = UIColorFromRGB(0Xa7a7a7);
    }
    return _cellDateLabel;
}
-(UIView *)cellContentBackView
{
    if (!_cellContentBackView) {
        _cellContentBackView = [[UIView alloc] init];
        _cellContentBackView.backgroundColor = [UIColor whiteColor];
        _cellContentBackView.layer.borderWidth = 0.5;
        _cellContentBackView.layer.cornerRadius = 5;
        _cellContentBackView.clipsToBounds = YES;
        _cellContentBackView.layer.borderColor = UIColorFromRGB(0Xf58614).CGColor;//UIColorFromRGB(0Xf85614).CGColor;//
    }
    return _cellContentBackView;
}
-(UILabel *)cellContentLabel
{
    if (!_cellContentLabel) {
        _cellContentLabel = [[UILabel alloc ]init];
        _cellContentLabel.font = [UIFont CustomFontOfSize:14];
        _cellContentLabel.numberOfLines = 0;
    }
    return _cellContentLabel;
}

- (UIView *)cellLinkView
{
    if (!_cellLinkView) {
        _cellLinkView = [[UIView alloc ]init];
        _cellLinkView.backgroundColor = UIColorFromRGB(0Xdcdcdc);
        _cellLinkView.hidden = YES;
    }
    return _cellLinkView;
}
-(UILabel *)cellDetailLabel
{
    if (!_cellDetailLabel) {
        _cellDetailLabel = [[UILabel alloc ]init];
        _cellDetailLabel.text = @"查看详情";
        _cellDetailLabel.font = [UIFont CustomFontOfSize:15];
        _cellDetailLabel.hidden = YES;
        _cellDetailLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailAction)];
        [_cellDetailLabel addGestureRecognizer:tap];
    }
    return _cellDetailLabel;
}
-(UIImageView *)cellRightImageView
{
    if (!_cellRightImageView) {
        _cellRightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
        _cellRightImageView.hidden = YES;
    }
    return _cellRightImageView;
}


#pragma mark - private methord

- (void)detailAction
{
    NSLog(@"消息详情");
}

-(void)CellCustomWithType:(MessageCenterType)type WithData:(NSString *)content
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    if ([content containsString:@"平台消息："])
    {
        NSDictionary *dict = @{NSForegroundColorAttributeName:kBlueColor};
        [attributedString addAttributes:dict range:NSMakeRange(0, 5)];
    }
    else if ([content containsString:@"公司指令："])
    {
        NSDictionary *dict = @{NSForegroundColorAttributeName:UIColorFromRGB(0Xf85614)};
        [attributedString addAttributes:dict range:NSMakeRange(0, 5)];
    }
    _cellContentLabel.attributedText = attributedString;
    
    if (type == MessageCenterTypeCompany)
    {
        self.cellLinkView.hidden = NO;
        self.cellDetailLabel.hidden = NO;
        self.cellRightImageView.hidden = NO;
    }
    else
    {
        self.cellLinkView.hidden = YES;
        self.cellDetailLabel.hidden = YES;
        self.cellRightImageView.hidden = YES;
    }
}

@end
