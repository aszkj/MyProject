//
//  BloodOXyenListener.h
//  jingGang
//
//  Created by 张康健 on 15/7/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#ifndef __jingGang__BloodOXyenListener__
#define __jingGang__BloodOXyenListener__

#include <stdio.h>
#include "../common/Physical.h"

class  BloodOXyenListener:public IBloodOxygenListener{
  
public:
    int currentBloxenPercent;
    int finalBloxenPercent;
    bool isError;
    int  heartePalpitae;

    
public:
    BloodOXyenListener();
    void onHeartBeat();
    void onError();
    void onUpdateBloodOxygen(int percent);
    void onFinalBloodOxygen(int percent);
    
};

#endif /* defined(__jingGang__BloodOXyenListener__) */
