#ifndef YES_BLOODPRESSURE2_H
#define YES_BLOODPRESSURE2_H

class IBloodPressureCallback {
public:
    virtual void onUpdatePressure(int low, int high) = 0;
    virtual void onFinalPressure(int low, int high) = 0;
};

class BloodPressure2 {
public:
    BloodPressure2(IBloodPressureCallback* pListener);
    ~BloodPressure2();

    void reset();
    void update(int max, int min);

private:
    void analyze(int max, int min);

private:
    IBloodPressureCallback* m_pListener;

    int m_iLastLow;
    int m_iLastHigh;

    int m_iStableCount;
};


#endif //YES_BLOODPRESSURE2_H
