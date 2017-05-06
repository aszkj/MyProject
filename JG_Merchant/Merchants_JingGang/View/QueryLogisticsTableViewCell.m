//
//  QueryLogisticsTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "QueryLogisticsTableViewCell.h"
#import "LGDrawer.h"


@interface QueryLogisticsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic) UIView *messageView;
@property (nonatomic) UILabel *messageLabel;

@end

@implementation QueryLogisticsTableViewCell

#define grayColor [UIColor lightGrayColor]
#define currentColor [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1]


- (void)awakeFromNib {
    // Initialization code
    UIView *superView = self.contentView;
    [superView addSubview:self.messageView];
    [self.messageView addSubview:self.messageLabel];
    
    [self setAppearence];
    [self setViewsMASConstraint];

}

#pragma mark - set UI content
- (UIView *)messageView {
    if (_messageView == nil) {
        _messageView = [[UIView alloc] initWithFrame:CGRectZero];
        _messageView.backgroundColor = UIColorFromRGB(0xE7E7E7);
        _messageView.layer.cornerRadius = 4.0;
        _messageView.hidden = YES;
    }
    return _messageView;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor lightGrayColor];
        _messageLabel.font = [UIFont systemFontOfSize:11.0];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (void)setMessage:(NSString *)message {
    self.messageView.hidden = NO;
    self.messageLabel.text = message;
}

#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
    [self setheadColor:grayColor pointColor:grayColor footColor:grayColor];
}

- (UIImage *)lineImageOffset:(CGPoint)point length:(CGFloat)length lineColor:(UIColor *)lineColor {
    return [LGDrawer drawLineWithImageSize:CGSizeMake(3, 100)
                                    length:length
                                    offset:point
                                    rotate:0.0
                                 thickness:1.0
                                 direction:LGDrawerLineDirectionVertical
                           backgroundColor:[UIColor clearColor]
                                     color:lineColor
                                      dash:nil
                               shadowColor:nil
                              shadowOffset:CGPointMake(0, 0)
                                shadowBlur:0];

}

- (UIImage *)pointImageColor:(UIColor *)pointColor {
    return [LGDrawer drawEllipseWithImageSize:CGSizeMake(9, 100)
                                         size:CGSizeMake(9,9)
                                       offset:CGPointMake(0, -35)
                                       rotate:0.f
                              backgroundColor:[UIColor clearColor]
                                    fillColor:pointColor
                                  strokeColor:nil
                              strokeThickness:0.f
                                   strokeDash:nil
                                   strokeType:0
                                  shadowColor:nil
                                 shadowOffset:CGPointZero
                                   shadowBlur:0.f];
}

- (void)setheadColor:(UIColor *)headColor pointColor:(UIColor *)pointColor footColor:(UIColor *)footColor
{
    UIImage *headLine = [self lineImageOffset:CGPointMake(0,-44) length:12 lineColor:headColor];
    UIImage *footLine = [self lineImageOffset:CGPointMake(0, 12) length:88 lineColor:footColor];

    UIImage *pointImage = [self pointImageColor:pointColor];
    
    [self.image setImage:[LGDrawer drawImageOnImage:@[
                                                      headLine,
                                                      pointImage,
                                                      footLine,
                                                      ]]];
    UIView *superView = self.contentView;
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(33);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
        make.width.equalTo(@8);
        make.height.equalTo(@100);
    }];
}

- (void)isFirstObjectLineColor:(UIColor *)lineColor pointColor:(UIColor *)pointColor
{
    UIImage *lineImage = [self lineImageOffset:CGPointMake(0, 12) length:88 lineColor:lineColor];
    UIImage *pointImage = [LGDrawer drawEllipseWithImageSize:CGSizeMake(9, 100)
                                                        size:CGSizeMake(9,9)
                                                      offset:CGPointMake(0, -35)
                                                      rotate:0.f
                                             backgroundColor:[UIColor clearColor]
                                                   fillColor:pointColor
                                                 strokeColor:nil
                                             strokeThickness:0.f
                                                  strokeDash:nil
                                                  strokeType:0
                                                 shadowColor:nil
                                                shadowOffset:CGPointZero
                                                  shadowBlur:0.f];
    
    [self.image setImage:[LGDrawer drawImageOnImage:@[
                                                      lineImage,
                                                      pointImage,
                                                      ]]];
    UIView *superView = self.contentView;
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(33);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
        make.width.equalTo(@8);
        make.height.equalTo(@100);
    }];
}
- (void)isLastObjecLineColor:(UIColor *)lineColor pointColor:(UIColor *)pointColor
{

    UIImage *lineImage = [LGDrawer drawLineWithImageSize:CGSizeMake(3, 35)
                                                  length:20
                                                  offset:CGPointMake(0,-10)
                                                  rotate:0.0
                                               thickness:1.0
                                               direction:LGDrawerLineDirectionVertical
                                         backgroundColor:[UIColor clearColor]
                                                   color:lineColor
                                                    dash:nil
                                             shadowColor:nil
                                            shadowOffset:CGPointMake(0, 0)
                                              shadowBlur:0];

    UIImage *pointImage = [LGDrawer
                        drawEllipseWithImageSize:CGSizeMake(9,35)
                                            size:CGSizeMake(9,9)
                                          offset:CGPointMake(0,0)
                                          rotate:0.f
                                 backgroundColor:[UIColor clearColor]
                                       fillColor:pointColor
                                     strokeColor:nil
                                 strokeThickness:0.f
                                      strokeDash:nil
                                      strokeType:0
                                     shadowColor:nil
                                    shadowOffset:CGPointZero
                                      shadowBlur:0.f];
    
    [self.image setImage:[LGDrawer drawImageOnImage:@[
                                                      lineImage,
                                                      pointImage,
                                                      ]]];
    UIView *superView = self.contentView;
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(33);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
        make.width.equalTo(@8);
        make.height.equalTo(@35);
    }];
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;

    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
    }];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(33);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
        make.width.equalTo(@8);
        make.height.equalTo(@100);
    }];
    [self.detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).with.offset(8);
        make.right.equalTo(superView).with.offset(-8);
        make.top.equalTo(superView).with.offset(7);
    }];
    [self.messageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailTitle);
        make.top.equalTo(self.detailTitle.mas_bottom);
        make.bottom.equalTo(superView).with.offset(-6);
        make.width.equalTo(@(175));
    }];
    superView = self.messageView;
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(6);
        make.left.equalTo(superView).with.offset(10);
        make.right.equalTo(superView).with.offset(-10);
        make.bottom.lessThanOrEqualTo(superView).with.offset(-6);
    }];
}

@end
