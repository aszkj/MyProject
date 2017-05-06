//
//  XKJHMemberTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHMemberTableViewCell.h"
#import "OperatorRegisterUserList.h"
#import "NSDate+Utilities.h"

@interface XKJHMemberTableViewCell ()
{
    __weak IBOutlet NSLayoutConstraint *tileWidth;
}
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation XKJHMemberTableViewCell

- (void)awakeFromNib {
//    self.nickNameLabel.adjustsFontSizeToFitWidth = YES;
}

-(void)willCustomCellWith:(XKO_MembersManagerResponseInfo *)response
{
    CGRect rect = [response.nickname boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    if (rect.size.width > 120)
    {
        tileWidth.constant = rect.size.width;
        if (rect.size.width > kScreenWidth - 120)
        {
            tileWidth.constant = kScreenWidth - 120;
        }
    }
    else
    {
        tileWidth.constant = 120;
    }
    
    self.nickNameLabel.text = response.nickname;
    self.createTimeLabel.text = response.createTime;
    self.typeLabel.text = response.storeName;
    self.statusLabel.text = response.relationName;
    self.statusLabel.hidden = NO;
}
/**
 *  @param dict content OperatorRegisterUserList
 */
- (void)willCustomRegisterWith:(NSDictionary *)dict
{
    tileWidth.constant = kScreenWidth - 40;
    self.nickNameLabel.text = dict[@"nickname"];
    self.createTimeLabel.text = [self setCreateTime:dict[@"createTime"]];
    self.typeLabel.text = [NSString stringWithFormat:@"商户名称：%@",dict[@"storeName"] ? dict[@"storeName"]: @"无"];
    self.statusLabel.hidden = YES;
}
- (NSString *)setCreateTime:(NSString *)createTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:createTime];
    return [NSString stringWithFormat:@"注册时间：%04ld-%02ld-%02ld %02d:%02d:%02d",date.year,(long)date.month,(long)date.day,(int)date.hour,(int)date.minute,(int)date.seconds];
}
@end
