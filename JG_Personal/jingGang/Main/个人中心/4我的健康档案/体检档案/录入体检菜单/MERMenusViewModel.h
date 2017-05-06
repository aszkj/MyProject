//
//  MERMenusViewModel.h
//  jingGang
//
//  Created by ray on 15/10/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface MERMenusViewModel : XKO_ViewModel

@property (nonatomic) NSArray *classArray;
@property (nonatomic) NSArray *detailArray;

@property (nonatomic, readonly) NSArray *resultGroupArray;
@property (nonatomic, readonly) NSArray *resultItemBOArray;



- (void)getClassArrayRequest;
- (void)getDetailArrayAtIndex:(NSInteger)index;

@end
