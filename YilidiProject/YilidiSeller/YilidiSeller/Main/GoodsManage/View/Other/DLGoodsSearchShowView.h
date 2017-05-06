//
//  DLGoodsSearchShowView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MycommonTableView.h"

@interface DLGoodsSearchShowView : UIView
@property (strong, nonatomic) MycommonTableView *searchGoodsTableView;
@property (nonatomic,copy)NSString *keyWords;
@end
