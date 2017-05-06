//
//  NLSecondIssuanceRequest.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLAbstractEmvPackage.h"

@interface NLSecondIssuanceRequest : NLAbstractEmvPackage<NLEmvTagDefinedDataSource>
@property (nonatomic, strong) NSString *authorisationResponseCode;
@property (nonatomic, strong) NSData *issuerScriptTemplate1;
@property (nonatomic, strong) NSData *issuerScriptTemplate2;
@property (nonatomic, strong) NSData *issuerAuthenticationData;
@end
