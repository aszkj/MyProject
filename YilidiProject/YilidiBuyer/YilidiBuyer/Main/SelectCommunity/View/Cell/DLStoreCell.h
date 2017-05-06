//
//  DLStoreCell.h
//  YilidiBuyer
//
//  Created by yld on 16/7/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kStoreCellHeight 80
@class StoreModel;
@interface DLStoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeBusinessTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeAdressLabel;
@end


@interface DLStoreCell (setCellModel)

- (void)setCellModel:(StoreModel *)storeModel;

@end