//
//  XKJHServiceDetailsCell.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHServiceDetailsCell.h"
#import "UIColor+UIImage.h"
#import "Masonry.h"

@interface XKJHServiceDetailsCell()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation XKJHServiceDetailsCell

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
        
        UILabel *instruction = [UILabel new];
        instruction.font = [UIFont systemFontOfSize:16];
        instruction.text = @"详细说明";
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

        
//        UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, 50)];
//        detailView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:detailView];
//        self.detailView = detailView;
//        
//        UILabel *detailText = [UILabel new];
//        detailText.font = [UIFont systemFontOfSize:12];
//        detailText.numberOfLines = 0;
//        detailText.textColor = [UIColor colorFromHexRGB:@"666666"];
//        [detailView addSubview:detailText];
//        [detailText mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(detailView.mas_top).with.offset(17);
//            make.left.equalTo(detailView.mas_left).with.offset(10);
//            make.width.equalTo(@(kScreenWidth - 40));
//        }];
//        self.detailText = detailText;
        
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
//    if (!self.frame.size.height == (height + 55)) {
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
