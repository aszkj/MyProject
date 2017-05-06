//
//  DLInvitationOrdetailsModel.h
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBaseModel.h"

@interface DLInvitationOrdetailsModel : DLBaseModel
@property (nonatomic,assign)NSInteger saleProductId;
@property (nonatomic,strong)NSString *saleProductName;
@property (nonatomic,strong)NSString *saleProduct;
@property (nonatomic,strong)NSString *brandName;
@property (nonatomic,assign)NSInteger allotCount;
@property (nonatomic,assign)NSInteger realAllotCount;
@property (nonatomic,strong)NSString *saleProductImageUrl;
@property (nonatomic,assign)BOOL isReceiveHidden;
@end

@interface DLInvitationOrdetailsModel (setInvitationOrdertaiModel)


+ (NSArray *)objectWithInvitationModelArr:(NSArray *)array isInspectionHidden:(BOOL)hidden isReceiveHidden:(BOOL)receiveHidden;

@end