//
//  NLMacros.h
//  MTypeSDK
//
//  Created by su on 14-4-11.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef NL_DEPRECATED_API
    #ifdef __clang__
        #define NL_DEPRECATED_API __attribute__ ((deprecated("No longer required.")))
    #else
        #define NL_DEPRECATED_API __attribute__ ((deprecated()))
    #endif
#endif
#ifndef NL_DEPRECATED_AT
    #ifdef __clang__
        #define NL_DEPRECATED_AT(_iosDep) __attribute__ ((deprecated("Deprecated at.")))
    #else
        #define NL_DEPRECATED_AT(_iosDep) __attribute__ ((deprecated()))
    #endif
#endif

// todo
#ifndef NL_NOT_SUPPORTED
    #ifdef __clang__
        #define NL_NOT_SUPPORTED
    #else
        #define NL_NOT_SUPPORTED
    #endif
#endif


#if !defined(NL_INLINE)
# if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#  define NL_INLINE static inline
# elif defined(__cplusplus)
#  define NL_INLINE static inline
# elif defined(__GNUC__)
#  define NL_INLINE static __inline__
# else
#  define NL_INLINE static
# endif
#endif /* !defined(NL_INLINE) */



#if !defined(NL_EXTERN)
#  if defined(__cplusplus)
#   define NL_EXTERN extern "C"
#  else
#   define NL_EXTERN extern
#  endif
#endif /* !defined(NL_EXTERN) */