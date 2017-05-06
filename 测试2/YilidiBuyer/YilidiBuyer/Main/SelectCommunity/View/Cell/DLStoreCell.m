//
//  DLStoreCell.m
//  YilidiBuyer
//
//  Created by yld on 16/7/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLStoreCell.h"
#import "StoreModel.h"

@implementation DLStoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLStoreCell (setCellModel)

- (void)setCellModel:(StoreModel *)storeModel {
    
    self.storeNameLabel.text = storeModel.storeName;
    self.storeBusinessTimeLabel.text = jFormat(@"营业时间：%@--%@",storeModel.storeBusinessBeginTime,storeModel.storeBusinessEndTime);
    self.storeAdressLabel.text = storeModel.storeAdress;

}

@end