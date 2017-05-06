//
//  PhysicalReportDetailCell.m
//  jingGang
//
//  Created by HanZhongchou on 15/10/27.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "PhysicalReportDetailCell.h"
#import "PublicInfo.h"
@interface PhysicalReportDetailCell()
@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;//编辑按钮
/**
 *  编辑按钮的宽度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthEditButton;


@end

@implementation PhysicalReportDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.viewBg.layer.cornerRadius = 3;
    self.viewBg.clipsToBounds = YES;
    self.viewBg.layer.masksToBounds = YES;
    

}
- (void)setStrStatus:(NSString *)strStatus
{
    _strStatus = strStatus;
    //体检报告状态：1未提交、2待处理、3已处理
    //    status;1、3状态显示编辑按钮 设置编辑View背景色，状态2则 隐藏编辑按钮，并且背景色清除
    
    if ([self.strStatus isEqualToString:@"1"] || [self.strStatus isEqualToString:@"3"]) {
//        self.buttonEdit.hidden = NO;
        self.widthEditButton.constant = 45.0;
        self.viewBg.backgroundColor = rgb(228, 228, 229, 1);
    }else{
//        self.buttonEdit.hidden = YES;
        self.widthEditButton.constant = 0.0;
        self.viewBg.backgroundColor = [UIColor clearColor];
    }
}

- (IBAction)EditButtonClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(editButtonClickWithPhysicalReportDetailCell:indexPath:)]){
        [self.delegate editButtonClickWithPhysicalReportDetailCell:self indexPath:self.indexPath];
    }
}
- (void)setModel:(PhysicalReportDetailModel *)model
{
    _model = model;
    self.labelCheckDetailTitle.text = [NSString stringWithFormat:@"%@",_model.physicalName];
    
    
    //0数值型（录入）、1选项型（阴、阳值）
    if (_model.type == 0) {
       self.labelDetailValue.text = [NSString stringWithFormat:@"%@",_model.referenceValue];
    }else{
        NSString *str = [NSString stringWithFormat:@"%@",_model.positive];
//        阴阳参考值0阴1阳阳性
        if ([str isEqualToString:@"0"]) {
            self.labelDetailValue.text = @"阴";
        }else{
            self.labelDetailValue.text = @"阳";
        }
        
    }
    if ([_model.result integerValue] == 1) {
        self.labelDetailValue.textColor = [UIColor redColor];
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    // Configure the view for the selected state
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

@end
