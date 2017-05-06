//
//  DLEditAdressVC.h
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "ProjectRelativEmerator.h"
#import "ProjectRelativeConst.h"

@interface DLEditAdressVC : DLBuyerBaseController

@property (nonatomic,assign)OperatorAddressType operatorAddressType;

@property (nonatomic,copy)NSString *shippingAddressId;

@property (nonatomic,copy)PopToLastPageBlock popToLastPageBlock;

@end
