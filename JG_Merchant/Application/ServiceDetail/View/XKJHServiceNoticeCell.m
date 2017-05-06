//
//  XKJHServiceNoticeCell.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHServiceNoticeCell.h"
#import "UIColor+UIImage.h"

@interface XKJHServiceNoticeCell()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation XKJHServiceNoticeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = background_Color;
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 44)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.width.equalTo(@(kScreenWidth));
            make.height.equalTo(@44);
        }];

        UILabel *instruction = [UILabel new];
        instruction.font = [UIFont systemFontOfSize:16];
        instruction.text = @"购买须知";
        instruction.textColor = [UIColor colorFromHexRGB:@"999999"];
        [titleView addSubview:instruction];
        [instruction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleView.mas_top).with.offset(14);
            make.left.equalTo(titleView.mas_left).with.offset(10);
            make.width.equalTo(@80);
            make.height.equalTo(@16);
        }];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 54, kScreenWidth, 1)];
        backView.backgroundColor = background_Color;
        [self.contentView addSubview:backView];

//
//        UIView *detailView = [UIView new];
//        detailView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:detailView];
//        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).with.offset(55);
//            make.left.equalTo(self.mas_left).with.offset(0);
//            make.width.equalTo(@(kScreenWidth));
//            make.height.equalTo(@96);
//        }];
//        
//        UIImageView *blueIcon = [UIImageView new];
//        blueIcon.image = [[UIColor colorFromHexRGB:@"59C4F0"] translateIntoImage];
//        blueIcon.layer.cornerRadius = 2.5;
//        blueIcon.layer.masksToBounds = YES;
//        [detailView addSubview:blueIcon];
//        [blueIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(20.5);
//            make.left.equalTo(detailView.mas_left).with.offset(10);
//            make.width.equalTo(@(5));
//            make.height.equalTo(@(5));
//        }];
//
//        UILabel *validTimer = [UILabel new];
//        validTimer.font = [UIFont systemFontOfSize:12];
//        validTimer.text = @"有效时间:2013.11.5至2015.12.31";
//        validTimer.textColor = [UIColor colorFromHexRGB:@"666666"];
//        [detailView addSubview:validTimer];
//        [validTimer mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(17);
//            make.left.equalTo(detailView.mas_left).with.offset(19);
//            make.width.equalTo(@(kScreenWidth - 40));
//            make.height.equalTo(@(12));
//        }];
//        self.validTimer = validTimer;
//        
//        UIImageView *blueIcon2 = [UIImageView new];
//        blueIcon2.image = [[UIColor colorFromHexRGB:@"59C4F0"] translateIntoImage];
//        blueIcon2.layer.cornerRadius = 2.5;
//        blueIcon2.layer.masksToBounds = YES;
//        [detailView addSubview:blueIcon2];
//        [blueIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(20.5 + 25);
//            make.left.equalTo(detailView.mas_left).with.offset(10);
//            make.width.equalTo(@(5));
//            make.height.equalTo(@(5));
//        }];
//        
//        UILabel *restriction = [UILabel new];
//        restriction.font = [UIFont systemFontOfSize:12];
//        restriction.text = @"使用限制:有效期内周末，法定节假日通用";
//        restriction.textColor = [UIColor colorFromHexRGB:@"666666"];
//        [detailView addSubview:restriction];
//        [restriction mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(17 + 25);
//            make.left.equalTo(detailView.mas_left).with.offset(19);
//            make.width.equalTo(@(kScreenWidth - 40));
//            make.height.equalTo(@(12));
//        }];
//        self.restriction = restriction;
//        
//        UIImageView *blueIcon3 = [UIImageView new];
//        blueIcon3.image = [[UIColor colorFromHexRGB:@"59C4F0"] translateIntoImage];
//        blueIcon3.layer.cornerRadius = 2.5;
//        blueIcon3.layer.masksToBounds = YES;
//        [detailView addSubview:blueIcon3];
//        [blueIcon3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(20.5 + 50);
//            make.left.equalTo(detailView.mas_left).with.offset(10);
//            make.width.equalTo(@(5));
//            make.height.equalTo(@(5));
//        }];
//        
//        UILabel *rule = [UILabel new];
//        rule.font = [UIFont systemFontOfSize:12];
//        rule.text = @"使用规则:请至少提前48小时致电商家预约";
//        rule.textColor = [UIColor colorFromHexRGB:@"666666"];
//        [detailView addSubview:rule];
//        [rule mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(17 + 50);
//            make.left.equalTo(detailView.mas_left).with.offset(19);
//            make.width.equalTo(@(kScreenWidth - 40));
//            make.height.equalTo(@(12));
//        }];
        
        UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 56, kScreenWidth, 50)];
        webView.delegate=self;
        webView.scrollView.scrollsToTop = NO;
        webView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:webView];
        
        self.webView = webView;
    }
    return self;
}

- (void)resetFrame:(NSString *)content {
    
    [self.webView loadHTMLString:content baseURL:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    CGFloat height = wb.scrollView.contentSize.height;
//    CGRect frame = wb.frame;
//    frame.size.height = height;
//    
//    wb.frame = frame;
//    
//    if (self.frame.size.height != (height + 55)) {
//        if (_webViewCallBackBlk) {
//            _webViewCallBackBlk(height);
//        }
//    }
    
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    if (self.frame.size.height != (fittingSize.height + 55)) {
        if (_webViewCallBackBlk) {
            _webViewCallBackBlk(fittingSize.height);
        }
    }
}

@end
