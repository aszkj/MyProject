//
//  PhysicalReportDetailTopView.h
//  jingGang
//
//  Created by HanZhongchou on 15/10/27.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PhysicalRetailTopViewDelegate <NSObject>

- (void)editButtonClickNofitication;

@end


@interface PhysicalReportDetailTopView : UIView

@property (nonatomic,assign) CGPoint viewPoint;
- (PhysicalReportDetailTopView *)loadDataWithDic:(NSDictionary *)dic;


@property (nonatomic,assign) id<PhysicalRetailTopViewDelegate>delegate;
@end
