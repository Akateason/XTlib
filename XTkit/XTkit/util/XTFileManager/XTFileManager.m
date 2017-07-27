//
//  MyFileManager.m
//  JGB
//
//  Created by teason on 14-10-29.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "XTFileManager.h"
#include <sys/stat.h>
#include <dirent.h>


@interface XTFileManager (Private)
+ (long long)_folderSizeAtPath:(const char *)folderPath ;
@end


@implementation XTFileManager
//创建文件夹
+ (void)createFileBoxesWithPath:(NSString *)pathStr {
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",pathStr] ;
    BOOL isDir = NO ;
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
    BOOL existed = [fileManager fileExistsAtPath:filePath
                                     isDirectory:&isDir] ;
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:filePath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil] ;
    }
}

//判断文件名存在吗
+ (BOOL)isFileExist:(NSString *)path {
    NSFileManager *file_manager = [NSFileManager defaultManager] ;
    return [file_manager fileExistsAtPath:path] ;
}

//单个文件的大小
+ (long long)getSize:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager] ;
    if ([manager fileExistsAtPath:filePath]) return [[manager attributesOfItemAtPath:filePath error:nil] fileSize] ;
    return 0;
}

//删除文件
+ (BOOL)deleteFile:(NSString *)fileName {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL bREsult = [fm removeItemAtPath:fileName error:nil] ;
    //NSLog(@"fileName : %@ \n delete : %d",fileName,bREsult) ;
    return bREsult ;
}

//保存图片
+ (void)savingPicture:(UIImage *)picture path:(NSString *)path {
    NSData *data = UIImageJPEGRepresentation(picture,1) ;
    [[NSFileManager defaultManager] createFileAtPath:path
                                            contents:data
                                          attributes:nil] ;
}

// 方法1：使用NSFileManager来实现获取文件大小
+ (long long)fileSizeAtPath1:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

// 方法1：使用unix c函数来实现获取文件大小
+ (long long)fileSizeAtPath2:(NSString*) filePath {
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}


#pragma mark 获取目录大小

// 方法1：循环调用fileSizeAtPath1
+ (long long)folderSizeAtPath1:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        if ([self fileSizeAtPath1:fileAbsolutePath] != [self fileSizeAtPath2:fileAbsolutePath]){
            NSLog(@"%@, %lld, %lld", fileAbsolutePath,
                  [self fileSizeAtPath1:fileAbsolutePath],
                  [self fileSizeAtPath2:fileAbsolutePath]);
        }
        folderSize += [self fileSizeAtPath1:fileAbsolutePath];
    }
    return folderSize;
}

// 方法2：循环调用fileSizeAtPath2
+ (long long)folderSizeAtPath2:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath2:fileAbsolutePath];
    }
    return folderSize;
}

// 方法3：完全使用unix c函数
+ (long long)folderSizeAtPath3:(NSString*) folderPath {
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}

@end




@implementation XTFileManager(Private)

+ (long long)_folderSizeAtPath:(const char*)folderPath {
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        unsigned long folderPathLength = strlen(folderPath) ;
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

@end

