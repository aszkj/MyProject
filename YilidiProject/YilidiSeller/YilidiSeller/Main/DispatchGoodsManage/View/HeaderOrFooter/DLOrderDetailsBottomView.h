//
//  DLOrderDetailsBottomView.h
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/7/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBolck)(void);
typedef void(^SaveBolck)(void);
@interface DLOrderDetailsBottomView : UIView
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (nonatomic,strong)CancelBolck cancelBolck;
@property (nonatomic,strong)SaveBolck saveBolck;

@end
