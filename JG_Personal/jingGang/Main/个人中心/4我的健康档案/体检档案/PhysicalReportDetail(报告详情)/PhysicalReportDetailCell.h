//
//  PhysicalReportDetailCell.h
//  jingGang
//
//  Created by HanZhongchou on 15/10/27.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalReportDetailModel.h"
@class PhysicalReportDetailCell;
@protocol PhysicalReportDetailCellDelegat <NSObject>
//点击cell中的编辑按钮
- (void)editButtonClickWithPhysicalReportDetailCell:(PhysicalReportDetailCell *)cell indexPath:(NSIndexPath *)indexPath;



@end

@interface PhysicalReportDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelCheckDetailTitle;//项目标题
@property (weak, nonatomic) IBOutlet UIButton *buttonEditDetail;//编辑按钮
@property (weak, nonatomic) IBOutlet UILabel *labelDetailValue;//详细数值

@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (nonatomic,strong) PhysicalReportDetailModel *model;

@property (nonatomic,assign) id<PhysicalReportDetailCellDelegat>delegate;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (nonatomic,copy)   NSString *strStatus;//报告状态

@end
