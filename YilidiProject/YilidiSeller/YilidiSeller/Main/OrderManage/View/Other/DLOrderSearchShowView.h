//
//  DLOrderSearchShowView.h
//  YilidiSeller
//
//  Created by yld on 16/6/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MycommonTableView.h"

typedef void(^ComeToOrderDetailBlock)(NSString *orderNo);
@interface DLOrderSearchShowView : UIView

@property (strong, nonatomic)MycommonTableView *searchOrderTableView;
@property (nonatomic,copy)NSString *keyWords;

@property (nonatomic,copy)ComeToOrderDetailBlock comeToOrderDetailBlock;

@end
