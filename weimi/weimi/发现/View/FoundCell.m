//
//  FoundCell.m
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "FoundCell.h"
//#import "UIImageView+MJWebCache.h"
#import "NSDate+Addition.h"
#import "NSDate+Utilities.h"
#import "NSString+Teshuzifu.h"




@implementation FoundCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self _createUI];
    
    return self;
}

- (void)_createUI {
    
    UIView *avartBgView = [UIView new];
    avartBgView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self.contentView addSubview:avartBgView];
    avartBgView.layer.cornerRadius = 24;
    avartBgView.layer.masksToBounds = YES;
    
    //创建
    self.avartImgView = [UIImageView new];
    self.avartImgView.layer.cornerRadius = 23;
    self.avartImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avartImgView];
    
    
    self.redNoteLabel = [UILabel new];
    self.redNoteLabel.layer.cornerRadius = 3.5f;
    self.redNoteLabel.layer.masksToBounds = YES;
    self.redNoteLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.redNoteLabel];
    
    
    self.nickNameLabel = [XKO_CreateUIViewHelper createLabelWithFont:[UIFont boldSystemFontOfSize:14.0] fontColor:UIColorFromRGB(0x333333) text:nil];
    [self.contentView addSubview:self.nickNameLabel];

    self.fromWhereButton = [XKO_CreateUIViewHelper createUIButtonWithTitle:nil titleColor:kWhiteColor titleFont:[UIFont customFontOfSize:10] backgroundColor:kGetColor(236, 162, 221) hasRadius:YES targetSelector:nil target:nil];
    [self.contentView addSubview:self.fromWhereButton];
    self.fromWhereButton.layer.cornerRadius = 7.0;
    self.fromWhereButton.layer.masksToBounds = YES;
    
    
    self.timeLabel = [XKO_CreateUIViewHelper createLabelWithFont:[UIFont customFontOfSize:13] fontColor:kGetColor(192, 192, 192) text:nil];
    [self.contentView addSubview:self.timeLabel];
    
    UIView *seperateViewTop = [UIView new];
    seperateViewTop.backgroundColor = kGetColor(246, 246, 246);
    [self.contentView addSubview:seperateViewTop];
    
    
    //发布内容视图
    [self.contentView addSubview:self.distributeContentView];

    //最新消息视图
    [self.contentView addSubview:self.latesteMessageRepyView];
    
    //底部cell分割视图
    UIView *bottomSeperateView = [UIView new];
    bottomSeperateView.backgroundColor = kGetColor(241, 243, 248);
    [self.contentView addSubview:bottomSeperateView];
    
    [avartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9);
        make.top.mas_equalTo(7);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];

    [self.avartImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(avartBgView);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];


    
    [self.redNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avartImgView.mas_top).with.offset(2);
        make.right.mas_equalTo(self.avartImgView.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(7, 7));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avartImgView.mas_right).with.offset(10);
        make.top.mas_equalTo(10);
    }];
    
    [self.fromWhereButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.nickNameLabel);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(40);
    }];

    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
    }];
    
    [seperateViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameLabel);
        make.top.mas_equalTo(self.fromWhereButton.mas_bottom).with.offset(10);
        make.right.mas_equalTo(-1);
        make.height.mas_equalTo(1);
    }];
    
    [self.distributeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(61);
        make.top.mas_equalTo(seperateViewTop.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(100);
    }];
//    self.latesteMessageRepyView.backgroundColor = [UIColor redColor];
    [self.latesteMessageRepyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.distributeContentView.mas_bottom);
        make.left.mas_equalTo(self.distributeContentView.mas_left).with.offset(3);
        make.right.mas_equalTo(self.distributeContentView.mas_right).with.offset(-3);
        make.height.mas_equalTo(50);
    }];
    
    
    [bottomSeperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    
    self.avartImgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.nickNameLabel.text = @"明天会更好";
    self.timeLabel.text = @"1分钟前";
    [self.fromWhereButton setTitle:@"朋友圈" forState:UIControlStateNormal];
}

-(void)setFoundModel:(FoundModel *)foundModel {

    _foundModel = foundModel;
    
    [self.avartImgView sd_setImageWithURL:[NSURL URLWithString:_foundModel.avartUrl] placeholderImage:IMAGE(@"default_head")];
    self.nickNameLabel.text = _foundModel.nickName;

    NSString *displayStr = nil;
    UIColor *displayColor = nil;
    //更新朋友圈或者附近多少米
    if ([_foundModel.fromWhereTypeStr isEqualToString:@"GEODISTANCE"]) {
        NSLog(@"---%@",_foundModel.fromRecentDistance);
        displayStr = [NSString stringWithFormat:@"附近%@",_foundModel.fromRecentDistance];
        displayColor = kGetColor(135, 193, 239);
        
    }else{
        displayStr = @"朋友圈";
        displayColor = kGetColor(236, 162, 221);

    }
    
    self.redNoteLabel.hidden = !_foundModel.hasUnreadMessage;
    self.fromWhereButton.backgroundColor = displayColor;
    [self.fromWhereButton setTitle:displayStr forState:UIControlStateNormal];
    CGSize whereButtonSize = [displayStr getSizeWithWidth:200 font:[UIFont customFontOfSize:10]];
    [self.fromWhereButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(whereButtonSize.width+10, 15));
    }];
    
    NSTimeInterval dateInterval = (NSTimeInterval)_foundModel.disstributTime.longLongValue;
    self.timeLabel.text = [Util getRelatedTimeByTimeInterval:dateInterval];
    
    //更新发现内容视图
    self.distributeContentView.distributeContentModel = _foundModel.personDistributeContentModel;
    [self.distributeContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_foundModel.personDistributeContentModel.contentHeight);
    }];
    
    
    //更新发现回复视图
    if (_foundModel.hasLatestMessage) {//有最新消息
        self.latesteMessageRepyView.repyLatestMessageModel = _foundModel.repyLatestMessageModel;
        self.latesteMessageRepyView.hidden = NO;
        [self.latesteMessageRepyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_foundModel.repyLatestMessageModel.totalSize.height);
        }];
    }else{
        self.latesteMessageRepyView.hidden = YES;
    }
    
}


-(DistributeContentView *)distributeContentView {

    if (!_distributeContentView) {
        _distributeContentView = [[DistributeContentView alloc] initWithFrame:CGRectZero];
    }

    return _distributeContentView;
}

-(LatesteMessageRepyView *)latesteMessageRepyView {

    if (!_latesteMessageRepyView) {
        _latesteMessageRepyView = [[LatesteMessageRepyView alloc] initWithFrame:CGRectZero];
        
    }
    return _latesteMessageRepyView;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
