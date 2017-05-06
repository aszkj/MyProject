//
//  AddPhotoCellectionViewCell.h
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDataModel.h"
@interface AddPhotoCellectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, strong)PhotoDataModel *photoDataModel;

@end
