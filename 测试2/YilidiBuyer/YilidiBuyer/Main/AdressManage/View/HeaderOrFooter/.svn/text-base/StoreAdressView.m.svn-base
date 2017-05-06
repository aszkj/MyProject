//
//  StoreAdressView.m
//  YilidiBuyer
//
//  Created by yld on 16/8/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "StoreAdressView.h"
#import "StoreModel.h"
#import "NSString+Teshuzifu.h"


@interface StoreAdressView()
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeBusinessTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeAdressLabel;

@end

@implementation StoreAdressView

- (void)awakeFromNib {
    
    if (kScreenWidth == iPhone5_width) {
        self.storeNameLabel.font = self.storeBusinessTimeLabel.font = self.storeAdressLabel.font = kSystemFontSize(12.0);
    }
}

- (void)setStoreModel:(StoreModel *)storeModel {
    _storeModel = storeModel;
    [self _configureUIByModel];
}

- (void)_configureUIByModel {
    self.storeNameLabel.text = jFormat(@"自提门店： %@",self.storeModel.storeName);
    self.storeBusinessTimeLabel.text = jFormat(@"营业时间：%@-%@",self.storeModel.storeBusinessBeginTime,self.storeModel.storeBusinessEndTime);
    self.storeAdressLabel.text = jFormat(@"自提地址：%@",self.storeModel.storeAdress);
    if (![self.storeAdressLabel.text canDisplayOnOneLineWithFontSize:self.storeAdressLabel.font.pointSize onelineMaxWidth:kScreenWidth-23]) {
        self.storeAdressLabel.font = kSystemFontSize(self.storeAdressLabel.font.pointSize-1);
    }
}


@end
