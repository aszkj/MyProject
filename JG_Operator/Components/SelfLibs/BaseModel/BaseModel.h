//
//  BaseModel.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import <Foundation/Foundation.h>

#define MODEL_KEY_MORE    @"more"
#define MODEL_KEY_ITEMS   @"items"
#define MODEL_KEY_NEXT    @"next"
#define MODEL_KEY_ERRCODE @"errcode"
#define MODEL_KEY_MSG     @"msg"
#define MODEL_KEY_RET     @"ret"
#define MODEL_KEY_DATA     @"data"
#define MODEL_KEY_MODIFYTIME @"modifyTime"
#define MODEL_KEY___SERVERDATE @"__serverDt"
#define MODEL_KEY___MODELDATE @"__modelDate"
#define MODEL_KEY___CLASSNAME @"__className"

typedef void (^ModelCompleted)(NSMutableDictionary *dic);


@interface CWClassModel :NSObject
@property(nonatomic, copy)NSString *errcode;
@property(nonatomic, copy)NSString *msg;
@property(nonatomic, copy)NSString *ret;
@property(nonatomic, weak)id infos;
- (NSMutableDictionary *)toDictionary;
- (id)initWithDictionary:(NSDictionary*)params;
@end

@interface BaseModel : NSObject
@property(nonatomic, copy)NSString *__next;
@property(nonatomic, copy)NSString *__modelDate;
@property(nonatomic, readonly)NSString *__serverDt;
@property(nonatomic, copy)NSString *__className;
@property(nonatomic, strong)CWClassModel *classMdel;
-(NSString *)description;

- (id)initWithDictionary:(id)params;
- (NSMutableDictionary *)toDictionary;
- (void)toDictionaryWithBlock:(ModelCompleted)completed;

+ (id)modelWithDictionary:(NSDictionary *)datas;
@end


@interface CWModels : BaseModel<NSFastEnumeration>
@property(nonatomic, strong) NSMutableArray *items;
- (id)addValueWithDictionary:(NSDictionary *)params;
-(void)addValueWithArray:(NSArray *)params;
-(id)initWithArray:(NSArray *)params;
-(NSArray *)toArray;
-(id)addObject:(id)obj;
-(NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
@end


@interface NSObject (Extension)
-(NSMutableDictionary *)toDictionary;
-(id)initWithDictionary:(NSDictionary *)dic;
- (void)toDictionaryWithBlock:(ModelCompleted)completed;
+ (NSDictionary *)varList;
+ (NSDictionary *)propertyList;
@end
