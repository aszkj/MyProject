//
//  EarningDetailViewModel.h
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_TableViewModel.h"

typedef void(^RefushTableViewBlock)(void);

@interface EarningDetailViewModel : XKO_TableViewModel

@property (nonatomic) NSArray *titleArray;
@property (nonatomic) NSString *footerText;


@end
