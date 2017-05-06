//
// Created by huan on 2015/7/29.
//

#ifndef YES_BLOODOXYGEN_H
#define YES_BLOODOXYGEN_H

#include "../common/common.h"
#include "../common/AverageHelper.h"

#define STABLE_MAX      200

class IBloodOxygenCallback {
public:
    virtual void onUpdateBloodOxygen(int percent) = 0;
    virtual void onFinalBloodOxygen(int percent) = 0;
};

class BloodOxygen {
public:
    BloodOxygen(IBloodOxygenCallback* pCallback);
    ~BloodOxygen();

    void reset();
    void update(int factor);

private:
    IBloodOxygenCallback* m_pCallback;

    AverageHelper* m_pAverageHelper;

    int m_iLastValue;
    int m_iStableCount;
};

#endif //YES_BLOODOXYGEN_H
