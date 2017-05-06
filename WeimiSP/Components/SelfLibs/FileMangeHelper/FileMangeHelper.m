//
//  FileMangeHelper.m
//  FileMangeHelper
//
//  Created by 鹏 朱 on 15/10/13.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "FileMangeHelper.h"
#import "FileDownload.h"
#import "ZipArchive.h"
#import "NSString+Teshuzifu.h"

@implementation FileMangeHelper

+ (FileMangeHelper *)shareInstance
{
    static FileMangeHelper *_this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[FileMangeHelper alloc] init];
    });
    return _this;
}

- (NSString *)homeFolder
{
    return NSHomeDirectory();
}

- (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (NSString *)tempFolder
{
    NSString * tem= NSTemporaryDirectory();
    return tem;
}

- (NSString *)documentsFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (NSString *)getResourcePathWithName:(NSString *)name type:(NSString *)type;
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return path;
}

- (NSString *)libPrefPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

- (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

- (NSString *)getFileFolderUnderDocuments:(NSString *)fileName
{
    NSString *path = [[self documentsFolder] stringByAppendingPathComponent:fileName];
    return path;
}

- (BOOL)createFolderUnderDocuments:(NSString *)fileName
{
    NSString *documentsDirectory = [[self documentsFolder] stringByAppendingPathComponent:fileName];
    if (![self isFileExistsAtPath:documentsDirectory])
    {
        NSError *err = nil;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&err];
        
        if (err) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)isFileExistsAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path])
    {
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)createDatabaseFolder
{
    NSString *documentsDirectory = [[self documentsFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/DataBase"]];
    NSLog(@"db:%@",documentsDirectory);
    if (![self isFileExistsAtPath:documentsDirectory])
    {
        NSError *err = nil;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&err];
        
        if (err) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)createUploadFolderWithFileType:(UploadFileType)fileType
{
    NSString *documentsDirectory = [[self documentsFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Upload/%@",[self getUploadFileTypeName:fileType]]];
    if (![self isFileExistsAtPath:documentsDirectory])
    {
        NSError *err = nil;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&err];
        
        if (err) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)getDataBasePath
{
    NSString *documentsDirectory = [[self documentsFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/DataBase/%@",DBSuffix_C]];
    
    return documentsDirectory;
}

- (NSString *)getUploadFileTypeName:(UploadFileType)fileType {
    
    NSString *typeName = @"IMAGE";
    if (fileType == UploadFileImageType) {
        typeName = @"IMAGE";
    } else if (fileType == UploadFileAudioType) {
        typeName = @"AUDIO";
    } else if (fileType == UploadFileVideoType) {
        typeName = @"VIDEO";
    } else if (fileType == UploadFileZipType) {
        typeName = @"ZIP";
    }
    
    return typeName;
}

- (NSString *)getDownloadPathFromFileType:(UploadFileType)fileType
{
    NSString *documentsDirectory = [[self documentsFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/%@",[self getUploadFileTypeName:fileType]]];
    
    return documentsDirectory;
}

////获取下载文件
- (NSString *)getDownloadHtmlFilePathFromFileType:(UploadFileType)fileType documentName:(NSString *)documentName {
    
    NSString *localPath = [self getDownloadPathFromFileType:fileType];
    
    localPath = [[[localPath stringByAppendingPathComponent:documentName] stringByAppendingPathComponent:@"html"] stringByAppendingString:@"/index.html"];
    
    return localPath;
}

////获取上传文件
- (NSString *)getUploadFilePathFromFileType:(UploadFileType)fileType fileName:(NSString *)fileName {
    
    
    NSString *filePath = [[self getUploadPathFromFileType:fileType] stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    
    return filePath;
}

- (NSString *)getUploadPathFromFileType:(UploadFileType)fileType
{
    NSString *documentsDirectory = [[self documentsFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"/Upload/%@",[self getUploadFileTypeName:fileType]]];
    
    return documentsDirectory;
}

- (void)createFileDirectoryPath:(NSString *)savePath {
    
    //检查本地目录是否已存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:savePath]) {
        [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)createFilePath:(NSString *)savePath {
    
    //检查本地目录是否已存在
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:savePath]) {
        [fileManager createFileAtPath:savePath contents:nil attributes:nil];
    }
}

- (BOOL)copyFileWithFromPath:(NSString *)sourcePath toPath:(NSString *)toPath fileName:(NSString *)fileName{
    
    [self createFileDirectoryPath:toPath];
    
//    删除尾部的扩展名
//    
//    3、-(NSString *)stringByAppendingPathExtension:(NSString *)str
//    
//    在尾部添加一个扩展名
    
    fileName = [fileName stringByAppendingPathExtension:[sourcePath pathExtension]];
    NSString * finalPath = [toPath stringByAppendingPathComponent:fileName];
    
    BOOL retVal = YES;
    retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalPath error:nil];
    
    return retVal;
}

- (NSString *)saveUploadImageWithImage:(UIImage *)image {
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png",[NSString getUniqueStrByUUID]] ;
    [self createUploadFolderWithFileType:UploadFileImageType];
    NSString *filePath = [[self getUploadPathFromFileType:UploadFileImageType] stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];

    BOOL result = [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
    if (result) {
        return filePath;
    }
    
    return nil;
}

/**
 * 下载文件
 */
- (void)downloadFileURL:(NSString *)urlString savePath:(NSString *)localPath documentName:(NSString *)documentName completion:(void (^)(NSString *))completion
{
    localPath = [localPath stringByAppendingPathComponent:documentName];
    [self createFileDirectoryPath:localPath];
    
    NSString *fileName = [NSString stringWithFormat:@"download.%@",[urlString pathExtension]];
    NSString * finalPath = [localPath stringByAppendingPathComponent:fileName];

    [[FileDownload shareInstance] downloadFileWithURL:urlString fileName:finalPath completion:^(NSData *data) {
        
        [self scriptUnZip:data localPath:localPath];
        
        if (completion) {
            NSString *htmlFile = [self getDownloadHtmlFilePathFromFileType:UploadFileZipType documentName:documentName];
            completion(htmlFile);
        }
    }];
}

// 解压zip
- (void)scriptUnZip:(NSData *)zipdata localPath:(NSString *)localPath{
    
    NSString *temPath = localPath;
    NSString *zipfile = [NSString stringWithFormat:@"%@download_video_analyze_script",localPath];
    [zipdata writeToFile:zipfile atomically:NO];
    
    BOOL bexist = [[NSFileManager defaultManager] fileExistsAtPath:zipfile];
    if (!bexist) {
        return;
    }
    ZipArchive *ziparchine = [[ZipArchive alloc] init];
    if (![ziparchine UnzipOpenFile:zipfile]) {
        NSLog(@"解压失败");
        return;
    }
    if (![ziparchine UnzipFileTo:temPath overWrite:YES]) {
        NSLog(@"解压失败");
        return;
    }
    
    [ziparchine UnzipCloseFile];
}


#pragma mark WriteFile End


@end

