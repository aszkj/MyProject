//
//  DLInspectionStatusHeader.h
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/7/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLInspectionStatusHeader : UIView
@property (strong, nonatomic) IBOutlet UILabel *orderNumber;
@property (strong, nonatomic) IBOutlet UILabel *outWarehouse;
@property (strong, nonatomic) IBOutlet UILabel *entranceWarehouse;
@property (strong, nonatomic) IBOutlet UILabel *createTime;

@end
