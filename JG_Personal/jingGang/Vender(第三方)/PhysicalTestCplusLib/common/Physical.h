//
// Created by huan on 2015/7/27.
//

#ifndef YES_PHYSICAL_H
#define YES_PHYSICAL_H

#include <string>

#include "../common/AverageHelper.h"
#include "../common/common.h"
#include "../heartrate/HeartRate.h"
#include "../bloodoxygen/BloodOxygen.h"
#include "../bloodpressure/BloodPressure2.h"
#include "../vitalcapacity/VitalCapacity.h"

enum MODE {
    MODE_HEART_RATE = 0,
    MODE_BLOOD_PRESSURE,
    MODE_BLOOD_OXYGEN,
    MODE_VITAL_CAPACITY
};

enum WAVE_TYPE {
    WAVE_TYPE_UP = 0,
    WAVE_TYPE_DOWN
};

class ICommonListener {
public:
    virtual void onHeartBeat() = 0;
    virtual void onError() = 0;
};

class IHeartRateListener : public IHeartRateCallback, public ICommonListener {
public:
};

class IBloodPressureListener : public IBloodPressureCallback, public ICommonListener {
public:
};

class IBloodOxygenListener : public IBloodOxygenCallback, public ICommonListener {
public:
};

class IVitalCapacityListener : public IVitalCapacityCallback {
public:
};

class Physical : public IHeartRateCallback, public IBloodPressureCallback, public IBloodOxygenCallback, IVitalCapacityCallback {
public:
    Physical();
    ~Physical();

    void startHeartRate(IHeartRateListener* pListener);
    void startBloodPressure(IBloodPressureListener* pListener);
    void startBloodOxygen(IBloodOxygenListener* pListener);
    void startVitalCapacity(IVitalCapacityListener* pListener);

    void update(float factor, long long time);

    std::string getString();

private:
    bool checkIsHeartBeat(float avg, float factor);
    void onHeartBeat();

    virtual void onUpdateRate(int rate);
    virtual void onFinalRate(int rate);

    virtual void onUpdatePressure(int low, int high);
    virtual void onFinalPressure(int low, int high);

    virtual void onUpdateBloodOxygen(int percent);
    virtual void onFinalBloodOxygen(int percent);

    virtual void onUpdateCapacity(int capacity);

private:
    int m_iMax;
    int m_iMin;

private:
    MODE m_mode;
    WAVE_TYPE m_waveType;

    AverageHelper*      m_pAverageHelper;
    HeartRate*          m_pHeartRate;
    BloodPressure2*     m_pBloodPressure;
    BloodOxygen*        m_pBloodOxygen;
    VitalCapacity*      m_pVitalCapacity;

    IHeartRateListener*         m_pHeartRateListener;
    IBloodPressureListener*     m_pBloodPressureListener;
    IBloodOxygenListener*       m_pBloodOxygenListener;
    IVitalCapacityListener*     m_pVitalCapacityListener;
};

#endif //YES_PHYSICAL_H
