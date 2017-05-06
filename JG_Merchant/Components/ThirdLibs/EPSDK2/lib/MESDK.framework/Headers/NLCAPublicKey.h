//
//  NLCAPublicKey.h
//  MTypeSDK
//
//  Created by su on 14-1-26.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractEmvPackage.h"
/*!
 @class
 @abstract 公钥对象
 @discussion
 */
/*!
 9f06 /rid
 9f22 /index
 df05 /expirationDate
 df06 /hashAlgorithmIndicator
 df07 /publicKeyAlgorithmIndicator
 df02 /modulus
 df04 /exponent
 df03 /sha1CheckSum
 */
@interface NLCAPublicKey : NLAbstractEmvPackage<NLEmvTagDefinedDataSource>
@property (nonatomic, strong) NSData *rid;
@property (nonatomic) int index;
@property (nonatomic, strong) NSString *expirationDate;
@property (nonatomic) int hashAlgorithmIndicator;
@property (nonatomic) int publicKeyAlgorithmIndicator;
/**
 * 公钥的n模
 */
@property (nonatomic, strong) NSData *modulus;
/**
 * 公钥的e指数
 */
@property (nonatomic, strong) NSData *exponent;
/**
 * 公钥指纹
 */
@property (nonatomic, strong) NSData *sha1CheckSum;
/**
 * 构造一个CA公钥<p>
 *
 * @param index 公钥索引
 * @param hashAlgorithmIndicator hash算法
 * @param publicKeyAlgorithmIndicator 公钥算法
 * @param modulus 公钥模数
 * @param exponent 公钥指数
 * @param sha1CheckSum 公钥指纹
 * @param expirationDate 公钥有效期限(格式yyyyMMdd)
 */
- (id)initWithIndex:(int)index hashAlgorithmIndicator:(int)hashAlgorithmIndicator publicKeyAlgorithmIndicator:(int)publicKeyAlgorithmIndicator modulus:(NSData*)modulus exponent:(NSData*)exponent sha1CheckSum:(NSData*)sha1CheckSum expirationDateString:(NSString*)expirationDate;
/**
 * 构造一个CA公钥<p>
 *
 * @param index 公钥索引
 * @param hashAlgorithmIndicator hash算法
 * @param publicKeyAlgorithmIndicator 公钥算法
 * @param modulus 公钥模数
 * @param exponent 公钥指数
 * @param sha1CheckSum 公钥指纹
 * @param expirationDate 公钥有效期限(格式yyyyMMdd)
 */
- (id)initWithIndex:(int)index hashAlgorithmIndicator:(int)hashAlgorithmIndicator publicKeyAlgorithmIndicator:(int)publicKeyAlgorithmIndicator modulus:(NSData *)modulus exponent:(NSData *)exponent sha1CheckSum:(NSData *)sha1CheckSum expirationDate:(NSDate *)expirationDate;
@end
