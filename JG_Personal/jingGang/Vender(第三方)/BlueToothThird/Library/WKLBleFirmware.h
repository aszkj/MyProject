//
//  WKLBleFirmware.h
//  WKLBle
//
//  Created by baoyuexing on 15/6/7.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  NS_ENUM(NSInteger,WKLUpgradeType){
    UpgradeTypeNo = 0,//不支持升级
    UpgradeTypeOld,   //Q1升级
    UpgradeTypeNew,  //Q2升级
    UpgradeTypeLibOta, //昆电科OTA升级
    UpgradeTypeDialogOta, //dialogOTA升级
};
@interface WKLBleFirmware : NSObject
+(WKLBleFirmware *)shareInstance;
/**
 *  固件升级
 *
 *  @param progress   升级进度
 *  @param filename   升级文件路径
 *  @param initialize 初始化
 *  @param type 升级类型
 */
-(void)pubUpgradeWithProgress:(void (^)(int upgradeProgress))progress withFileName:(NSString *)filename withInitialize:(void (^)(void))initialize withUpgradeType:(WKLUpgradeType)type;
@end
