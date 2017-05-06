//
//  BaseCollectionView+nodata.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseCollectionView+nodata.h"
#import "GlobleErrorView.h"

@implementation BaseCollectionView (nodata)

- (void)nodataShowDeal {
    
    if (!self.dataLogicModule.currentDataModelArr.count) {
        if (isEmpty(self.nodataAlertTitle)) {
            self.nodataAlertTitle = @"暂无数据";
        }
        GlobleErrorView *nowDataView = [GlobleErrorView showInContentView:self withReloadBlock:nil alertTitle:self.nodataAlertTitle alertImageName:self.nodataAlertImage];
        if (self.nodataBgColor) {
            nowDataView.backgroundColor = self.nodataBgColor;
        }
        
    }else{
        [GlobleErrorView hideInContentView:self];
    }
}

- (void)hideNodataView {
    [GlobleErrorView hideInContentView:self];
}



@end
