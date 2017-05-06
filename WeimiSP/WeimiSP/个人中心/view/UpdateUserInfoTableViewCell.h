//
//  UpdateUserInfoTableViewCell.h
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define updateUserInfoCellHeight 60

typedef void (^SendIdentifyingBlcok)(void);

@interface UpdateUserInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *identifyingBtn;

@property (nonatomic, copy) SendIdentifyingBlcok sendIdentifyingBlcok;

@end
