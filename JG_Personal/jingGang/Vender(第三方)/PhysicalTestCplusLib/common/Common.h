#ifndef YES_COMMON_H
#define YES_COMMON_H

//#define ANDROID_CUS_LOG    0

#include <stdlib.h>
#include <math.h>



#define TAG "android-jni"

#ifdef ANDROID_CUS_LOG
#include <android/log.h>
#define CLOGD(...) __android_log_print(ANDROID_LOG_DEBUG,TAG ,__VA_ARGS__)
#define CLOGI(...) __android_log_print(ANDROID_LOG_INFO,TAG ,__VA_ARGS__)
#define CLOGW(...) __android_log_print(ANDROID_LOG_WARN,TAG ,__VA_ARGS__)
#define CLOGE(...) __android_log_print(ANDROID_LOG_ERROR,TAG ,__VA_ARGS__)
#define CLOGF(...) __android_log_print(ANDROID_LOG_FATAL,TAG ,__VA_ARGS__)

#else

#define CLOGD(...)
#define CLOGI(...)
#define CLOGW(...)
#define CLOGE(...)
#define CLOGF(...)

#endif //ANDROID_CUS_LOG

#define AVG_MAX     15
#define FACTOR_MAX  255

#endif //YES_COMMON_H