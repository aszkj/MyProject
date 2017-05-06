//
//  BaseCollectionView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopbarTypeTableDataLogicModule.h"
@interface BaseCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

//表处理数据逻辑模块
@property (nonatomic, strong)TopbarTypeTableDataLogicModule *dataLogicModule;

-(void)headerAutoRreshRequestBlock:(RequestDataBlock)headerAutoRequestBlock;
-(void)headerRreshRequestBlock:(RequestDataBlock)headerRequestBlock;
-(void)footerRreshRequestBlock:(RequestDataBlock)footerRequestBlock;
-(void)configureTableAfterRequestData:(NSArray *)modelDatas;

#pragma mark - nodata
@property (nonatomic,copy)NSString *nodataAlertTitle;
@property (nonatomic,copy)NSString *nodataAlertImage;
@property (nonatomic,copy)UIColor *nodataBgColor;

@end
