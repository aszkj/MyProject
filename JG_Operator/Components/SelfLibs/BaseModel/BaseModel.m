//
//  BaseModel.m
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import "BaseModel.h"
#import <objc/runtime.h>
//#import "WSharedDatas.h"

#pragma mark NSDate Extension

@interface NSDate(CWModel)
+ (NSString *)locationTimeForString;
@end

@implementation NSDate(CWModel)
- (NSString *) currentMilliSecond
{
	NSInteger timeZone = [[NSTimeZone localTimeZone] secondsFromGMTForDate:self];
	
	NSInteger dValue = timeZone - 28800;
    
	NSTimeInterval curSec = [self timeIntervalSince1970];
	NSTimeInterval chinaTime = curSec - dValue;
	
	NSString *resultDateStr = [[NSString stringWithFormat:@"%.3f", chinaTime]
                               stringByReplacingOccurrencesOfString:@"." withString:@""];
	return resultDateStr;
}

+ (NSString *)locationTimeForString {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    return [date currentMilliSecond];
}
@end

@implementation BaseModel

-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self toDictionary]];
}
- (void)dealloc {
    self.__next = nil;
    self.__modelDate = nil;
    self.__className = nil;
  
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *curDate = [NSDate locationTimeForString];
        [self set__modelDate:curDate];
        [self set__next:@"0"];
        [self set__modelDate:nil];
        
        [self set__className:NSStringFromClass([self class])];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)params {
    self = [self init];
    if (self) {
        NSString *modelDate = [params valueForKey:MODEL_KEY___MODELDATE];
        if (modelDate) {
            [self set__modelDate:modelDate];
        }
        NSString *next = [params valueForKey:MODEL_KEY_NEXT];
        if (next) {
            [self set__next:next];
        }
        
//        NSString *className = [params valueForKey:MODEL_KEY___CLASSNAME];
//        if (className) {
//            [self set__className:className];
//        }
    }
    return self;
}





- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:self.__modelDate forKey:MODEL_KEY___MODELDATE];
    if (![self.__next isEqualToString:@"0"]) {
        [dic setValue:self.__next forKey:MODEL_KEY_NEXT];
    }
    
    if (![self.__className isEqualToString:@"CWModel"]) {
        [dic setValue:self.__className forKey:MODEL_KEY___CLASSNAME];
    }
    return dic;
}

- (void)toDictionaryWithBlock:(ModelCompleted)completed {
    typeof(self) this = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableDictionary *dic = [this toDictionary];
        completed(dic);
    });
}

+ (id)modelWithDictionary:(NSDictionary *)datas {
    return  [[BaseModel alloc] initWithDictionary:datas];
}
@end


@implementation CWModels
@synthesize items=_items;
-(NSUInteger)count{
    return [_items count];
}
- (id)objectAtIndex:(NSUInteger)index{
    return [_items objectAtIndex:index];
}

-(NSArray *)toArray{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (BaseModel * model in self.items) {
        [array addObject:[model toDictionary]];
//        [array addObject:model];
    }
    return array;
}

-(void)addValueWithArray:(NSArray *)params{
    for (id dic in params) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self addValueWithDictionary:dic];
        }else{
            [self.items addObject:dic];
        }
    }
}
-(id)initWithArray:(NSArray *)arrray{
    if (self = [self init]) {
        [self addValueWithArray:arrray];
    }
    return self;
}
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len{
   
    return [_items countByEnumeratingWithState:state objects:buffer count:len];
}
- (void)dealloc {

}

- (id)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (id)initWithDictionary:(id)params {
    if ([params isKindOfClass:[NSArray class]]) {
        return [self initWithArray:params];
    }
    
    self = [super initWithDictionary:params];
    if (self) {
        NSArray *items = (NSArray*)[params valueForKey:MODEL_KEY_ITEMS];
        typeof(self) this = self;
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [this addValueWithDictionary:obj];
        }];
    }
    return self;
}

- (NSMutableDictionary *)toDictionary  {
    NSMutableDictionary *dic = [super toDictionary];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [items addObject:[(BaseModel *)obj toDictionary]];
    }];
    [dic setValue:items forKey:MODEL_KEY_ITEMS];
    return dic;
}

- (void)toDictionaryWithBlock:(ModelCompleted)completed {
    typeof(self) this = self;
    
    [super toDictionaryWithBlock:^(NSMutableDictionary *dic){
        NSMutableArray *__items = [NSMutableArray arrayWithCapacity:0];
        [this.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [__items addObject:[(BaseModel *)obj toDictionary]];
            
        }];
        [dic setValue:__items forKey:MODEL_KEY_ITEMS];
        completed(dic);
    }];
}

- (id)addValueWithDictionary:(NSDictionary *)params {
    
    BaseModel *model = [[BaseModel alloc] initWithDictionary:params];
    [self.items addObject:model];
    return self;
}
-(id)addObject:(id)obj{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        [self addValueWithDictionary:obj];
    }else
        [self.items addObject:obj];
    return self;
}
+ (id)modelWithDictionary:(NSDictionary *)datas
{
    CWModels *topics  = [[CWModels alloc] init];
    for (NSDictionary *topdis in datas) {
        BaseModel *topic = [[BaseModel alloc] initWithDictionary:topdis];
        if (topic)
        {
            [topics.items addObject:topic];
        }
       
    }
    return topics;
}

@end

@implementation CWClassModel
@synthesize infos = _infos;
@synthesize ret = _ret;
@synthesize msg = _msg;
@synthesize errcode = _errcode;

- (void)dealloc {

}


- (id)init {
    self = [super init];
    if (self) {
        [self setRet:nil];
        [self setMsg:nil];
        [self setErrcode:nil];
        [self setInfos:nil];
    }
    return self;
}
- (id)initWithDictionary:(NSDictionary*)params {
    self = [self init];
    if (self) {
        NSString *ret = [params valueForKey:MODEL_KEY_RET];
        if (ret) {
            [self setRet:ret];
        }
        NSString *errcode = [params valueForKey:MODEL_KEY_ERRCODE];
        if (errcode) {
            [self setErrcode:errcode];
        }
        
        NSString *msg = [params valueForKey:MODEL_KEY_MSG];
        if (msg) {
            [self setMsg:msg];
        }
        id datas = [params valueForKey:MODEL_KEY_DATA];
        if (datas) {
            [self setInfos:datas];
        }
    }
    return self;
}
- (NSMutableDictionary *)toDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:self.ret forKey:MODEL_KEY_RET];
    [dic setValue:self.errcode forKey:MODEL_KEY_ERRCODE];
    [dic setValue:self.msg forKey:MODEL_KEY_MSG];
    [dic setValue:self.infos forKey:MODEL_KEY_DATA];
    return dic;
}
@end
@implementation NSObject (Extension)
#define MODEL_KEY_OBJECT @"object"
-(NSMutableDictionary *)toDictionary{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver setOutputFormat:NSPropertyListXMLFormat_v1_0];
    [archiver encodeObject:self forKey:NSStringFromClass([self class])];
    [archiver finishEncoding];
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    [dic setObject:NSStringFromClass([self class]) forKey:MODEL_KEY___CLASSNAME];
    [dic setObject:str forKey:MODEL_KEY_OBJECT];
    return dic;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    NSString * objXml = [dic objectForKey:MODEL_KEY_OBJECT];
    NSString * className = [dic objectForKey:MODEL_KEY___CLASSNAME];
    if (!className || !objXml) {
        return nil;
    }
    Class class = NSClassFromString(className);
    NSData * data = [objXml dataUsingEncoding:NSUTF8StringEncoding];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id  obj =[unarchiver decodeObjectOfClass:class forKey:className];
    return obj;
}
- (void)toDictionaryWithBlock:(ModelCompleted)completed {
    typeof(self) this = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableDictionary *dic = [this toDictionary];
        completed(dic);
    });
}
+ (NSDictionary *)varList
{
    
    unsigned int numIvars = 0;
    
    NSString *key=nil;
    
    Ivar * ivars = class_copyIvarList([self class], &numIvars);
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        [dic setObject:stringType forKey:key];
    }
    free(ivars);
    return dic;
}
+ (NSDictionary *)propertyList
{
    
    unsigned int numIvars = 0;
    
    NSString *key=nil;
    objc_property_t   *propertys = class_copyPropertyList([self class], &numIvars);
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    for(int i = 0; i < numIvars; i++) {
        objc_property_t thisProperty = propertys[i];
        const char *type = property_getAttributes(thisProperty);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        key = [NSString stringWithUTF8String:property_getName(thisProperty)];
        [dic setObject:stringType forKey:key];
    }
    free(propertys);
    return dic;
}
@end