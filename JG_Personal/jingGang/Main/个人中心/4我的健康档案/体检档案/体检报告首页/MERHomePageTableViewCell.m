//
//  MERHomePageTableViewCell.m
//  jingGang
//
//  Created by ray on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "MERHomePageTableViewCell.h"
#import "UIButton+TQEasyIcon.h"
#import "PublicInfo.h"
#import "Masonry.h"

@interface MERHomePageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *reportNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportTimeLabel;

@end

@implementation MERHomePageTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content

- (void)setEntity:(MERHomePageEntity *)entity {


    self.reportNameLabel.text = entity.resultname;
    self.reportTimeLabel.attributedText = entity.reportTimeAttributedString;
    
    NSString *statusTitle = @"";
    NSString *imageName = @"MER_weitijiao";
    NSInteger reportStatus = [entity.status integerValue];
    if (reportStatus == ReportStatusUncommit) {
        statusTitle = @"未提交";
        imageName = @"MER_weitijiao";
    } else if (reportStatus == ReportStatusCommit) {
        statusTitle = @"已提交";
        imageName = @"MER_iconfont-queren1---Assistor";
    } else if (reportStatus == ReportStatusHandled) {
        statusTitle = @"已处理";
        imageName = @"MER_weichuli";
    }
    [self.statusButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.statusButton setTitle:statusTitle forState:UIControlStateNormal];

}

#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    UIView *bottomLine = [self colorView:background_Color];
    [superView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
}

- (UIView *)colorView:(UIColor *)color {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

@end
