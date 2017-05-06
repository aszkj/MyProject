//
//  JGCloudValueCell.m
//  jingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGCloudValueCell.h"
#import "JGIntegralValueModel.h"
#import "GlobeObject.h"
@interface JGCloudValueCell ()

#pragma mark --- 积分明细控件
/**
 *  积分背景View
 */
@property (weak, nonatomic) IBOutlet UIView *viewIntegralBg;
/**
 *  积分变更类型
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIntegralTypeName;
/**
 *  积分变更时间
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIntegralAddTime;
/**
 *  积分变更数值
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIntegralValue;
/**
 *  最新积分明细剩余余额
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIntegralNewBalance;

#pragma mark --- 云币明细控件
/**
 *  云币背景view
 */
@property (weak, nonatomic) IBOutlet UIView *viewCloudValueBg;
/**
 *  日期标签
 */
//@property (weak, nonatomic) IBOutlet UILabel *DateLab;

/**
 *  时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

/**
 *  金额标签
 */
@property (weak, nonatomic) IBOutlet UILabel *valueLab;

/**
 *  明细标签
 */
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

/**
 *  最新云币明细剩余余额
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCloudValueNewBalance;
/**
 *  云币变更明细label距离右边的距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cloudValueDetailSpaceRight;


@end

@implementation JGCloudValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return  self;
}

- (void)awakeFromNib {
    if (iPhone6) {//如果是iphone6的宽度,详情label的宽度+ 55
        self.cloudValueDetailSpaceRight.constant = self.cloudValueDetailSpaceRight.constant + 55;
    }else if (iPhone6p){//如果是iphone6的宽度,详情label的宽度+ 168
        self.cloudValueDetailSpaceRight.constant = self.cloudValueDetailSpaceRight.constant + 168;
    }
}

/**
 *  积分
 */
- (void)setIntegralModel:(JGIntegralValueModel *)integralModel
{
    _integralModel = integralModel;
//    if (self.valueType == IntegralCellType) {
        [self integarlModelSetWithModel];
//    }else if (self.valueType == CloudValueCellType){
//        [self cloudModelSetWithModel];
//    }
}

- (void)integarlModelSetWithModel
{
    self.viewIntegralBg.hidden = NO;
    self.viewCloudValueBg.hidden = YES;
    //    _model.addtime = [_model.addtime substringWithRange:NSMakeRange(0,10)];
    
    
    self.labelIntegralAddTime.text = _integralModel.addtime;
    
    
    self.labelIntegralNewBalance.text = [NSString stringWithFormat:@"余额:%.2f",_integralModel.balance];
    
    //判断是消费还是新增，如果是消费扣除积分字体颜色要变成灰色，新增是蓝色
    NSRange range = [_integralModel.integral rangeOfString:@"-"];//判断字符串是否包含减号(是否是负数)
    
    if (range.length >0)//包含
    {
        self.labelIntegralValue.text = _integralModel.integral;
        self.labelIntegralValue.textColor = kGetColor(197, 202, 205);
    }
    else//不包含
    {
        self.labelIntegralValue.text = [NSString stringWithFormat:@"+%@",_integralModel.integral];
        self.labelIntegralValue.textColor = kGetColor(28, 190, 225);
        
    }
    
    //根据后台的Type判断输出对应的积分变更文案
    if ([_integralModel.type isEqualToString:@"system"]) {
        self.labelIntegralTypeName.text = @"系统积分管理";
        
    }else if ([_integralModel.type isEqualToString:@"integral_register"]){
        self.labelIntegralTypeName.text = @"用户注册";
        
    }else if ([_integralModel.type isEqualToString:@"integral_register_invitation"]){
        self.labelIntegralTypeName.text = @"推荐新会员注册";
        
    }else if ([_integralModel.type isEqualToString:@"integral_login"]){
        self.labelIntegralTypeName.text = @"用户登录";
        
    }else if ([_integralModel.type isEqualToString:@"integral_goods_first_consumer"]){
        self.labelIntegralTypeName.text = @"商品首次消费";
        
    }else if ([_integralModel.type isEqualToString:@"integral_health_task"]){
        self.labelIntegralTypeName.text = @"健康任务";
        
    }else if ([_integralModel.type isEqualToString:@"integral_self_test"]){
        self.labelIntegralTypeName.text = @"自测";
        
    }else if ([_integralModel.type isEqualToString:@"integral_post"]){
        self.labelIntegralTypeName.text = @"发帖";
        
    }else if ([_integralModel.type isEqualToString:@"integral_comment"]){
        self.labelIntegralTypeName.text = @"评论";
        
    }else if ([_integralModel.type isEqualToString:@"integral_share"]){
        self.labelIntegralTypeName.text = @"分享";
        
    }else if ([_integralModel.type isEqualToString:@"integral_consumer"]){
        self.labelIntegralTypeName.text = @"消费";
        
    }else if ([_integralModel.type isEqualToString:@"integral_group_first_consumer"]){
        self.labelIntegralTypeName.text = @"服务首次消费";
        
    }else if ([_integralModel.type isEqualToString:@"integral_offline_order_first_consumer"]){
        self.labelIntegralTypeName.text = @"线下订单首次消费";
        
    }else if ([_integralModel.type isEqualToString:@"integral_evaluate"]){
        self.labelIntegralTypeName.text = @"评价";
        
    }
    else if ([_integralModel.type isEqualToString:@"integral_sign_day"]){
        self.labelIntegralTypeName.text = @"连续签到";
        
    }
    else if ([_integralModel.type isEqualToString:@"integral_order"]){
        self.labelIntegralTypeName.text = @"兑换商品";
        
    }

}



/**
 *  云币
 */
- (void)setCloudValuesModel:(JGIntegralValueModel *)cloudValuesModel
{
    _cloudValuesModel = cloudValuesModel;
    self.viewCloudValueBg.hidden = NO;
    self.viewIntegralBg.hidden = YES;
    //判断是消费还是新增
    NSRange range = [_cloudValuesModel.pdLogAmount rangeOfString:@"-"];//判断字符串是否包含减号(是否是负数)
    
    if (range.length >0)//包含
    {
        self.valueLab.text = _cloudValuesModel.pdLogAmount;
        self.valueLab.textColor = kGetColor(150, 150, 150);
        
    }
    else//不包含
    {
        self.valueLab.text = [NSString stringWithFormat:@"+%@",_cloudValuesModel.pdLogAmount];
        self.valueLab.textColor = kGetColor(28, 190, 225);
    }

//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [dateFormatter dateFromString:_cloudValuesModel.addTime];
//    
//    self.DateLab.text = [self weekdayStringFromDate:date];

    self.timeLab.text = _cloudValuesModel.addTime;
    
    //云币变更详情
    self.detailLab.text = [NSString stringWithFormat:@"[%@] %@",_cloudValuesModel.pdOpType,_cloudValuesModel.pdLogInfo];
    //云币当前余额
    self.labelCloudValueNewBalance.text = [NSString stringWithFormat:@"余额:%.2f",_cloudValuesModel.balance];
    
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
