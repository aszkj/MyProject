#ifndef YES_AVERAGEHELPER_H
#define YES_AVERAGEHELPER_H

#include <list>

class AverageHelper {
public:
    AverageHelper(int max);
    ~AverageHelper();

    float add(float value);
    void reset();

private:
    std::list<float> m_listValue;

    float m_sum;

    int m_iMax;
};

#endif //YES_AVERAGEHELPER_H
