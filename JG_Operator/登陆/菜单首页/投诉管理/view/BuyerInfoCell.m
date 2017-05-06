//
//  BuyerCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "BuyerInfoCell.h"

@interface BuyerInfoCell ()
/**
 *  买家名称
 */
@property (weak, nonatomic) IBOutlet UILabel *labelPayName;

@end

@implementation BuyerInfoCell

- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    //买家名称

    self.labelPayName.text = [NSString stringWithFormat:@"%@",_model.nickname];
    self.labelPayName.text = [NSString stringDiseposeNullWithStr:self.labelPayName.text];
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

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
