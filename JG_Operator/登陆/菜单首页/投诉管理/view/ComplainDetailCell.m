//
//  ComplainDetailCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainDetailCell.h"

@interface ComplainDetailCell ()
- (IBAction)viewPhotoAction:(UIButton *)sender;



/**
 *  投诉状况
 */
@property (weak, nonatomic) IBOutlet UILabel *labelDisposeStatus;
/**
 *  投诉人手机
 */
@property (weak, nonatomic) IBOutlet UILabel *labelComplainPhone;
/**
 *  投诉人
 */
@property (weak, nonatomic) IBOutlet UILabel *labelComplainName;
/**
 *  投诉时间
 */
@property (weak, nonatomic) IBOutlet UILabel *labelComplainTime;

@end

@implementation ComplainDetailCell

- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    
    //            投诉人名字
    self.labelComplainName.text = [NSString stringWithFormat:@"%@",_model.nickname];
//    self.labelComplainName.text = [NSString stringWithFormat:@"%@",_model.name];
    self.labelComplainName.text = [NSString stringDiseposeNullWithStr:self.labelComplainName.text];
    //            投诉人联系电话
    self.labelComplainPhone.text = [NSString stringWithFormat:@"%@",_model.mobile];
    self.labelComplainPhone.text = [NSString stringDiseposeNullWithStr:self.labelComplainPhone.text];
    //            投诉时间
    self.labelComplainTime.text = [NSString stringWithFormat:@"%@",_model.addTime];
    self.labelComplainTime.text = [NSString stringDiseposeNullWithStr:self.labelComplainTime.text];
    //            1 处理中    3已完成
    //            投诉状况
    if ([_model.status isEqualToString:@"1"]) {
        self.labelDisposeStatus.text = @"处理中";
    }else{
        self.labelDisposeStatus.text = @"已完成";
    }
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)viewPhotoAction:(UIButton *)sender {
    JGLog(@"%@",NSStringFromClass([self class]));
    if (self.viewPhotoBlock) {
        self.viewPhotoBlock();
    }
}
@end
