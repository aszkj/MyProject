//
//  BrandDataManager.m
//  YilidiBuyer
//
//  Created by mm on 16/12/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BrandDataManager.h"
#import "DLBrandModel.h"
#import "ChineseString.h"
#import "GlobleConst.h"
static BrandDataManager *_brandDataManager = nil;

@interface BrandDataManager()

@property (nonatomic,copy)NSArray *brandIndexArr;

@property (nonatomic,strong)NSMutableArray *brandArr;

@property (nonatomic,assign) BOOL hasFinishedHandleBrandData;

@property (nonatomic,copy)FetchBrandDataBlock fetchBrandDataBlock;

@property (nonatomic,copy) NSString *requestBrandDataStoreId;


@end

@implementation BrandDataManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _brandDataManager = [[BrandDataManager alloc] init];
        
    });
    return _brandDataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
    
}

- (void)fetchBrandData:(FetchBrandDataBlock)fetchBrandDataBlock {
    
    if (self.hasFinishedHandleBrandData) {
        fetchBrandDataBlock(self.brandArr,self.brandIndexArr);
    }else {
        self.fetchBrandDataBlock = fetchBrandDataBlock;
    }
}

- (BOOL)needRequestBrandData
{
    BOOL needRequestBrandData = NO;
    
    if (isEmpty(kCommunityStoreId)) {
        return NO;
    }
    
    if (isEmpty(self.requestBrandDataStoreId)) {
        needRequestBrandData = YES;
    }else {
        //上一次请求的storeId有值，但是又和当前的不一样，说明店铺换了,得重新请求分类
        if (![self.requestBrandDataStoreId isEqualToString:kCommunityStoreId]) {
            needRequestBrandData = YES;
        }else {
            if (self.hasFinishedHandleBrandData) {
                needRequestBrandData = NO;
            }else {
                needRequestBrandData = YES;
            }
        }
    }
    return needRequestBrandData;
}


- (void)startDownLoadBrandData {
    
    if (![self needRequestBrandData]) {
        return;
    }
    self.requestBrandDataStoreId = kCommunityStoreId;
    DDLogVerbose(@"正在获取所有品牌数据...");
    [AFNHttpRequestOPManager postWithParameters:@{@"type":@"all"} subUrl:kUrl_Brand block:^(NSDictionary *resultDic, NSError *error) {
        
        if (isEmpty(resultDic[EntityKey])) {
            self.brandArr = [@[] mutableCopy];
            self.brandIndexArr = @[];
            self.hasFinishedHandleBrandData = YES;
            return;
        }
        
        NSArray *reusltBrandArr = resultDic[EntityKey];
        NSArray *transFerededBrandArray = [DLBrandModel objectBrandModelWithArr:reusltBrandArr];
    
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            [self _handleBrandData:transFerededBrandArray];
            
        });
        

    }];
}

- (void)_handleBrandData:(NSArray *)brandDatas {
    
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (DLBrandModel *brandModel in brandDatas) {
        [mutableArr addObject:brandModel.brandName];
    }
    //排序组头 A B C D... #特殊字符存在即放入最后面
    NSMutableArray *indexArr = [ChineseString IndexArray:mutableArr];
    if ([indexArr[0]isEqualToString:@"#"]) {
        [indexArr removeObjectAtIndex:0];
        [indexArr insertObject:@"#" atIndex:indexArr.count];
        self.brandIndexArr = indexArr;
    }else{
        self.brandIndexArr = indexArr;
    }
    //排序每组的内容
    [self sortedArrayWithChineseObject:[brandDatas mutableCopy]];
}

- (void)sortedArrayWithChineseObject:(NSMutableArray *)mArray {
    
    
    //特殊字符的数组
    NSMutableArray *specialLetterArr = [NSMutableArray arrayWithCapacity:0];
    //字母数组
    NSMutableArray *letterArr = [NSMutableArray arrayWithCapacity:0];
    for (DLBrandModel *model6 in mArray) {
        //拿到字符串首字母
        NSString *str = [self firstCharactorWithString:model6.brandName];
        //判断是否是拼音
        BOOL isLetterOfFirstCharactorCurrentStr = [self isTheLetter:str];
        
        if (!isLetterOfFirstCharactorCurrentStr) {
            [specialLetterArr addObject:model6];
            
        }else{
            [letterArr addObject:model6];
        }
        
    }
    
    
    //字母数组 根据首字母拼音相同，组装secsion中的数据
    self.brandArr = [NSMutableArray arrayWithCapacity:0];
    
    [self getSameArrayList:letterArr];
    
    //根据首字母然后进行model排序
    for(NSUInteger i = 0; i < self.brandArr.count - 1; i++) {
        for(NSUInteger j = 0; j < self.brandArr.count - i - 1; j++) {
            NSArray *modelArrFirst = (NSArray*)[self.brandArr objectAtIndex:j];
            NSArray *modelArrSecond = (NSArray*)[self.brandArr objectAtIndex:j+1];
            DLBrandModel *model = modelArrFirst.firstObject;
            DLBrandModel *model2 = modelArrSecond.firstObject;
            NSString *pinyinFirst = [self lowercaseSpellingWithChineseCharacters:model.brandName];
            NSString *pinyinSecond = [self lowercaseSpellingWithChineseCharacters:model2.brandName];
            //此处为升序排序，若要降序排序，把NSOrderedDescending 换为NSOrderedAscending即可。
            if(NSOrderedDescending == [pinyinFirst compare:pinyinSecond]) {
                NSArray *modelArr3 = (NSArray*)self.brandArr[j];
                self.brandArr[j] = self.brandArr[j + 1];
                self.brandArr[j + 1] = modelArr3;
            }
        }
        
    }
    
    //特殊字符存在 即插入到总数组的最后面
    if ([specialLetterArr count]>0) {
        [self.brandArr insertObject:specialLetterArr atIndex:self.brandArr.count];
    }
    self.hasFinishedHandleBrandData = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        emptyBlock(self.fetchBrandDataBlock,self.brandArr,self.brandIndexArr);
    });
    
    
}
//首字母相同的先进行一个分组
- (NSMutableArray *)getSameArrayList:(NSArray *)arrayList
{
    
    NSMutableArray *diffArray = [NSMutableArray array];
    NSMutableArray *sameArray = [NSMutableArray array];
    [sameArray addObject:arrayList[0]];
    for (int i = 1; i < arrayList.count; i ++) {
        DLBrandModel *model0 = (DLBrandModel*)sameArray[0];
        DLBrandModel *modeli = (DLBrandModel*)arrayList[i];
        NSString *currenStr0 =[self firstCharactorWithString:model0.brandName];
        NSString *currenStri =[self firstCharactorWithString:modeli.brandName];
        
        if ([currenStri isEqualToString:currenStr0]) {
            [sameArray addObject:arrayList[i]];
        }else{
            [diffArray addObject:arrayList[i]];
        }
    }
    [self.brandArr addObject:sameArray];
    if (diffArray.count != 0) {
        [self getSameArrayList:diffArray];
    }
    return self.brandArr;
}



//判断首字母是否相同
- (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}


-(NSString *)lowercaseSpellingWithChineseCharacters:(NSString *)chinese {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:chinese];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    //返回小写拼音
    return [str lowercaseString];
}

- (BOOL)isTheLetter:(NSString *)str

{
    if ([str characterAtIndex:0] >= 'A' && [str characterAtIndex:0] <= 'Z') {
        
        return YES;
        
    }else if ([str characterAtIndex:0] >= 'a' && [str characterAtIndex:0] <= 'z') {
        
        return YES;
        
    }
    
    return NO;
    
    
}



@end
