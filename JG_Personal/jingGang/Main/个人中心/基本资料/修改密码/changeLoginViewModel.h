//
//  changeLoginViewModel.h
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface changeLoginViewModel : XKO_ViewModel

@property (nonatomic) NSString *oldPassword;
@property (nonatomic) NSString *updatePassword;
@property (nonatomic) NSString *confirmPassword;
@property (nonatomic) NSString *errorMessage;
@property (nonatomic) RACCommand *updatePasswordCommand;
@property (nonatomic) RACSignal *checkPassword;

@end
