//
//  FileMangeHelper.h
//  FileMangeHelper
//
//  Created by 鹏 朱 on 15/10/13.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DBSuffix_C @"baiying.sqlite"

typedef enum : NSInteger {
    
    AudioNormalType = -1,        //文字
    UploadFileImageType = 1,     //图片
    UploadFileAudioType = 2,     //音频
    UploadFileVideoType = 3,     //视频
    UploadFileZipType = 4,       //压缩包
    
} UploadFileType; //明细控制器类型

@interface FileMangeHelper : NSObject

+ (FileMangeHelper *) shareInstance;

//主目录
- (NSString *)homeFolder;

// 程序目录，不能存任何东西
- (NSString *)appPath;

//临时缓存目录，APP退出后，系统可能会删除这里的内容
- (NSString *)tempFolder;

//文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
- (NSString *)documentsFolder;

//配置目录，配置文件存这里
- (NSString *)libPrefPath;

//缓存目录，系统永远不会删除这里的文件，ITUNES会删除
- (NSString *)libCachePath;

//取得Documents中某个文件的路径
- (NSString *)getFileFolderUnderDocuments:(NSString *)fileName;

// 获取当前程序包中一个图片资源路径
- (NSString *)getResourcePathWithName:(NSString *)name type:(NSString *)type;

//创建DocumentDirectory下面的目录
- (BOOL)createFolderUnderDocuments:(NSString *)fileName;

//创建数据库目录
- (BOOL)createDatabaseFolder;

//创建文件上传目录
- (BOOL)createUploadFolderWithFileType:(UploadFileType)fileType;

//判断目录下的文件是否存在
- (BOOL)isFileExistsAtPath:(NSString *)path;

//获取数据库目录
- (NSString *)getDataBasePath;

//获取文件上传目录
- (NSString *)getUploadPathFromFileType:(UploadFileType)fileType;

////获取文件下载目录
- (NSString *)getDownloadPathFromFileType:(UploadFileType)fileType;

////获取文件上传目录
- (NSString *)getUploadFilePathFromFileType:(UploadFileType)fileType fileName:(NSString *)fileName;

////获取下载文件
- (NSString *)getDownloadHtmlFilePathFromFileType:(UploadFileType)fileType documentName:(NSString *)documentName;

- (void)createFileDirectoryPath:(NSString *)savePath;

- (void)createFilePath:(NSString *)savePath;

- (BOOL)copyFileWithFromPath:(NSString *)sourcePath toPath:(NSString *)toPath fileName:(NSString *)fileName;

/**
 * 下载文件
 */
- (void)downloadFileURL:(NSString *)urlString savePath:(NSString *)localPath documentName:(NSString *)documentName completion:(void (^)(NSString *))completion;

- (NSString *)saveUploadImageWithImage:(UIImage *)image;

@end
