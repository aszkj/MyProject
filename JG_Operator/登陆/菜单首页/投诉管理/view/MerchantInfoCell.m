//
//  MerchantInfoCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantInfoCell.h"


@interface MerchantInfoCell ()

/**
 *  商户名称
 */
@property (weak, nonatomic) IBOutlet UILabel *labelStoreName;
/**
 *  商户电话
 */
@property (weak, nonatomic) IBOutlet UILabel *labelStorePhone;
/**
 *  商户详细地址
 */
@property (weak, nonatomic) IBOutlet UILabel *labelStoreDetailAddress;
/**
 *  商户所在地区
 */
@property (weak, nonatomic) IBOutlet UILabel *labelStoreArea;

@end

@implementation MerchantInfoCell


- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    
    //商户名
    self.labelStoreName.text = [NSString stringWithFormat:@"%@",_model.storeName];
    self.labelStoreName.text = [NSString stringDiseposeNullWithStr:self.labelStoreName.text];
    
    //商户联系电话
    self.labelStorePhone.text = [NSString stringWithFormat:@"%@",_model.storeTelephone];
    self.labelStorePhone.text = [NSString stringDiseposeNullWithStr:self.labelStorePhone.text];

    //商户地址
    self.labelStoreDetailAddress.text = [NSString stringWithFormat:@"%@",_model.storeAddress];
    self.labelStoreDetailAddress.text = [NSString stringDiseposeNullWithStr:self.labelStoreDetailAddress.text];
    //商户所在地区
    self.labelStoreArea.text = [NSString stringWithFormat:@"%@",_model.areaText];
    self.labelStoreArea.text = [NSString stringDiseposeNullWithStr:self.labelStoreArea.text];
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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
