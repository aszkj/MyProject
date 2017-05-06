//
//  PluginComponentTableViewCell.m
//  BaiYing_Thinker
//
//  Created by ray on 16/1/12.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "PluginComponentTableViewCell.h"
#import "UIView+Design.h"
#import "NSDate+Addition.h"

@interface PluginComponentTableViewCell ()

@property (nonatomic) PluginComponentController *pluginComponent;
@property (nonatomic) SessonContentModel *message;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation PluginComponentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initUI];
    
    return self;
}


- (void)setMessage:(SessonContentModel *)message
{
    _message = message;
    
    //[self.serverStatusBtn setTitle:message.message.content.component.desc forState:UIControlStateNormal];
    self.serverNameLabel.text = @"唯秘服务";
    [self setTimeWith:message.contentTimestamp / 1000];
    
    /*if (message.message.content.component.viewType == MessageComponentViewTypeDetail) {
        
        UIImageView *rightImage = [[UIImageView alloc] initWithImage:IMAGE(@"个人中心_right")];
        [_serverStatusBtn addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_serverStatusBtn).with.offset(-12);
            make.centerY.equalTo(_serverStatusBtn);
        }];
        [_serverStatusBtn addTarget:self action:@selector(expandWebview) forControlEvents:UIControlEventTouchUpInside];
        
        _webView = self.pluginComponent.webView;
        _webView.layer.cornerRadius = 5.0;
        _webView.layer.masksToBounds = YES;
        _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 90, 1);
        _webView.hidden = YES;
        [self.contentView addSubview:_webView];
        
        NSString *path = _message.message.content.component.url;
        [self.pluginComponent initWebViewDataWithPath:path];
        
        WEAK_SELF
        self.pluginComponent.finishLoadBlock = ^(CGSize size) {
            
            if (weak_self.serverStatusBtn.isHidden && weak_self.webFinishLoadBlock) {
                weak_self.webFinishLoadBlock(NSStringFromCGSize(size),message.session_content_id);
            }
        };
    }*/
}

- (void)setTimeWith:(NSTimeInterval )timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a hh:mm"];
    NSString *chatCellTime = [formatter stringFromDate:date];
    
    NSString *currentDateStr = [NSDate currentDateStringWithFormat:@"yyyy年MM月dd"];
    if ([chatCellTime rangeOfString:currentDateStr].length > 1)
    {
        NSArray *dateArray = [chatCellTime componentsSeparatedByString:@" "];
        if (dateArray.count > 2) {
            _sendTimeLabel.text = [NSString stringWithFormat:@"%@ %@",dateArray[1],dateArray[2]];
        }else {
            _sendTimeLabel.text = dateArray.lastObject;
        }
    }
    else
    {
        _sendTimeLabel.text = chatCellTime;
    }
}

- (void)expandWebview
{
    if (_message != nil && self.webFinishLoadBlock) {

        self.serverStatusBtn.hidden = YES;
        _webView.hidden = NO;
        _webView.y = self.serverStatusBtn.y;
        _webView.x = self.serverStatusBtn.x;
        _webView.width = self.serverStatusBtn.width;
        CGSize size = _pluginComponent.webView.frame.size;
        if (size.height > 1) {
            self.webFinishLoadBlock(NSStringFromCGSize(size),_message.localId);
        }
    }
}

- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _serverNameLabel = [UILabel new];
    _serverNameLabel.textColor = [UIColor whiteColor];
    _serverNameLabel.font = KSmallFont;
    [self.contentView addSubview:_serverNameLabel];
    
    _sendTimeLabel = [UILabel new];
    _sendTimeLabel.textColor = UIColorFromRGB(0xd9d9d9);
    _sendTimeLabel.font = [UIFont CustomFontOfSize:10.0];
    [self.contentView addSubview:_sendTimeLabel];
    UIView *leftLine = [self lineView];
    [self.contentView addSubview:leftLine];
    UIView *rightView = [self lineView];
    [self.contentView addSubview:rightView];
    
    _serverStatusBtn = [UIButton new];
    _serverStatusBtn.layer.cornerRadius = 5.0;
    [_serverStatusBtn setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
    [_serverStatusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _serverStatusBtn.titleLabel.font = KSmallFont;
    [self.contentView addSubview:_serverStatusBtn];
    
    UIView *superView = self.contentView;
    [_serverNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@[superView,_sendTimeLabel,_serverNameLabel]);
        make.top.equalTo(superView).with.offset(12);
        make.centerY.equalTo(@[leftLine,rightView]);
    }];
    CGFloat leftInset = 30;
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@[rightView, @(1.0 / [UIScreen mainScreen].scale)]);
        make.left.equalTo(superView).with.offset(leftInset);
        make.right.equalTo(_serverNameLabel.mas_left).with.offset(-16);
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_serverNameLabel.mas_right).with.offset(16);
        make.right.equalTo(superView).with.offset(-leftInset);
    }];
    
    [_sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serverNameLabel.mas_bottom).with.offset(5);
    }];
    
    [_serverStatusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sendTimeLabel.mas_bottom).with.offset(12);
        make.left.equalTo(superView).with.offset(leftInset);
        make.right.equalTo(superView).with.offset(-leftInset);
        make.height.equalTo(@40);
    }];

}

- (UIView *)lineView {
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    return lineView;
}

- (PluginComponentController *)pluginComponent {
    
    if (!_pluginComponent) {
        _pluginComponent = [[PluginComponentController alloc] init];
    }
    return _pluginComponent;
}


@end
