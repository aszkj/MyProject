//
//  BaseTabbarTypeTableView.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopbarTypeTableDataLogicModule.h"
@interface BaseTabbarTypeTableView : UITableView<UITableViewDelegate,UITableViewDataSource>


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataLogicModule:(TopbarTypeTableDataLogicModule *)dataLogicModule;

//表处理数据逻辑模块
@property (nonatomic, strong)TopbarTypeTableDataLogicModule *dataLogicModule;

-(void)headerAutoRreshRequestBlock:(RequestDataBlock)headerAutoRequestBlock;
-(void)headerRreshRequestBlock:(RequestDataBlock)headerRequestBlock;
-(void)footerRreshRequestBlock:(RequestDataBlock)footerRequestBlock;
-(void)configureTableAfterRequestData:(NSArray *)modelDatas;

@end
