//
//  otaApi.h
//  OtaDemo
//
//  @brief Application Programming Interface Header File for OTA Profile.
//
//  Created by quintic on 5/18/14.
//  Copyright (c) 2014 Quintic. All rights reserved.
//

#ifndef QBlueOTA_TASK_h
#define QBlueOTA_TASK_h

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <CoreBluetooth/CoreBluetooth.h>
#else
#import <IOBluetooth/IOBluetooth.h>@protocol otaEnableConfirmDelegate
#endif

#import "QBleClient.h"

/// to notify discovered Services to app layer
#define keyOtaPeripheral                @"key-OtaPeripheral"
#define keyOtaEnableConfirm             @"key-OtaEnableConfirmStatus"

#define otaEnableConfirmNoti            @"ota-EnableConfirmNoti"

/// OTA api result during transfering data
enum otaResult
{
    /// Success
    OTA_RESULT_SUCCESS = 0,
        
    /// Fail
    /// Current packet checksum error
    OTA_RESULT_PKT_CHECKSUM_ERROR, // anytime
    /// Current packet length overflow or equal to 0
    OTA_RESULT_PKT_LEN_ERROR,  // anytime
        
    /// Device don't support OTA
    OTA_RESULT_DEVICE_NOT_SUPPORT_OTA, //Meta DATA 
    /// OTA firmware size overflow or equal to 0
    OTA_RESULT_FW_SIZE_ERROR,          //Meta DATA 
        
    /// OTA firmware verify error
    OTA_RESULT_FW_VERIFY_ERROR,  // Verify 
};

/**
 ****************************************************************************************
 * @brief OTA Api load file result (the file size less than 50K).
 *
 ****************************************************************************************
 */
enum otaLoadFileResult
{
    OTA_FIRMWARE_ERROR = -1,
    OTA_FIRMWARE_NO_ERROR,
};

enum otaEnableResult
{
    OTA_CONFIRM_FAILED = -1,
    OTA_CONFIRM_OK,
};

/// OTA receive enablec onfirm delegate.
@protocol otaEnableConfirmDelegate

/**
 *****************************************************************
 * @brief APP receive data from OtaApi Layer.
 *
 * @param[out]  aPeripheral     : the Peripheral connected.
 * @param[out]  otaEnableStatus : the qppEnableStatus enabled.
                                  STATE_OTA_CONFIRM_OK: all of the following four conditions are
                                  satisfied,
                                  OTA service discovered,
                                  WrChar discovered,
                                  NtfChar discovered
                                  NtfChar configured correctly.
 
                                  STATE_OTA_CONFIRM_FAILED
 *
 *****************************************************************
 */

-(void)didOtaEnableConfirm : (CBPeripheral *)aPeripheral
                withStatus : (enum otaEnableResult) otaEnableStatus;

@end

/// ota Api output to app delegate protocol
@protocol otaApiUpdateAppDataDelegate

/**
 ****************************************************************************************
 * @brief       Update the result of the meta data sent.
 *
 * @param[out]  otaMetaDataSentStatus : the status of the meta data sent. 
 *                                      OTA_RESULT_SUCCESS | OTA_RESULT_DEVICE_NOT_SUPPORT_OTA
 * @ref         enum otaResult definitions
 *
 * @return : none
 ****************************************************************************************
 */

-(void)didOtaMetaDataResult : (enum otaResult)otaMetaDataSentStatus;

/**
 ****************************************************************************************
 * @brief       Update the result of the package sent.
 *
 * @param[out]  otaPackageSentStatus : the status of the package sent.
 * @param[out]  otaDataSent          : nsdata with these values (enum otaResult). 
 *
 * @ref         enum otaResult definitions
 *
 * @return : none
 ****************************************************************************************
 */
-(void)didOtaAppProgress : (enum otaResult)otaPackageSentStatus
            withDataSent : (uint16_t)otaDataSent;


/**
 ****************************************************************************************
 * @brief OTA Api output the final result .
 *
 * @param[out]  apiResult : the OTA final status.
 *
 * @ref : enum otaApiResult definition
 ****************************************************************************************
 */
-(void)didOtaAppResult : (enum otaResult )otaResult;

@end

/// ota api interface
@interface otaApi : NSNotificationCenter<bleUpdateForOtaDelegate>
{

}

/// delegate update Ota Result/ ota dataRate/Ota Progressbar value.
@property (nonatomic, assign) id <otaApiUpdateAppDataDelegate> otaApiUpdateAppDataDelegate;
@property (nonatomic, assign) id <otaEnableConfirmDelegate> otaEnableConfirmDelegate;
/**
 ****************************************************************************************
 * @brief  to load new firmware .
 *
 * @param[in]  aPeripheral    : the OTA peripheral connected.
 * @param[in]  firmwareAddr   : the firmware header address.
 * @param[in]  firmwareLength : the firmware length.
 * @param[in]  fResume        : whether it is resumed.
 *
 * @return     Result : Failed ( = OTA_FIRMWARE_ERROR)
 *                      Success ( = OTA_FIRMWARE_NO_ERROR)
 *
 * @ref    otaLoadFileResult definition
 ****************************************************************************************
 */
-(enum otaLoadFileResult)otaStart : (CBPeripheral *)aPeripheral
                     withDataByte : (const uint8_t *)firmwareAddr
                       withLength : (uint32_t)firmwareLength
                         withFlag : (BOOL)fResume;

/**
 ****************************************************************************************
 * @brief OTA class method.
 *
 * @param[out] all methods
 *
 ****************************************************************************************
 */
+ (otaApi *)sharedInstance;

@end

#endif