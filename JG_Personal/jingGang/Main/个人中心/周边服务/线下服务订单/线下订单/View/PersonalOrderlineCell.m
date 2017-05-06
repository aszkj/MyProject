//
//  PersonalOrderlineCell.m
//  jingGang
//
//  Created by dengxf on 15/11/11.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "PersonalOrderlineCell.h"
#import "PersonalOrderlineModel.h"
#import "GlobeObject.h"
#import "Util.h"
@implementation PersonalOrderlineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    
    return self;
}

+ (instancetype)personalOrderCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"PersonalOrderlineCell";
    PersonalOrderlineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PersonalOrderlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fitToCellWithConstrain];
}

- (void)fitToCellWithConstrain {
    NSString *mobileType = [Util accodingToScreenSizeGetMobileType];
    if ([mobileType isEqualToString:kApMobile4s] || [mobileType isEqualToString:kApMobile5s]) {
        [self makeConsConstant:10.0];
        self.orderIdConstraint.constant = 10;
        self.storeNameWidthConstrain.constant = 100;
    }else if ([mobileType isEqualToString:kApMobile6s]) {
        [self makeConsConstant:60];
        self.orderIdConstraint.constant = 40;
        self.storeNameWidthConstrain.constant = 120;
    }else if ([mobileType isEqualToString:kApMobile6plus]) {
        [self makeConsConstant:85];
        self.orderIdConstraint.constant = 65;
        self.storeNameWidthConstrain.constant = 120;
    }
}

- (void)makeConsConstant:(CGFloat)constant {
    self.addTimeConstraint.constant = constant;
    self.orderStutasConstraint.constant = constant;
    self.mobileConstraint.constant = constant;
}



-(void)setOrderlineModel:(PersonalOrderlineModel *)orderlineModel {
    self.storeNameLab.text = [NSString stringWithFormat:@"服务:%@",orderlineModel.storeName];
    
    NSMutableAttributedString *orderIdMutAttriString = [self frontText:@"订单编号: " frontAttri:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor blackColor]} appendText:orderlineModel.orderId appendAttri:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.orderIdLab.attributedText = orderIdMutAttriString;
    
    
    self.localGroupNameLab.text = [NSString stringWithFormat:@"商户: %@",orderlineModel.localGroupName];

    NSString *addTimeString = [NSString stringWithFormat:@"%@",orderlineModel.addTime];
    NSArray *addTimeArray = [addTimeString componentsSeparatedByString:@" "];
    if (addTimeArray.count) {
        addTimeString = [addTimeArray firstObject];
    }else
        addTimeString = @"";
    
    self.addTimeLab.text = [NSString stringWithFormat:@"下单时间: %@",addTimeString];
    
    NSMutableAttributedString *totalPriceMutAttriString = [self frontText:@"消费金额: " frontAttri:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor blackColor]} appendText:[NSString stringWithFormat:@"￥%.2f",orderlineModel.totalPrice] appendAttri:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName : status_color}];
    self.totalPriceLab.attributedText = totalPriceMutAttriString;
    
    
    self.orderStatusLab.text = [NSString stringWithFormat:@"消费状态: %@",[self orderStatusStringWithOrderStatus:orderlineModel.orderStatus]];
    self.userNicknameLab.text = [NSString stringWithFormat:@"用户: %@",orderlineModel.userNickname];
    self.mobileLab.text = [NSString stringWithFormat:@"手机: %@",orderlineModel.mobile];
}

/**
 *      orderStatus         Integer	订单状态 
        订单状态，0为订单取消，
                10为已提交待付款，
                20为已付款，
                30为买家已使用，全部使用后更新该值,
                50买家评价完毕 ,
                65订单不可评价，到达设定时间，系统自动关闭订单相互评价功能

 */
- (NSString *)orderStatusStringWithOrderStatus:(NSInteger)orderStatus {
    switch (orderStatus) {
        case 0:
            return @"订单取消";
            break;
        case 10:
            return @"已提交待付款";
            break;
        case 20:
            return @"已付款";
            break;
        case 30:
            return @"已使用";
            break;
        case 50:
            return @"评价完毕";
            break;
        case 65:
            return @"订单不可评价";
            break;
        default:
            break;
    }
    return nil;
}

- (NSMutableAttributedString *)frontText:(NSString *)frontText frontAttri:(NSDictionary *)frontAttriDic appendText:(NSString *)appendText appendAttri:(NSDictionary *)attDic {
    NSMutableAttributedString *mutableArri = [[NSMutableAttributedString alloc] initWithString:frontText attributes:frontAttriDic];
    NSAttributedString *appendAttrText = [[NSAttributedString alloc] initWithString:appendText attributes:attDic];
    [mutableArri appendAttributedString:appendAttrText];
    return mutableArri;
}

@end
