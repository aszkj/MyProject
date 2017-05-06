//
//  BloodPressureListener.h
//  摄像头区域定制测试
//
//  Created by 张康健 on 15/7/29.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#ifndef _____________BloodPressureListener__
#define _____________BloodPressureListener__

#include <stdio.h>
#include "../common/Physical.h"

class BloodPressureListener : public IBloodPressureListener{
public:
    bool isError;               //是否有错误
    int  heartePalpitae;        //第几次心跳
    int  currentLowPressure;    //当前最低血压
    int  currentHightPressure;  //当前最高血压
    int  finalLowPressure;      //最终最低血压
    int  finalHightPressure;    //最终最高血压
    
public:
    BloodPressureListener();
    void onHeartBeat();
    void onError();
    void onUpdatePressure(int low, int high);
    void onFinalPressure(int low, int high);
    
};


#endif /* defined(_____________BloodPressureListener__) */
