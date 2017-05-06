//
//  XKJHPullMenuView.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickIndexPathBlock)(id deliverObj);
typedef void(^DeleteItemBlock)(NSInteger deleteIndex);

@interface XKJHPullMenuView : UIView
@property (weak, nonatomic) IBOutlet UITableView *pullTableView;

+ (id)showDownView:(UIView *)downView inContentView:(UIView *)contentView selectDatas:(NSArray *)selectData;

+(XKJHPullMenuView *)pullMenuView;

#pragma mark - warn结论，可变数组不要随便用copy关键字
@property (nonatomic, strong)NSMutableArray *pullDatas;


@property (nonatomic, copy)ClickIndexPathBlock clickIndexPathBlock;
@property (nonatomic, copy)DeleteItemBlock deleteItemBlock;

-(void)reloadData;

@end
