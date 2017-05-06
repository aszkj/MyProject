//
//  DLBaseModel.h
//  YilidiSeller
//
//  Created by yld on 16/4/6.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/**
 *  配置默认字典，就是默认数据来源，但是如果有其他数据来源（同一个model, 对应的网络json结构不一样）那其他的采用类目配置
 *  另外，不采用第三方网络工具（比如mj）解析的原因是，这种方式可以在不同项目间的模型重用，并且不用依赖网络的json结构，自己定义自己的model,便于假数据的开发（即在不依赖网络接口的情况下利用自己定义的model,去开发数据逻辑，ui逻辑），虽然前期需要一个一个取key赋值稍微麻烦点，但是它对于以后项目级别的重用，以及不依赖网络接口并行开发数据与ui逻辑的好处是毋庸置疑的，
 *  通用数据模型，最好采用这种方式，比如购物车数据模型，订单列表数据模型，商品数据模型，订单详情数据模型，地址列表数据模型，地址详情数据模型，确认订单数据模型等等，非通用数据模型，你可以使用mj第三方工具解析
 *  @param dic 网络json
 */
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic;

@property (nonatomic,copy)NSString *ID;

@property (nonatomic,copy)NSDictionary *modelOriginalDic;

@property (nonatomic,strong)NSIndexPath* modelAtIndexPath;

@property (nonatomic,assign)BOOL selected;

@property (nonatomic,copy)NSString *testStr;

- (void)checkSelfPropertyValueNumllSituation;


@end

@interface BaseModel(setModelSelected)

- (NSIndexPath *)setOtherModelUnSelectedAccordingSelectedModel:(BaseModel *)selectedModel inModelArr:(NSArray *) modelArr;

@end
