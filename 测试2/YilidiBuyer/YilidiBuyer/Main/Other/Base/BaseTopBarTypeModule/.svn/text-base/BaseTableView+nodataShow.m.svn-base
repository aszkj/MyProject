//
//  BaseTableView+nodataShow.m
//  YilidiBuyer
//
//  Created by yld on 16/7/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseTableView+nodataShow.h"
#import "GlobleErrorView.h"

@implementation BaseTableView (nodataShow)

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
