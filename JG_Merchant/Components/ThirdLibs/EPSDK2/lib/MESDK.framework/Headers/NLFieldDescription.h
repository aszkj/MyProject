//
//  NLFieldDescription.h
//  MTypeSDK
//
//  Created by su on 13-6-24.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NLSerializer.h>
#import <NLPaddingType.h>
#import <NLInstructionField.h>
// TODO
@interface NLFieldDescription : NSObject
@property (nonatomic,copy, readonly) NSString *field;
@property (nonatomic,copy, readonly) NSString *name;
@property (nonatomic,copy, readonly) NSData *type;
@property (nonatomic,copy, readonly) id<NLSerializer> serializer;
@property (nonatomic,readonly) int index;
@property (nonatomic,readonly) int maxLen;
@property (nonatomic,readonly) int fixLen;
@property (nonatomic,readonly) NLPaddingType paddingType;
@property (nonatomic,readonly) Byte padding;
- (id)initWithFieldName:(NSString*)fieldName instructionField:(NLInstructionField*)field serializer:(id<NLSerializer>)serializer;
@end
