//
//  DLAdressListViewModel.h
//  YilidiBuyer
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ProjectRelativEmerator.h"


@interface DLAdressListViewModel : BaseViewModel

@property (nonatomic,assign)AdresslistType adresslistType;

-(RACSignal *)requestAdresslist;
-(RACSignal *)requestSetDefaultAdressWithAdressId:(NSString *)adressId;
-(RACSignal *)requesteleteAdressWithAdressId:(NSString *)adressId;

-(void)deleteAdressAtRow:(NSInteger)deleteAdressAtRow;
@property (nonatomic,strong)NSMutableArray *adressList;

-(NSArray *)getTestAdressListData;

@end
