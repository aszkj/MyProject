//
//  DLHomeHeaderView.h
//  YilidiSeller
//
//  Created by yld on 16/6/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OrderBlock)(void);
typedef void(^InvitationBlock)(void);

@interface DLHomeHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIImageView *storeImage;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *storePhone;
@property (strong, nonatomic) IBOutlet UILabel *storeTimer;

@property (strong, nonatomic) IBOutlet UILabel *waitingOrder;

@property (strong, nonatomic) IBOutlet UILabel *todayProfit;
@property (strong, nonatomic) IBOutlet UILabel *todayInvitation;

@property (nonatomic,strong)OrderBlock orderBlock;
@property (nonatomic,strong)InvitationBlock invitationBlock;

@end
