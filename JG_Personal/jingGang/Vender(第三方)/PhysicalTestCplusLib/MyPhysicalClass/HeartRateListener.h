//
//  HeartRateListener.h
//  CplusTestClass
//
//  Created by 张康健 on 15/7/28.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#ifndef __CplusTestClass__HeartRateListener__
#define __CplusTestClass__HeartRateListener__

#include <stdio.h>
#include "../common/Physical.h"

class HeartRateListener : public IHeartRateListener{
public:
    int currentRate;
    int finalRate;
    bool isError;
    int  heartePalpitae;
    
    
public:
    HeartRateListener();
    void onHeartBeat();
    void onError();
    void onUpdateRate(int rate);
    void onFinalRate(int rate);
    
};


#endif /* defined(__CplusTestClass__HeartRateListener__) */
