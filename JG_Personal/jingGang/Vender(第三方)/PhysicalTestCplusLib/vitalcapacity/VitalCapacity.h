//
// Created by huan on 2015/7/29.
//

#ifndef YES_VITALCAPACITY_H
#define YES_VITALCAPACITY_H

#include "../common/common.h"

#define STEP_MAX 2

class IVitalCapacityCallback {
public:
    virtual void onUpdateCapacity(int capacity) = 0;
};

class VitalCapacity {
public:
    VitalCapacity(IVitalCapacityCallback* pCallback);
    ~VitalCapacity();

    void reset();
    void update(int factor, long long time);
    int getCapacity();

private:
    IVitalCapacityCallback* m_pCallback;

    int             m_iSum;
    int             m_iStepIndex;
    long long      m_nStartTime;

    int             m_iCapacity;
};

#endif //YES_VITALCAPACITY_H
