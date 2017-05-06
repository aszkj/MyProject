//
//  WeimiMainTableViewCell.m
//  weimi
//
//  Created by ray on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WeimiMainTableViewCell.h"
#import "NIBadgeView.h"
#import "UIView+Design.h"
#import "YYText.h"
#import "NSDate+Addition.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FeedLocalModel.h"
#import "NSString+Teshuzifu.h"

@interface WeimiMainTableViewCell ()

@property (nonatomic) YYLabel *timeLabel;
@property (nonatomic) NIBadgeView *comfromView;
@property (nonatomic) UIView *lineView;
@property (nonatomic) UIView *subjectContentView;
@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) UIImageView *contentImage;
@property (nonatomic) UIImageView *voiceImage;

@property (nonatomic, strong) MASConstraint *bottomConstraint;

@end

@implementation WeimiMainTableViewCell

#define rightSpace 8.0
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
    [_subjectContentView setNeedsLayout];
    [_subjectContentView layoutIfNeeded];
    size = _subjectContentView.frame.size;
    size.height = _subjectContentView.maxY;
    return size;
}

#pragma mark - set UI content

- (void)setNickNameWith:(NSString *)uid
{
    WEAK_SELF;
    [WEMESimpleUser getWithUID:uid completeBlock:^(WEMESimpleUser *user) {
        [weak_self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.avatar]  placeholderImage:IMAGE(@"default_head")];
        NSAttributedString *result = [[user.nickname stringByAppendingString:@" \n "] bos_makeString:^(BOStringMaker *make) {
            make.first.substring(user.nickname, ^{
                make.foregroundColor(UIColorFromRGB(0x333333));
                make.font([UIFont customFontOfSize:15.0]);
            });
        }];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithAttributedString:result];
        [attriString appendAttributedString:weak_self.titleLabel.attributedText];
        [weak_self.titleLabel setAttributedText:attriString];
        
    }];
}

- (void)setSubject:(FeedLocalModel *)subject
{
    self.comfromView.hidden = YES;
    self.subjectContentView.hidden = NO;
    self.hasReadLayer.hidden = YES;
    [_avatarImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(avatarWidth+10, avatarWidth+10));
    }];
    _avatarImage.layer.cornerRadius = (avatarWidth+10)/2.0;
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image = IMAGE(@"group_Main");
    NSString *comform = @" 附近的人";
    if ([subject.toLbs boolValue]) {
        comform = @" 附近的人";
        attachment.image = IMAGE(@"locate_Main");
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    NSAttributedString *result = [comform bos_makeString:^(BOStringMaker *make) {
        make.first.substring(comform, ^{
            make.foregroundColor(contentTextColor);
            make.font([UIFont customFontOfSize:10.0]);
        });
    }];
    [string appendAttributedString:result];
    self.titleLabel.attributedText = string;
    [self setNickNameWith:subject.uid];
    
    NSString *timeString = [Util getRelatedTimeByTimeInterval:subject.timestamp.longLongValue];
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSMutableAttributedString *attachmentBottom = nil;
    
    // 嵌入 UIImage
    UIImage *image = [UIImage imageNamed:@"bottom_Main"];
    attachmentBottom = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeRight attachmentSize:CGSizeMake(13, 8) alignToFont:_timeLabel.font alignment:YYTextVerticalAlignmentCenter];
    [text yy_appendString:timeString];
    [text appendAttributedString: attachmentBottom];
    text.yy_color = _timeLabel.textColor;
    [text yy_setTextHighlightRange:NSMakeRange(0, text.length)
                             color:_timeLabel.textColor
                   backgroundColor:[UIColor grayColor]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             [self deleteAction];
                         }];
    _timeLabel.attributedText = text;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    _contentLabel.text = subject.title;
    
    if ([subject.type isEqualToString:@"TEXT"]) {
    
        [self setFeedType:WeimiMessageTypeText];
    } else if ([subject.type isEqualToString:@"IMAGE"]){
        
        [_contentImage sd_setImageWithURL:TwiceImgUrl(subject.image_url, contentImageWidth, contentImageWidth)  placeholderImage:IMAGE(@"noData_Main")];
        [self setFeedType:WeimiMessageTypeImage];
    } else if ([subject.type isEqualToString:@"VOICE"]) {
        _voiceImage.hidden = NO;
        [self setFeedType:WeimiMessageTypeVoice];
    }

    UIView *superview = self.contentView;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview).with.offset(-80);
    }];
}

- (void)setReplay:(WEMEReply *)replay
{
    [self setlayoutWithType:0];
    self.comfromView.hidden = NO;
    self.subjectContentView.hidden = YES;
    self.hasReadLayer.hidden = replay.readed.boolValue;
    [_avatarImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(avatarWidth, avatarWidth));
    }];
    _avatarImage.layer.cornerRadius = avatarWidth/2.0;
    
    NSString *timeString = [NSDate dateWithTimeIntervalSince1970:replay.timestamp.longLongValue/1000].description;
    NSRange range = [timeString rangeOfString:@" "];
    if (range.length > 0) {
        timeString = [timeString substringToIndex:range.location];
    }
    _timeLabel.text = timeString;

    NSString *secondLine = @"";
//    if ([replay.snapshot.content.type isEqualToString:@"VOICE"]) {
//        secondLine = @"回复了一条语音";
//    } else if ([replay.snapshot.content.type isEqualToString:@"IMAGE"]) {
//        secondLine = @"回复了一张图片";
//    } else if (replay.snapshot.content.text) secondLine = replay.snapshot.content.text;
    NSString *titletext = secondLine;
    NSAttributedString *result = [titletext bos_makeString:^(BOStringMaker *make) {
        make.first.substring(secondLine, ^{
            make.foregroundColor(contentTextColor);
            make.font([UIFont customFontOfSize:10.0]);
        });
    }];
    _titleLabel.attributedText = result;
    [self setNickNameWith:replay.uid];
    
    NSString *comfrom = @"朋友圈";
    if (!IsEmpty(replay.broadcast.relationship.text)) {
        comfrom = [NSString stringWithFormat:@"附近%@",replay.broadcast.relationship.text];
        _comfromView.tintColor = UIColorFromRGB(0x9fc6ed);
    }
    _comfromView.text = comfrom;
    if (_comfromView.constraints.count == 0) {
        [_comfromView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeLabel.mas_bottom).with.offset(4);
            make.right.equalTo(_timeLabel);
        }];
    }
    [_comfromView sizeToFit];

    UIView *superview = self.contentView;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview).with.offset(-(rightSpace + 5 + _comfromView.width));
    }];
}

- (void)setEntity:(id)entity
{
    if ([entity isKindOfClass:[FeedLocalModel class]]) {
        [self setSubject:entity];
    } else if ([entity isKindOfClass:[WEMEReply class]]) {
        [self setReplay:entity];
    }
}


#pragma mark - event response

/**
 *  点击放大图片
 *
 *  @param tap 手势view
 */
- (void)magnifyImage:(UITapGestureRecognizer*)tap
{
    // 1.封装图片数据
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    MJPhoto *photo = [[MJPhoto alloc] init];
    NSString *urlString = [self.contentImage.sd_imageURL absoluteString];
    //获取原图
    urlString = [urlString substringToIndex:[urlString rangeOfString:@"_"].location];
    photo.url = [NSURL URLWithString:urlString]; // 图片路径
    photo.srcImageView = (UIImageView *)tap.view; // 来源于哪个UIImageView
    [photos addObject:photo];
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


- (void)deleteAction
{
    if (_deleteBlock) {
        _deleteBlock();
    }
}

#pragma mark - set UI init

- (void)creatUI
{

    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.comfromView];
    [self.contentView addSubview:self.subjectContentView];
    [self.contentView.layer addSublayer:self.hasReadLayer];
    
    _lineView = [XKO_CreateUIViewHelper createUIViewWithBackgroundColor:[[UITableView appearance] separatorColor]];
    [self.contentView addSubview:_lineView];
    
    UIView *superview = self.contentView;
    [_avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(avatarWidth, avatarWidth));
        make.top.equalTo(superview).with.offset(13);
        make.bottom.greaterThanOrEqualTo(superview).with.offset(-bottomSpace).priority(MASLayoutPriorityDefaultMedium);
        make.left.equalTo(superview).with.offset(10);
    }];
    _hasReadLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10+avatarWidth-8, 13, 8, 8) cornerRadius:UIRectCornerAllCorners].CGPath;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImage);
//        make.bottom.equalTo(_avatarImage);
        make.left.equalTo(_avatarImage.mas_right).with.offset(12);
        make.right.equalTo(superview).with.offset(-80);

    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview).with.offset(-rightSpace);
        make.top.equalTo(_titleLabel);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.left.equalTo(superview).with.offset(15);
        make.right.equalTo(superview);
    }];
 
    [_subjectContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImage.mas_right).with.offset(12);
        make.top.equalTo(_avatarImage.mas_bottom);
        make.right.equalTo(superview);
        make.height.equalTo(@(bottomSpace));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subjectContentView).with.offset(12);
        make.left.equalTo(_avatarImage.mas_right).with.offset(12);
        make.right.equalTo(superview).with.offset(-(rightSpace + 4));
    }];
    
    [_contentImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(contentImageWidth, contentImageWidth)).priority(MASLayoutPriorityRequired);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(18);
        make.left.equalTo(_subjectContentView);
    }];
    
    [_voiceImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_subjectContentView);
        make.size.mas_equalTo(_voiceImage.image.size);
    }];
}

- (void)setFeedType:(WeimiMessageType)feedType {
    if (feedType == _feedType && feedType == 0) return;
    _feedType = feedType;
    [self setlayoutWithType:feedType];
}

- (void)setlayoutWithType:(WeimiMessageType)type {
    if (type != 0) {
        UIView * lineView = [XKO_CreateUIViewHelper createUIViewWithBackgroundColor:[[UITableView appearance] separatorColor]];
        [_subjectContentView addSubview:lineView];
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_subjectContentView);
            make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
            make.left.equalTo(_subjectContentView);
            make.right.equalTo(_subjectContentView);
        }];
    }
        
//    UIView *superview = self.contentView;
    [_subjectContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (type == WeimiMessageTypeText) {
            [_contentLabel setNeedsLayout];
            [_contentLabel layoutIfNeeded];
            make.height.equalTo(@(_contentLabel.maxY + bottomSpace)).priority(MASLayoutPriorityRequired);
            make.height.equalTo(@(_contentLabel.maxY + bottomSpace)).priority(MASLayoutPriorityRequired);

            
        } else if (type == WeimiMessageTypeImage) {
            [_contentImage setNeedsLayout];
            [_contentImage layoutIfNeeded];
            make.height.equalTo(@(_contentImage.maxY + bottomSpace)).priority(MASLayoutPriorityRequired);
            
        } else if (type == WeimiMessageTypeVoice) {
            [_voiceImage setNeedsLayout];
            [_voiceImage layoutIfNeeded];
            make.height.equalTo(@(_voiceImage.maxY + bottomSpace));

        } else {
            make.height.equalTo(@(bottomSpace));
        }
    }];
    
}

- (NIBadgeView *)comfromView {
    if (_comfromView == nil) {
        _comfromView = [[NIBadgeView alloc] initWithFrame:CGRectZero];
        _comfromView.backgroundColor = [UIColor whiteColor];
        _comfromView.tintColor = UIColorFromRGB(0xe2a6da);
        _comfromView.textColor = [UIColor whiteColor];
        _comfromView.font = KSmallFont;
    }
    return _comfromView;
}

- (YYLabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [YYLabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _timeLabel.textColor = UIColorFromRGB(0xb6b6b6);
        _timeLabel.font = KSmallFont;
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont customFontOfSize:13.0];
    }
    return _titleLabel;
}

- (UIImageView *)avatarImage {
    if (_avatarImage == nil) {
        _avatarImage = [[UIImageView alloc] initWithImage:IMAGE(@"登陆_07")];
        _avatarImage.layer.cornerRadius = avatarWidth/2.0;
        _avatarImage.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _avatarImage.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        _avatarImage.layer.masksToBounds = YES;
    }
    return _avatarImage;
}

- (CAShapeLayer *)hasReadLayer {
    if (_hasReadLayer != nil) { return _hasReadLayer; }
    _hasReadLayer = [CAShapeLayer layer];
    _hasReadLayer.hidden = YES;
    _hasReadLayer.fillColor = [UIColor redColor].CGColor;
    return _hasReadLayer;
}

- (UIView *)subjectContentView {
    if (_subjectContentView == nil) {
        _subjectContentView = [UIView new];
        _subjectContentView.layer.masksToBounds = YES;
        
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = contentTextColor;
        _contentLabel.preferredMaxLayoutWidth = 230;
        [_subjectContentView addSubview:_contentLabel];
        
        _contentImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _contentImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
        [_contentImage addGestureRecognizer:singleTap];
        [_subjectContentView addSubview:_contentImage];
        
        _voiceImage = [[UIImageView alloc] initWithImage:IMAGE(@"voice_main")];
        _voiceImage.frame = CGRectZero;
        _voiceImage.hidden = YES;
        [_subjectContentView addSubview:_voiceImage];
        
    }
    return _subjectContentView;
}

@end

@implementation WeimiMainFeedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}


- (void)setReplay:(WEMEReply *)replay
{
    [self setlayoutWithType:0];
    self.comfromView.hidden = NO;
    self.subjectContentView.hidden = YES;
    self.hasReadLayer.hidden = replay.readed.boolValue;
    [self.avatarImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(avatarWidth, avatarWidth));
    }];
    self.avatarImage.layer.cornerRadius = avatarWidth/2.0;
    
    NSString *timeString = [NSDate dateWithTimeIntervalSince1970:replay.timestamp.longLongValue/1000].description;
    NSRange range = [timeString rangeOfString:@" "];
    if (range.length > 0) {
        timeString = [timeString substringToIndex:range.location];
    }
    self.timeLabel.text = timeString;
    
    NSString *secondLine = @"";
//    if ([replay.snapshot.content.type isEqualToString:@"VOICE"]) {
//        secondLine = @"回复了一条语音";
//    } else if ([replay.snapshot.content.type isEqualToString:@"IMAGE"]) {
//        secondLine = @"回复了一张图片";
//    } else if (replay.snapshot.content.text) secondLine = replay.snapshot.content.text;
    NSString *titletext = secondLine;
    NSAttributedString *result = [titletext bos_makeString:^(BOStringMaker *make) {
        make.first.substring(secondLine, ^{
            make.foregroundColor(contentTextColor);
            make.font([UIFont customFontOfSize:10.0]);
        });
    }];
    self.titleLabel.attributedText = result;
    [self setNickNameWith:replay.uid];
    
    NSString *comfrom = @"朋友圈";
    if (!IsEmpty(replay.broadcast.relationship.text)) {
        comfrom = [NSString stringWithFormat:@"附近%@",replay.broadcast.relationship.text];
        self.comfromView.tintColor = UIColorFromRGB(0x9fc6ed);
    }
    self.comfromView.text = comfrom;
    [self.comfromView sizeToFit];
    if (self.comfromView.constraints.count == 0) {
        [self.comfromView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).with.offset(4);
            make.right.equalTo(self.timeLabel);
        }];
    }
}

@end

