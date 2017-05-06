//
//  SegementView.h
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedSegementBlock)(NSInteger selectedIndex);
@interface SegementView : UIView

- (instancetype)initWithSegementFrame:(CGRect)frame
                       segementTitles:(NSArray *)titles;

@property (nonatomic,copy)NSArray *segementTitles;

@property (nonatomic,assign)UIEdgeInsets segementInset;

@property (nonatomic,strong)UIColor *backGroundColor;

@property (nonatomic,strong)UIColor *selectedBackGroundColor;

@property (nonatomic,strong)UIFont *textFont;

@property (nonatomic,strong)UIColor *textColor;

@property (nonatomic,strong)UIColor *selectedTextColor;

@property (nonatomic,strong)UIColor *segementLayerBorderColor;

@property (nonatomic,assign)CGFloat segementLayerCornerRadius;

@property (nonatomic,assign)CGFloat segementLayerBorderWidth;

@property (nonatomic,assign)NSInteger selectedSegementIndex;

@property (nonatomic,copy)SelectedSegementBlock selectedSegementBlock;


@end
