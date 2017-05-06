//
//  JGDESUtils.h
//  des
//
//  Created by dengxf on 16/1/22.
//
//

#import <Foundation/Foundation.h>

@interface JGDESUtils : NSObject

/****** 加密 ******/
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
/****** 解密 ******/
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;


@end
