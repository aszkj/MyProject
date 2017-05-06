#ifndef YES_HEARTRATE_H
#define YES_HEARTRATE_H

#define BEAT_MAX 5
#define MIN_MS (1000 * 60)

#include "../common/AverageHelper.h"
//#include "../common/common.h"


class IHeartRateCallback {
public:
    virtual void onUpdateRate(int rate) = 0;
    virtual void onFinalRate(int rate) = 0;
};

class HeartRate {
public:
    HeartRate(IHeartRateCallback* pCallback);
    ~HeartRate();

    void reset();
    void heartBeat(long long currentTime);

private:
    void invokeFinalRateCallback(int rate);
    void invokeUpdateRateCallback(int rate);

private:
    bool m_bIsStable;

    long long m_nStartTime;
    long long m_nLastTimeStamp;
    long long m_nLastIntervalOfOneBeat;

    long long m_nStableIntervalOfOneBeat;

    int m_iPreStableCount;
    int m_iBeatCount;

    int m_iLastBeatRate;

    AverageHelper* m_pAverageHelper;
    IHeartRateCallback* m_pCallback;
};

#endif //YES_HEARTRATE_H
