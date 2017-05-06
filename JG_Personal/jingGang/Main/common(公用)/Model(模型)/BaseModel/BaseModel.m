//
//  BaseModel.m
//  ZCSuoPing
//
//  Created by caipeng on 14-11-14.
//  Copyright (c) 2014年 掌众传媒 www.chinamobiad.com. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithJSONDic:(NSDictionary *)json
{
    self = [super init];
    
    if (self) {
        
        [self _setValueForJSONKeysWithDictionary:json];
    }
    return self;
}

- (void)_setValueForJSONKeysWithDictionary:(NSDictionary *)json
{
    // 1 建立model和JSON的对应的关系
    NSDictionary *relationship = [self _setUpRelationship:json];
    
    for (id jsonKey in relationship) {
        
        // 根据value生成setter方法
        id modelValue = relationship[jsonKey];
        // 生成SEL变量，指向一个方法
        SEL sel = [self _makeSELWithName:modelValue];
        
        // 增强程序的健壮性
        if ([self respondsToSelector:sel]) {
            
            // 获取真正的数据
            id jsonValue = json[jsonKey];
            
            // 设置属性值
            [self performSelector:sel withObject:jsonValue];
        }
    }
}// 设置model的Value

- (SEL)_makeSELWithName:(NSString *)modelValue
{
    // image -> setImage:
    
    // 取出首字母
    NSString *capital = [[modelValue substringToIndex:1] uppercaseString];
    // 获取剩下的字符串
    NSString *end = [modelValue substringFromIndex:1];
    // 拼接字符串
    NSString *setterMethod = [NSString stringWithFormat:@"set%@%@:", capital, end];
    // 生成SEL变量
    SEL sel = NSSelectorFromString(setterMethod);

    return sel;
}// 生成setter方法

- (NSMutableDictionary *)_setUpRelationship:(NSDictionary *)json
{
    /**
     * relationship
     * key   : JSON  KEY
     * value : Model 属性值
     */
    NSMutableDictionary *relationship = [NSMutableDictionary dictionaryWithCapacity:json.count];
    
    for (id jsonKey in json) {
        
        if ([jsonKey isEqualToString:@"id"]) {
            
            // id 拼接，例如BaseModel-->BaseModelID
            NSString *className = NSStringFromClass([self class]);
            
            NSString *newModelValue = [className stringByAppendingFormat:@"%@", [jsonKey uppercaseString]];
            [relationship setObject:newModelValue forKey:jsonKey];
            
        }else {
            // model : image  json : image
            [relationship setObject:jsonKey forKey:jsonKey];
        }
    }
    
    return relationship;
}// 建立映射关系

@end



