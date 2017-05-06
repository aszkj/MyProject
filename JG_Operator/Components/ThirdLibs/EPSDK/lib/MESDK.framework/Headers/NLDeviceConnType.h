//
//  NLDeviceConnType.h
//  mpos
//
//  Created by su on 13-6-20.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#ifndef mpos_NLDeviceConnType_h
#define mpos_NLDeviceConnType_h

/**
 * 设备连接类型<p>
 *
 * 对于给定连接类型,无论是<tt>蓝牙</tt>,<tt>USB</tt>,<tt>音频口</tt>或者是<tt>k21</tt>采用的<tt>Android Service</tt>方式连接，
 * 都应该期望具有相同的通信方式。<p>
 *
 * 例如:蓝牙,可能是一个<tt>BlueTooth Socket</tt>连接和一个基于字节流的通信流程,而一个K21的连接器,可能是一个基于动态的代理的实现。<p>
 *
 * 这里统一定义所有需要统一的接口描述,对于给定设备，需要在连接层面上使用标准的连接协议，均可以让{@link DeviceDriver}返回对应支持的连接类型<p>
 *
 * 对于特定场合，使用{@link #SELFDEFINED}，例如k21连接器。
 *
 *
 *
 */
typedef enum {
    /**
	 * 音频口连接,版本v1.0.0
	 */
    NLDeviceConnTypeAudioInOutV100,
    /**
	 * 蓝牙连接，版本v1.0.0
	 */
    NLDeviceConnTypeBlueToothV100,
    /**
	 * USB连接，版本v1.0.0
	 */
    NLDeviceConnTypeUSBV100,
    /**
	 * 自定义连接类型
	 */
    NLDeviceConnTypeSelfDefined
} NLDeviceConnType;

#endif
