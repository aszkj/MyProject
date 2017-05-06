//
//  AcceptOrderDetailView.m
//  WeimiSP
//
//  Created by thinker on 16/2/24.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrderDetailView.h"

@interface AcceptOrderDetailView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *xiangshang;


@end

@implementation AcceptOrderDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}


#pragma mark - 实例化UI
- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(20);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.lessThanOrEqualTo(@(self.frame.size.height - 150));
    }];

}

#pragma mark - getter

-(UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
        _topView.backgroundColor = UIColorFromRGB(0Xfc5815);
        
        [_topView addSubview:self.shangmen];
        [_shangmen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.centerX.equalTo(@0);
        }];
        [_topView addSubview:self.dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(_shangmen.mas_bottom).with.offset(8);
        }];
    }
    return _topView;
}
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc ]init];
        _dateLabel.textColor = UIColorFromRGB(0Xffffff);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
//        _dateLabel.text = @"2016年2月23日 18:30";
        _dateLabel.font = [UIFont CustomFontOfSize:12];
    }
    return _dateLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc ]init];
//        _contentLabel.text = @"     由于公司在南山区搞线下服务2日免费活动今天下午福田区的外派服务3点钟南山区支持，系诶些各位的配合，如有空的人可以来玩呀，热烈欢迎！";
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont CustomFontOfSize:15];
        _contentLabel.textColor = UIColorFromRGB(0X000000);
    }
    return _contentLabel;
}

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc ]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
        _bottomView.backgroundColor = UIColorFromRGB(0Xf0f0f0);
        
        [_bottomView addSubview:self.xiangshang];
        [_xiangshang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-10);
            make.centerX.equalTo(@0);
        }];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AcceptOrde_top"]];
        [_bottomView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_xiangshang.mas_top).with.offset(0);
            make.centerX.equalTo(@0);
        }];
    }
    return _bottomView;
}

-(UILabel *)shangmen
{
    if (!_shangmen) {
        _shangmen = [[UILabel alloc ]init];
        _shangmen.font = [UIFont boldSystemFontOfSize:20];
        _shangmen.textAlignment = NSTextAlignmentCenter;
        _shangmen.text = @"上门服务";
        _shangmen.textColor = UIColorFromRGB(0Xffffff);
    }
    return _shangmen;
}

-(UILabel *)xiangshang
{
    if (!_xiangshang) {
        _xiangshang = [[UILabel alloc] init];
        _xiangshang.text = @"向上滑动查看地图";
        _xiangshang.textAlignment = NSTextAlignmentCenter;
        _xiangshang.textColor = UIColorFromRGB(0X999999);
    }
    return _xiangshang;
}

@end
