//
//  ComplainServiceCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainServiceCell.h"
@interface ComplainServiceCell()
//服务图片
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewService;

/**
 *  服务名称
 */
@property (weak, nonatomic) IBOutlet UILabel *labelServiceName;
/**
 *  服务商家
 */
@property (weak, nonatomic) IBOutlet UILabel *labelServiceStoreName;
/**
 *  问题描述
 */
@property (weak, nonatomic) IBOutlet UILabel *labelProblemDescribe;

/**
 *  投诉内容
 */
@property (weak, nonatomic) IBOutlet UILabel *labelComplainDetail;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *labelServicePrice;


@end

@implementation ComplainServiceCell

- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    
    //            //服务名称
    self.labelServiceName.text = [NSString stringWithFormat:@"%@",_model.groupName];
    self.labelServiceName.text = [NSString stringDiseposeNullWithStr:self.labelServiceName.text];
    //            //服务商家
    self.labelServiceStoreName.text = [NSString stringWithFormat:@"%@",_model.storeName];
    self.labelServiceStoreName.text = [NSString stringDiseposeNullWithStr:self.labelServiceStoreName.text];
    //            //问题描述
    self.labelProblemDescribe.text = [NSString stringWithFormat:@"%@",_model.problemDesc];
    self.labelProblemDescribe.text = [NSString stringDiseposeNullWithStr:self.labelProblemDescribe.text];
    //            //投诉内容
    self.labelComplainDetail.text = [NSString stringWithFormat:@"%@",_model.fromUserContent];
    self.labelComplainDetail.text = [NSString stringDiseposeNullWithStr:self.labelComplainDetail.text];
    //            //服务价格
    self.labelServicePrice.text = [NSString stringWithFormat:@"%@",_model.price];
    self.labelServicePrice.text = [NSString stringDiseposeNullWithStr:self.labelServicePrice.text];
    
    
    //            //服务图片的url
    NSString *strServiceImageUrl = [NSString stringWithFormat:@"%@",_model.groupPhoto];
    
    NSURL *url = [NSURL URLWithString:strServiceImageUrl];
    [self.ImageViewService sd_setImageWithURL:url placeholderImage:nil];
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
