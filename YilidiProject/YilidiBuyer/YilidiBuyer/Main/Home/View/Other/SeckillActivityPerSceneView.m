//
//  SeckillActivityPerSceneView.m
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "SeckillActivityPerSceneView.h"
#import "ProjectStandardUIDefineConst.h"
#import <Masonry/Masonry.h>

@interface SeckillActivityPerSceneView()

@property (nonatomic, strong)UILabel *activityBeginTimeLabel;

@property (nonatomic, strong)UILabel *activityStatusLabel;

@end

@implementation SeckillActivityPerSceneView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setUpUi];
    }
    return self;
}

- (void)_setUpUi {
    self.activityBeginTimeLabel = [UILabel new];
    [self addSubview:self.activityBeginTimeLabel];
    self.activityBeginTimeLabel.font = kSystemFontSize(14.0);
    self.activityBeginTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.activityBeginTimeLabel.textColor = [UIColor whiteColor];
    [self.activityBeginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.height.mas_equalTo(20);
        make.left.right.mas_equalTo(self);
    }];
    
    self.activityStatusLabel = [UILabel new];
    [self addSubview:self.activityStatusLabel];
    self.activityStatusLabel.font = kSystemFontSize(14.0);
    self.activityStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.activityStatusLabel.textColor = [UIColor whiteColor];
    [self.activityStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.activityBeginTimeLabel.mas_bottom).with.offset(-3);
        make.height.mas_equalTo(20);
        make.left.right.mas_equalTo(self);
    }];
}

- (void)_configureUi {
//    NSString *activityBeginDisplayTime = [self.seckillActivityModel.activityBeginTime substringWithRange:NSMakeRange(self.seckillActivityModel.activityBeginTime.length-8, 5)];
    self.activityBeginTimeLabel.text = jFormat(@"%@",self.seckillActivityModel.activityName);
    self.activityStatusLabel.text = jFormat(@"%@",self.seckillActivityModel.activityStatusName);
}

- (void)_configureUiWhenSetSelectDeselected {
    UIColor *titleColor = nil;
    titleColor = self.activitySelected ? [UIColor whiteColor] : KCOLOR_NOMAL_TEXT;
    self.activityBeginTimeLabel.textColor = self.activityStatusLabel.textColor = titleColor;
}

- (void)setSeckillActivityModel:(SeckillActivityModel *)seckillActivityModel {
    _seckillActivityModel = seckillActivityModel;
    [self _configureUi];
}


- (void)setActivitySelected:(BOOL)activitySelected {
    _activitySelected = activitySelected;
    [self _configureUiWhenSetSelectDeselected];
}

@end
