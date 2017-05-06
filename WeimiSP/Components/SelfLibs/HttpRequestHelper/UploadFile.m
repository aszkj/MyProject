//
//  UploadFile.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/21.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "UploadFile.h"
#import <JSONModel.h>
#import <AFNetworking.h>
#import <WEMEFileuploadcontrollerApi.h>
#import "FileMangeHelper.h"
#import <AddressBook/AddressBook.h>
#import <WEMEClient/WEMEUsercontrollerApi.h>
#import "NSString+Teshuzifu.h"
#import "UIImage+ImageEffects.h"

@implementation UploadFile
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        randomIDStr = @"itcast";
        uploadID = @"uploadFile";
    }
    return self;
}

+ (UploadFile *)shareInstance
{
    static UploadFile *_this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[UploadFile alloc] init];
    });
    return _this;
}

#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data
{
    UIImage * image = [UIImage imageNamed:@"msg_record_01"];
    data = UIImageJPEGRepresentation(image, 0.5);

    // 1> 数据体
    NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:@"头像1.png"];
    NSString *bottomStr = [self bottomString];
    
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
    }];
}

-(NSString *)getChannelInfoWithChannel:(NSString *)channel url:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];

    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *receiveStr = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    return receiveStr;
    
}

-(void)sendMessageWithDictionary:(NSDictionary *)dic url:(NSString *)url {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //传入的参数
    NSDictionary *parameters = dic;
    //发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//
//#pragma mark - 上传文件
//-(void)upLoadFileWithURL:(NSString *)url data:(NSData *)data type:(NSString *)type{
//
//    UIImage *image = [UIImage imageNamed:@"arrow"];
//    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
//
//    NSString *audioFile=[[NSBundle mainBundle] pathForResource:@"arrow.png" ofType:nil];
//    
//    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //图片 url + image
//    //音频 url + audio
//    //视频 url + video
//    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//
//    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"IMAGE", nil] forKeys:[NSArray arrayWithObjects:@"fileType",nil]];
//    
//    [manager POST:@"http://192.168.1.80:8090/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        [formData appendPartWithFileData:imgData name:@"file"
//                                fileName:@"file" mimeType:@"image/png"];
//
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
//}

//#pragma mark - 上传文件
-(void)upLoadFileWithURL:(NSString *)url data:(NSData *)data type:(IMUploadFileType)type uploadFileSuccess:(UploadFileComplate)uploadFileSuccess {

    self.uploadFileSuccess = uploadFileSuccess;
    NSString *typeString = @"IMAGE";
    NSString *bodyType = @"image/jepg";
    
    //    //图片 url + image
    //    //音频 url + audio
    //    //视频 url + video
    if (type == IMImageUploadFileType) {
        typeString = @"IMAGE";
        bodyType = @"image/jpeg";
    } else if (type == IMAudioUploadFileType) {
        typeString = @"AUDIO";
        bodyType = @"audio/mp3";
    } if (type == IMVideoUploadFileType) {
        typeString = @"VIDEO";
        bodyType = @"video/mp4";
    }
    
    //字典里面装的是你要上传的内容
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:typeString, nil] forKeys:[NSArray arrayWithObjects:@"fileType",nil]];
    //上传的接口
    NSString* urlstring = url;
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:10];
    
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //	//要上传的图片
    //	UIImage *image=[params objectForKey:@"pic"];
    //得到图片的data
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [parameters allKeys];
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        if(![key isEqualToString:@"pic"])
        {
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[parameters objectForKey:key]];
        }
    }
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"uploadFile\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: %@\r\n\r\n",bodyType];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", (int)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //建立连接，设置代理
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //设置接受response的data
    if (conn) {
        _mResponseData = [[NSMutableData alloc] init];
    }
}


#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_mResponseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mResponseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:_mResponseData options:kNilOptions error:nil];
    
    if (dic && _uploadFileSuccess) {
        _uploadFileSuccess(dic);
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}


-(void)uploadImageWithUIImage:(UIImage *)selectedImg succeedBlock:(UploadImageSuccedBlock)block
{
    // save image in local
    UIImage *newImg = [selectedImg imageCompress];
//    NSData *data = UIImageJPEGRepresentation(selectedImg, 0.3);
//    UIImage *newImg = [UIImage imageWithData:data];
    NSString *fileName = [[FileMangeHelper shareInstance] saveUploadImageWithImage:newImg];
    
//    CGSize imgRect = [Util resetImageSizeFromSourceSize:newImg.size maxWidth:KImageWidth maxHeight:KImageHeight];
//    
//    CGFloat scale = selectedImg.scale;
    
    
    [[WEMEFileuploadcontrollerApi sharedAPI] uploadFileUsingPOSTWithCompletionBlock:@"IMAGE" file:[NSURL fileURLWithPath:fileName] completionHandler:^(NSString *output, NSError *error) {
        if(!error) {
            NSData *jsonData = [output dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&err];
            if (!err)
            {
                block(resultDic[@"url"]);
            }
        }
        else
        {
            [Util ShowAlertWithOnlyMessage: @"图片上传失败"];
        }
    }];

     
}

//上次图片、语音
-(void)uploadImageWithFileName:(NSString *)fileName withType:(NSString *)type succeedBlock:(UploadImageSuccedBlock)block failure:(FailureBlock)failure
{
    UploadFileType uploadType;
    if ([type isEqualToString:@"IMAGE"])
    {
        uploadType = UploadFileImageType;
    }
    else
    {
        uploadType = UploadFileAudioType;
    }
    NSString *localPath = [[FileMangeHelper shareInstance] getUploadFilePathFromFileType:uploadType fileName:fileName];
//    UIImage *image = [UIImage imageWithContentsOfFile:localPath];
    [[WEMEFileuploadcontrollerApi sharedAPI] uploadFileUsingPOSTWithCompletionBlock:type file:[NSURL fileURLWithPath:localPath] completionHandler:^(NSString *output, NSError *error) {
        if(!error) {
            NSData *jsonData = [output dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&err];
            if (!err)
            {
                block(resultDic[@"url"]);
            }
        }
        else
        {
//            [Util ShowAlertWithOnlyMessage: @"图片上传失败"];
            NSLog(@"文件上传失败");
            failure(@"文件上传失败");
        }
    }];
}

- (void)uploadAddressBook {
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted) {
        // if you got here, user had previously denied/revoked permission for your
        // app to access the contacts, and all you can do is handle this gracefully,
        // perhaps telling the user that they have to go to settings to grant access
        // to contacts
        
//        [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (!addressBook) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        return;
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (error) {
            NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
        }
        
        if (granted) {
            // if they gave you permission, then just carry on
            NSArray *phonesList = [self listPeopleInAddressBook:addressBook];
            [[WEMEUsercontrollerApi sharedAPI] addressbookUsingPOSTWithCompletionBlock:phonesList completionHandler:^(WEMESimpleResponse *output, NSError *error) {
                
                DDLogInfo(@"上传通讯录:%@ error:%@",output,error);
            }];
        } else {
            // however, if they didn't give you permission, handle it gracefully, for example...
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // BTW, this is not on the main thread, so dispatch UI updates back to the main queue
                
//                [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        }
    
        CFRelease(addressBook);
    });
    
    
}

- (NSArray *)listPeopleInAddressBook:(ABAddressBookRef)addressBook
{
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSMutableArray *phonesList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < allPeople.count; i++) {
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
//        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
//        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
//        NSLog(@"Name:%@ %@", firstName, lastName);
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
        for (CFIndex i = 0; i < numberOfPhoneNumbers; i++) {
            NSString *phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
            phoneNumber = [phoneNumber numberValue];
//            NSLog(@"  phone:%@", phoneNumber);
            if (phoneNumber != nil) {
                [phonesList addObject:phoneNumber];
            }
        }
        
        CFRelease(phoneNumbers);
    }
    return phonesList.copy;
}

@end
