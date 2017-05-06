//
//  DLModifyNickNameVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/21.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
typedef void (^NickNameBlock)(NSString *name);

@interface DLModifyNickNameVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet UITextField *nickNameField;
@property (nonatomic,strong)NSString *nameStr;
@property (nonatomic,strong)NickNameBlock nickNameBlock;

@end
