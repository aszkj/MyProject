//
//  GoodsManageView.h
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifitionGoodsManageView : UIView

@property (nonatomic,strong)NSNumber *shelfNumber;

@property (nonatomic,assign)BOOL updateDataJustByShelfNumber;

- (void)setGoodsClassCode:(NSString *)goodsClassCode
           sortRuleNumber:(NSInteger)sortRuleNumber;

@property (nonatomic,copy) NSString *brandCode;


@end
