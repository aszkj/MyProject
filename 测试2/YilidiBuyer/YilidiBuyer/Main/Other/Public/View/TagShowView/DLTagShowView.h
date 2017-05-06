//
//  DLTagShowView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagListView.h"
#import "CommonCategaryModel.h"
typedef void(^SelectItemBlock)(CommonCategaryModel *model);

@interface DLTagShowView : UIView

@property (nonatomic,strong)JCTagListView *tagListView;

@property (nonatomic,copy)SelectItemBlock selectItemBlock;

- (void)showWithData:(NSArray *)datas;

- (void)close;

@property (nonatomic,assign)BOOL isOpen;


@end
