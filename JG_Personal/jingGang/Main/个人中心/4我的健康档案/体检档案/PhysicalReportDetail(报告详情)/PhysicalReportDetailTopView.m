//
//  PhysicalReportDetailTopView.m
//  jingGang
//
//  Created by HanZhongchou on 15/10/27.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "PhysicalReportDetailTopView.h"
#import "PublicInfo.h"

@implementation PhysicalReportDetailTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/


- (void)editButtonClick
{
    if([self.delegate respondsToSelector:@selector(editButtonClickNofitication)]){
        [self.delegate editButtonClickNofitication];
    }
}
- (UIView *)loadDataWithDic:(NSDictionary *)dic
{
    CGPoint temp = self.viewPoint;
    temp.x = self.viewPoint.x - 22;
    self.viewPoint = temp;
    
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 19, __MainScreen_Width - 44, 240)];
    viewBg.backgroundColor = [UIColor clearColor];
    
 
    
    
    //报告标题图片
    UIImageView *imageReportBook = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Physical_Report_Book"]];
    imageReportBook.frame = CGRectMake(0, 33, 39, 44);
    CGPoint pointImageReportBook = imageReportBook.center;
    pointImageReportBook.x = self.viewPoint.x;
    imageReportBook.center = pointImageReportBook;
    [viewBg addSubview:imageReportBook];
    
    //体检标题
    CGFloat labelReportTitleY = CGRectGetMaxY(imageReportBook.frame) + 15;
    UILabel *labelReportTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, labelReportTitleY, viewBg.width - 20, 18)];
    labelReportTitle.textAlignment = NSTextAlignmentCenter;
    CGPoint pointLabelReportTitle = labelReportTitle.center;
    pointLabelReportTitle.x = self.viewPoint.x;
    labelReportTitle.center = pointLabelReportTitle;
    labelReportTitle.font = [UIFont systemFontOfSize:15.0];
    
    NSString *strDate;
    NSString *strYear;
    NSString *strMonth;
    NSString *strDay;
    
    if (dic.count > 0) {
        strDate = [NSString stringWithFormat:@"%@",dic[@"createtime"]];
        strYear  = [strDate substringWithRange:NSMakeRange(0,4)];
        strMonth = [strDate substringWithRange:NSMakeRange(5, 2)];
        strDay   = [strDate substringWithRange:NSMakeRange(8, 2)];
//        labelReportTitle.text = [NSString stringWithFormat:@"%@年%@月%@日体检报告",strYear,strMonth,strDay];
        labelReportTitle.text = [NSString stringWithFormat:@"%@",dic[@"resultname"]];
    }else{
        labelReportTitle.text = [NSString stringWithFormat:@""];
    }

    labelReportTitle.textColor = rgb(123, 124, 125, 1);
    [viewBg addSubview:labelReportTitle];
    
    
    

    //检查日期
    CGFloat labelCheckDateY = CGRectGetMaxY(labelReportTitle.frame) + 30;
    UILabel *labelCheckDate = [[UILabel alloc]initWithFrame:CGRectMake(30, labelCheckDateY, 65, 17)];
    labelCheckDate.textColor = rgb(123, 124, 125, 1);
    labelCheckDate.font = [UIFont systemFontOfSize:14.0];
    labelCheckDate.text = @"检查日期:";
    [viewBg addSubview:labelCheckDate];
    
    //检查日期变量
    CGFloat labelCheckDateX = CGRectGetMaxX(labelCheckDate.frame) + 3;
    UILabel *labelCheckDateTrs = [[UILabel alloc]initWithFrame:CGRectMake(labelCheckDateX, labelCheckDateY, __MainScreen_Width - labelCheckDateX - 30, 17)];
    labelCheckDateTrs.textColor = rgb(123, 124, 125, 1);
    labelCheckDateTrs.font = [UIFont systemFontOfSize:14.0];
    if (dic) {
        labelCheckDateTrs.text = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDay];
    }

    [viewBg addSubview:labelCheckDateTrs];
    
    //体检医院/机构
    CGFloat labelCheckHospitalY = CGRectGetMaxY(labelCheckDateTrs.frame) + 6;
    UILabel *labelCheckHospital = [[UILabel alloc]initWithFrame:CGRectMake(30, labelCheckHospitalY, 97, 17)];
    labelCheckHospital.textColor = rgb(123, 124, 125, 1);
    labelCheckHospital.font = [UIFont systemFontOfSize:14.0];
    labelCheckHospital.text = @"体检医院/机构:";
    [viewBg addSubview:labelCheckHospital];
    
    //体检医院/机构 变量
    CGFloat labelCheckHospitalTrsX = CGRectGetMaxX(labelCheckHospital.frame) + 3;
    UILabel *labelCheckHospitalTrs = [[UILabel alloc]initWithFrame:CGRectMake(labelCheckHospitalTrsX, labelCheckHospitalY, __MainScreen_Width - labelCheckHospitalTrsX - 30, 17)];
    labelCheckHospitalTrs.textColor = rgb(75, 184, 231, 1);
    labelCheckHospitalTrs.font = [UIFont systemFontOfSize:14.0];
    labelCheckHospitalTrs.text = [NSString stringWithFormat:@"%@",dic[@"hospital"]];
    [viewBg addSubview:labelCheckHospitalTrs];
    
    
    //检查项背景View
    CGFloat viewCheckItemBgY = CGRectGetMaxY(labelCheckHospitalTrs.frame) + 17;
    UIView *viewCheckItemBg = [[UIView alloc]initWithFrame:CGRectMake(23, viewCheckItemBgY, __MainScreen_Width - 90, 22)];
    viewCheckItemBg.backgroundColor = rgb(224, 224, 225, 1);
    viewCheckItemBg.layer.cornerRadius = 10;
    [viewBg addSubview:viewCheckItemBg];
    
    //右上角编辑按钮
    
    //体检报告状态：1未提交、2待处理、3已处理
    //    status;1、3状态显示编辑按钮，检查项背景View加背景色        2则不用背景色，需要隐藏编辑按钮
    NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"3"]) {
        UIButton *buttonEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonEdit.frame = CGRectMake(viewBg.frame.size.width - 21 - 16, 22, 16, 16);
        [buttonEdit setBackgroundImage:[UIImage imageNamed:@"MER_bianji"] forState:UIControlStateNormal];
        [buttonEdit addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [viewBg addSubview:buttonEdit];
        
        
        viewCheckItemBg.backgroundColor = rgb(224, 224, 225, 1);
    }else{
        viewCheckItemBg.backgroundColor = [UIColor clearColor];
    }
    
    
    
    NSString *strRightCount = [NSString stringWithFormat:@"%@",dic[@"rightCount"]];
    NSString *strWrongCount = [NSString stringWithFormat:@"%@",dic[@"wrongCount"]];
    NSInteger rightCount = [strRightCount integerValue];
    NSInteger wrongCount = [strWrongCount integerValue];
    //总检查项
    UILabel *labelAllCheckItem = [[UILabel alloc]initWithFrame:CGRectMake(6, 3, 55, 17)];
    labelAllCheckItem.font = [UIFont systemFontOfSize:14.0];
    labelAllCheckItem.text = [NSString stringWithFormat:@"共:%ld项",rightCount + wrongCount];
    [viewCheckItemBg addSubview:labelAllCheckItem];
    
    //正常项
    CGFloat labelCheckY = labelAllCheckItem.frame.origin.y;
    UILabel *labelCheckNormalItem = [[UILabel alloc]initWithFrame:CGRectMake(0, labelCheckY, 90, 17)];
    labelCheckNormalItem.textColor = rgb(60, 61, 62, 1);
    CGPoint pointLebelCheckNormalItem = labelCheckNormalItem.center;
    pointLebelCheckNormalItem.x = self.viewPoint.x - 22;
    labelCheckNormalItem.center = pointLebelCheckNormalItem;
    if([strRightCount isEqualToString:@"(null)"]){
        strRightCount = @"0";
    }
    labelCheckNormalItem.text = [NSString stringWithFormat:@"正常:%@项",strRightCount];
    labelCheckNormalItem.textAlignment = NSTextAlignmentCenter;
    labelCheckNormalItem.font = [UIFont systemFontOfSize:14.0];
    [viewCheckItemBg addSubview:labelCheckNormalItem];
    
    //异常项
    //
    NSString *strWrongCountTemp = [NSString stringWithFormat:@"超标:%@项",strWrongCount];

    if([strWrongCount isEqualToString:@"(null)"]){
        strWrongCount = @"0";
    }
    CGSize size = CGSizeMake(MAXFLOAT, 17);
    NSDictionary *dicStrWrongCountTempSize = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    
    CGSize strWrongCountTempSize = [strWrongCountTemp boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin attributes:dicStrWrongCountTempSize
                                                 context:nil].size;
    
//    UILabel *labelCouriersName = [[UILabel alloc]initWithFrame:CGRectMake(couriersNameMaxX, 43, ssize.width, 21)];

    
    
    UILabel *labelLunusualItem = [[UILabel alloc]initWithFrame:CGRectMake(viewCheckItemBg.frame.size.width - strWrongCountTempSize.width - 5 , labelCheckY, strWrongCountTempSize.width, 17)];

    
    labelLunusualItem.textColor = rgb(60, 61, 62, 1);
    labelLunusualItem.attributedText = [self stringTrsColorForNumberWithStartRange:3 str:strWrongCountTemp color:[UIColor redColor]];
    labelLunusualItem.font = [UIFont systemFontOfSize:14.0];
    [viewCheckItemBg addSubview:labelLunusualItem];
    
    if (dic.count <= 1) {
        labelCheckHospitalTrs.text = @"";
        labelAllCheckItem.text = @"共:0项";
        labelCheckNormalItem.text = @"正常:0项";
        labelLunusualItem.text = @"超标:0项";
    }
    

    
    
    return viewBg;

}

/**
 *  把字符串中的数字变颜色
 *
 *  @param startRange 字符串从哪里变颜色的起始长度
 *  @param strColor   需要变颜色的字符串
 *  @param rangeColor 需要变成什么颜色
 */
- (NSMutableAttributedString *)stringTrsColorForNumberWithStartRange:(NSInteger)startRange str:(NSString *)strColor color:(UIColor *)rangeColor{
    
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:strColor.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:strColor];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }

    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strColor];
    
    [str addAttribute:NSForegroundColorAttributeName value:rangeColor range:NSMakeRange(startRange,strippedString.length)];
    
    
    return str;
}


@end
