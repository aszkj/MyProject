//
//  EnvironmentPhotoController.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnvironmentPhotoController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

// 图片数据源，EnvironmentInfo类型
@property (nonatomic, strong) NSNumber *storeId;

@end
