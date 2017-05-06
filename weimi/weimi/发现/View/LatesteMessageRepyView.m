//
//  LatesteMessageRepyView.m
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "LatesteMessageRepyView.h"
#import "RepyLatestMessageModel.h"

@interface LatesteMessageRepyView()

//文字背景imgView
@property (nonatomic,strong)UIImageView *repyContentBgImgView;
//文字
@property (nonatomic,strong)UILabel *latestMessageLabel;
//最新消息语音
@property (nonatomic,strong)UIButton *soundButton;
//最新消息图片
@property (nonatomic,strong)UIImageView *repyImgView;

@end

@implementation LatesteMessageRepyView

-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self _createUI];
    }
    return self;
}


-(void)setRepyLatestMessageModel:(RepyLatestMessageModel *)repyLatestMessageModel {
    
    _repyLatestMessageModel = repyLatestMessageModel;
    self.latestMessageLabel.attributedText = _repyLatestMessageModel.showStr;
    
    //先更新图片大小
    NSLog(@"更新图片大小宽度 %.2f",_repyLatestMessageModel.contentSize.width);
    [self.repyContentBgImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGSize updateSize = CGSizeMake(_repyLatestMessageModel.contentSize.width+10, _repyLatestMessageModel.contentSize.height+15);
        make.size.mas_equalTo(updateSize);
    }];
    [self.latestMessageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_repyLatestMessageModel.contentSize.width+2);
    }];
    [self.repyContentBgImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.latestMessageLabel.mas_left).with.offset(-5);
        make.top.mas_equalTo(self.latestMessageLabel.mas_top).with.offset(-11);
        make.right.mas_equalTo(self.latestMessageLabel.mas_right).with.offset(3);
        make.bottom.mas_equalTo(self.latestMessageLabel.mas_bottom).with.offset(6);
    }];
    //重新赋值拉伸图片
    UIImage *originalImage = IMAGE(@"发现回答页面-灰色背景");
    self.repyContentBgImgView.image = [originalImage stretchableImageWithLeftCapWidth:30 topCapHeight:10];
    
}

- (void)_createUI {
    
    [self addSubview:self.repyContentBgImgView];
    [self addSubview:self.latestMessageLabel];

    
    
    [self.repyContentBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
        //宽高
        make.size.mas_equalTo(CGSizeMake(45, 34));
    }];
    
//    self.latestMessageLabel.backgroundColor = [UIColor yellowColor];
    [self.latestMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(5);

    }];
    
}


-(UIImageView *)repyContentBgImgView {
    
    if (!_repyContentBgImgView) {
        _repyContentBgImgView = [UIImageView new];
        _repyContentBgImgView.backgroundColor = [UIColor clearColor];
        _repyContentBgImgView.image = IMAGE(@"发现回答页面-灰色背景");
        
    }
    
    return _repyContentBgImgView;
}


-(UILabel *)latestMessageLabel {

    if (!_latestMessageLabel) {
     
        _latestMessageLabel = [UILabel new];
        _latestMessageLabel.font = [UIFont customFontOfSize:14];
        _latestMessageLabel.backgroundColor = [UIColor clearColor];
        _latestMessageLabel.textColor = [UIColor blackColor];
        _latestMessageLabel.numberOfLines = 0;
        
    }
    return _latestMessageLabel;

}


@end
