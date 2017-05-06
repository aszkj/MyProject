//
//  WKLBleFirmware.m
//  WKLBle
//
//  Created by baoyx on 15/6/4.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//
#import "WKLBleFirmware.h"
#import "OtaApi.h"
typedef void (^UpgradePress)(int);
typedef void (^UpgradeInitialize)(void);
@interface WKLBleFirmware()<otaApiUpdateAppDataDelegate,otaEnableConfirmDelegate>
@end
@implementation WKLBleFirmware
{
    uint16_t pubFwLength;
    UpgradePress upgradePressBlock_;
    UpgradeInitialize upgradeInitializeBlock_;
    NSString *fileName_;
}

+(WKLBleFirmware *)shareInstance
{
    static WKLBleFirmware *firmware;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        firmware= [[WKLBleFirmware alloc] init];
    });
    return firmware;
}

-(instancetype)init
{
    if (self = [super init]) {
        fileName_ = [NSString string];
    }
    return self;
}

-(void)pubUpgradeWithProgress:(void (^)(int))progress withFileName:(NSString *)filename withInitialize:(void (^)(void))initialize withUpgradeType:(WKLUpgradeType)type
{
    fileName_ = filename;
    upgradePressBlock_= [progress copy];
    upgradeInitializeBlock_ = [initialize copy];
    
    switch (type) {
        case UpgradeTypeLibOta:
        {
            [self privateUpgradeLibOta];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark --------------------昆电科OTA升级 部分-------------------

#pragma mark 昆电科OTA升级
-(void)privateUpgradeLibOta
{

#if TARGET_IPHONE_SIMULATOR
    
#else    
    qBleClient *bleClient = [qBleClient sharedInstance];
    [bleClient pubStartOTAUpgrade];
    [otaApi sharedInstance].otaEnableConfirmDelegate=self;
    [otaApi sharedInstance].otaApiUpdateAppDataDelegate=self;
#endif
    
}

-(void)didOtaEnableConfirm : (CBPeripheral *)aPeripheral
                withStatus : (enum otaEnableResult) otaEnableStatus
{
    
    
    NSData *newFwFile =[NSData dataWithContentsOfFile:fileName_];
    
    const uint8_t *newFwFileByte = [newFwFile bytes];
    
    // uint32_t
    pubFwLength = (uint16_t) [newFwFile length];
    
    
    NSLog(@"newFwFileByte : %d", pubFwLength);
    
    if(pubFwLength == 0)
    {
        NSLog(@"文件为空");
        
        return;
    }
    
    if(pubFwLength > 50*1024)
    {
        
        NSLog(@"文件太大");
        
        return;
    }
    NSLog(@"aPeripheral=%@",aPeripheral);
#if TARGET_IPHONE_SIMULATOR
    
#else
    // ===== to start download ======
    [[otaApi sharedInstance] otaStart : aPeripheral
                         withDataByte : newFwFileByte
                           withLength : pubFwLength
                             withFlag : FALSE];
#endif

}

-(void)didOtaAppProgress : (enum otaResult)otaPackageSentStatus
            withDataSent : (uint16_t)otaDataSent
{
    int progress=(int)((otaDataSent/(float)pubFwLength)*100);
    upgradePressBlock_(progress);
}
-(void)didOtaMetaDataResult : (enum otaResult)otaMetaDataSentStatus
{
    
}
-(void)didOtaAppResult : (enum otaResult )otaResult
{
    upgradePressBlock_(100);
#if TARGET_IPHONE_SIMULATOR
    
#else
    [[qBleClient sharedInstance] pubStopOTAUpgrade];

#endif
    upgradeInitializeBlock_();
}

@end
