//
//  WSJCityModel.h
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface cityInfoModel : NSObject
//
//@property (nonatomic, strong) NSNumber *ID;
//@property (nonatomic, strong) NSString *city;
//@property (nonatomic, strong) NSString *cityPinYin;
//
//@end
//
//@implementation cityInfoModel
//
//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"id = %@  city = %@  pinyin = %@",self.ID,self.city,self.cityPinYin];
//}
//
//@end

@interface WSJCityModel : NSObject
//每段的字母
@property (nonatomic,copy  ) NSString       *letter;
//每段的所有数据
@property (nonatomic,strong) NSMutableArray *data;



@end
