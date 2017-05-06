//
//  PayView.h
//  YilidiBuyer
//
//  Created by yld on 16/7/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayRequestModel;
@class PayResponseBaseModel;
typedef void(^PayResponseBlock)(PayRequestModel *payRequestModel,PayResponseBaseModel *payResponseModel,NSError *payRequestError);

@interface PayView : UIView

- (void)showPayViewWithRequestModel:(PayRequestModel *)payRequestModel
                      responseBlock:(PayResponseBlock)payResponseBlock;

@end
