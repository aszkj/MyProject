//
//  VitalCapacityListener.h
//  jingGang
//
//  Created by 张康健 on 15/7/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#ifndef __jingGang__VitalCapacityListener__
#define __jingGang__VitalCapacityListener__

#include <stdio.h>
#include "../common/Physical.h"

class VitalCapacityListener : public IVitalCapacityListener{

public:
    int finalLungCapacity;
    
public:
    VitalCapacityListener();
    void onUpdateCapacity(int capacity);
};

#endif /* defined(__jingGang__VitalCapacityListener__) */
