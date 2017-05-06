//
//  DLGoodsSearchTopView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectRelativEmerator.h"

typedef void(^SearchBackBlock)(void);

typedef void(^BeginSearchBlock)(NSString *keyWords);

typedef void(^ClickToBeginSearchBlock)();

typedef void(^CancelSearchBlock)();

typedef void(^ClearButtonBlock)();

@interface DLGoodsSearchTopView : UIView

@property (nonatomic,copy)SearchBackBlock searchBackBlock;

@property (nonatomic,copy)BeginSearchBlock beginSearchBlock;

@property (nonatomic,copy)ClickToBeginSearchBlock clickToBeginSearchBlock;

@property (nonatomic,copy)CancelSearchBlock cancelSearchBlock;

@property (nonatomic,copy)ClearButtonBlock clearButtonBlock;

@property (nonatomic, strong)RACSignal *searchTextValidateSignal;

@property (nonatomic,assign)SearchType searchType;

@property (nonatomic,assign)BOOL noCancel;

- (void)setSearchKeyWords:(NSString *)searchKeyWords;


@end
