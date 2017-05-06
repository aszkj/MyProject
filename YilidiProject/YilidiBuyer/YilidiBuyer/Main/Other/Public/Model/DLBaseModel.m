//
//  DLBaseModel.m
//  YilidiSeller
//
//  Created by yld on 16/4/6.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLBaseModel.h"
#import <objc/runtime.h>

@implementation DLBaseModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)checkSelfPropertyValueNumllSituation {
    /* 获取对象的所有属性 以及属性值 */
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (isEmpty(propertyValue)) {
            propertyValue = @"";
            [self setValue:propertyValue forKey:propertyName];
        }
        
    }
    free(properties);
}

@end

@implementation DLBaseModel (setModelSelected)

- (NSIndexPath *)setOtherModelUnSelectedAccordingSelectedModel:(DLBaseModel *)selectedModel inModelArr:(NSArray *) modelArr{
    
    for (DLBaseModel *model in  modelArr) {
        if (selectedModel.modelAtIndexPath.row != model.modelAtIndexPath.row && model.selected) {
            model.selected = NO;
            return model.modelAtIndexPath;
        }
    }
    return nil;
}


@end