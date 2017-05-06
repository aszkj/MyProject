//
//  MerchantManageSelectView.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/20.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectTopWitchBlock)(NSInteger index);
@interface MerchantManageSelectView : UIView


@property (nonatomic, copy)SelectTopWitchBlock selectTopWitchBlock;

@end
