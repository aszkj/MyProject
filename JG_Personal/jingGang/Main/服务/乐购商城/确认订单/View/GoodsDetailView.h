//
//  GoodsDetailView.h
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedBlock)(BOOL selected);


@interface GoodsDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *goodsLogo;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsSpecInfo;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;
@property (weak, nonatomic) IBOutlet UIImageView *phoneVIP;
@property (weak, nonatomic) IBOutlet UILabel *jifengLB;
@property (nonatomic,copy) SelectedBlock selectedBlock;

@end
