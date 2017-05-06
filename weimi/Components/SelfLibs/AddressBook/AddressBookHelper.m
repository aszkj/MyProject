//
//  AddressBookHelper.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/20.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "AddressBookHelper.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "NSString+Teshuzifu.h"

@implementation AddressBookHelper

+ (NSDictionary *)getAllContact
{
    NSMutableDictionary *contactDic = [NSMutableDictionary dictionary];
    
    ABAddressBookRef tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (tmpAddressBook==nil) {
        return nil;
    };
    CFArrayRef allPeoples = ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(tmpAddressBook);
    for (int i = 0; i < nPeople; i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(allPeoples, i);
        NSString *fullName = (__bridge_transfer NSString *)ABRecordCopyCompositeName(person);
        if (IsEmpty(fullName)) {
            fullName = @"未知";
        }
        
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSString *name = fullName;
        for(NSInteger j = 0; j < ABMultiValueGetCount(phones); j++)
        {
            NSString *personPhone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, j);
            personPhone = [personPhone telephoneWithReformat];
            [contactDic setObject:name forKey:personPhone];
        }
        CFRelease(phones);
    }
    CFRelease(allPeoples);
    CFRelease(tmpAddressBook);
    return [NSDictionary dictionaryWithDictionary:contactDic];
}

+ (NSString *)getPhones
{
    NSMutableString *userCustomerNames = [NSMutableString string];
    NSArray *allPhone = [[AddressBookHelper getAllContact] allKeys];
    for (int i = 0; i < allPhone.count; i++) {
        NSString *appendString;
        if (i == allPhone.count - 1) {
            appendString = [NSString stringWithFormat:@"%@",allPhone[i]];
        }
        else {
            appendString = [NSString stringWithFormat:@"%@,",allPhone[i]];
        }
        [userCustomerNames appendString:appendString];
    }
    return [NSString stringWithString:userCustomerNames];
}

+ (void)addPeopleWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber companyName:(NSString *)companyName department:(NSString *)department email:(NSString *)email headImg:(UIImage *)headImg
{
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //创建一条联系人记录
    ABRecordRef tmpRecord = ABPersonCreate();
    CFErrorRef error;
    //name
    CFStringRef tmpName = (__bridge_retained CFStringRef)name;
    ABRecordSetValue(tmpRecord, kABPersonFirstNameProperty, tmpName, &error);
    CFRelease(tmpName);
    //phone number
    CFTypeRef tmpPhones = (__bridge_retained CFStringRef)phoneNumber;
    ABMutableMultiValueRef tmpMutableMultiPhones = ABMultiValueCreateMutable(kABPersonPhoneProperty);
    ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, tmpPhones, kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(tmpRecord, kABPersonPhoneProperty, tmpMutableMultiPhones, &error);
    CFRelease(tmpPhones);
    //companyName
    CFStringRef tmpCompanyName = (__bridge_retained CFStringRef)companyName;
    ABRecordSetValue(tmpRecord, kABPersonOrganizationProperty, tmpCompanyName, &error);
    CFRelease(tmpCompanyName);
    //department
    CFStringRef tmpDepartment = (__bridge_retained CFStringRef)department;
    ABRecordSetValue(tmpRecord, kABPersonDepartmentProperty, tmpDepartment, &error);
    CFRelease(tmpDepartment);
    //email
    CFStringRef tmpEmail = (__bridge_retained CFStringRef)email;
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, tmpEmail, kABWorkLabel, NULL);
    ABRecordSetValue(tmpRecord, kABPersonEmailProperty, multiEmail, &error);
    CFRelease(multiEmail);
    //headImg
    NSData *data = UIImagePNGRepresentation(headImg);
    ABPersonSetImageData(tmpRecord, (__bridge_retained CFDataRef)data, &error);
    //保存记录
    ABAddressBookAddRecord(tmpAddressBook, tmpRecord, &error);
    CFRelease(tmpRecord);
    //保存数据库
    ABAddressBookSave(tmpAddressBook, &error);
    CFRelease(tmpAddressBook);
}

@end
