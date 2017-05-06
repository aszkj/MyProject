//
//  ComplainCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/27.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainCell.h"
#import "ComplainModel.h"

@interface ComplainCell()

/**
 *  投诉人lab
 */
@property (strong,nonatomic) UILabel *complainerLab;

/**
 *  被投诉商户lab
 */
@property (strong,nonatomic) UILabel *complainedMerchantLab;

/**
 *  投诉时间lab
 */
@property (strong,nonatomic) UILabel *complainTimeLab;

/**
 *  处理投诉的按钮
 */
//@property (strong,nonatomic) UIButton *handleButton;
/**
 *  处理投诉的label
 */
@property (strong,nonatomic)  UILabel *labelHandle;


@end

@implementation ComplainCell

// 投诉人lab
- (UILabel *)complainerLab {
    if (!_complainerLab) {
        _complainerLab = [[UILabel alloc] init];
        _complainerLab.textColor = [UIColor colorFromHexRGB:@"#666666"];
        _complainerLab.font = [UIFont systemFontOfSize:13.5];
        _complainerLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_complainerLab];
    }
    return _complainerLab;
}

// 被投诉商户lab
- (UILabel *)complainedMerchantLab {
    if (!_complainedMerchantLab) {
        _complainedMerchantLab = [[UILabel alloc] init];
        _complainedMerchantLab.textColor = [UIColor colorFromHexRGB:@"#666666"];
        _complainedMerchantLab.font = [UIFont systemFontOfSize:13.5];
        _complainedMerchantLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_complainedMerchantLab];
    }
    return _complainedMerchantLab;
}

// 投诉时间lab
- (UILabel *)complainTimeLab {
    if (!_complainTimeLab) {
        _complainTimeLab = [[UILabel alloc] init];
        _complainTimeLab.textColor = [UIColor colorFromHexRGB:@"#666666"];
        _complainTimeLab.font = [UIFont systemFontOfSize:14.5f];
        _complainTimeLab.textAlignment = NSTextAlignmentCenter;
        _complainTimeLab.numberOfLines = 0;
        _complainTimeLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_complainTimeLab];
    }
    return _complainTimeLab;
}

//处理投诉的label
- (UILabel *)labelHandle {
    if (!_labelHandle) {
        _labelHandle = [[UILabel alloc]init];
        _labelHandle.textColor = [UIColor whiteColor];
        _labelHandle.layer.cornerRadius = 5.0f;
        _labelHandle.clipsToBounds = YES;
        _labelHandle.font = [UIFont systemFontOfSize:11.0f];
        _labelHandle.backgroundColor = status_color;
        _labelHandle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_labelHandle];
    }
    return _labelHandle;
}
// 处理投诉的按钮
//- (UIButton *)handleButton {
//    if (!_handleButton) {
//        _handleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_handleButton setTintColor:[UIColor colorFromHexRGB:@"#FFFFFF"]];
//        _handleButton.layer.cornerRadius = 5.0f;
//        _handleButton.clipsToBounds = YES;
//        _handleButton.titleLabel.font = [UIFont systemFontOfSize:11.0f];
//        [_handleButton setBackgroundColor:status_color];
//        [self.contentView addSubview:_handleButton];
//    }
//    return _handleButton;
//}

- (void)setCompModel:(ComplainModel *)compModel {
    _compModel = compModel;
    self.complainerLab.text = compModel.nickname;
    self.complainedMerchantLab.text = compModel.storeName;
    self.complainTimeLab.text = compModel.addTime;
    
    
    
//    [self.handleButton addTarget:self action:@selector(handleButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setIsHandled:(BOOL)isHandled
{
    _isHandled = isHandled;
    if (_isHandled) {
        // 已完成的投诉
        self.labelHandle.text = @"处理";
        
    }else{
        // 待处理投诉
        self.labelHandle.text = @"查看";
    }
    self.labelHandle.font = [UIFont systemFontOfSize:14];
    
}

// 监听按钮点击事件
//- (void)handleButtonClick {
//    JGLog(@"Click");
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = kScreenWidth / 4;
    CGFloat height = 26.0f;
    
    // 投诉人lab
    self.complainerLab.x = 0;
    self.complainerLab.height = height;
    self.complainerLab.y = (self.height - self.complainerLab.height)/2;
    self.complainerLab.width = width - 10;
    
    // 被投诉商户lab
    self.complainedMerchantLab.x = width - 10;
    self.complainedMerchantLab.height = self.complainerLab.height;
    self.complainedMerchantLab.y = self.complainerLab.y;
    self.complainedMerchantLab.width = width + 10;

    // 投诉时间lab
    self.complainTimeLab.x = width * 2;
    self.complainTimeLab.y = 4;
    self.complainTimeLab.height = self.contentView.height - self.complainTimeLab.y * 2;
    self.complainTimeLab.width = width;
    
    // 处理投诉lab
//    CGFloat marin = (width - 50) / 2;
//    self.labelHandle.x = width * 3 + marin;
    self.labelHandle.x = kScreenWidth - 15 - 50;
    self.labelHandle.height = self.complainerLab.height;
    self.labelHandle.y = self.complainerLab.y;
    self.labelHandle.width = 50;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
