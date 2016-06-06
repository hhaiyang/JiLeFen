//
//  Sandbox.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Sandbox.h"

@interface Sandbox()
{
    NSString *	_appPath;
    NSString *	_docPath;
    NSString *	_libPrefPath;
    NSString *	_libCachePath;
    NSString *	_tmpPath;
}

- (BOOL)touch:(NSString *)path;
- (BOOL)touchFile:(NSString *)path;

@end

@implementation Sandbox

@dynamic appPath;
@dynamic docPath;
@dynamic libPrefPath;
@dynamic libCachePath;
@dynamic tmpPath;

+ (Sandbox *)sharedInstance
{
    static Sandbox*_sandboxManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sandboxManager = [[self alloc] init];
    });
    return _sandboxManager;
}

+ (NSString *)appPath
{
    return [[Sandbox sharedInstance] appPath];
}

- (NSString *)appPath
{
    if (nil == _appPath)
    {
        _appPath = [[NSBundle mainBundle] bundlePath];
    }
    
    return _appPath;
}

+ (NSString *)docPath
{
    return [[Sandbox sharedInstance] docPath];
}

- (NSString *)docPath
{
    if (nil == _docPath)
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _docPath = [paths objectAtIndex:0];
    }
    
    return _docPath;
}

+ (NSString *)libPrefPath
{
    return [[Sandbox sharedInstance] libPrefPath];
}

- (NSString *)libPrefPath
{
    if ( nil == _libPrefPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
        
        [self touch:path];
        
        _libPrefPath = path;
    }
    
    return _libPrefPath;
}

+ (NSString *)libCachePath
{
    return [[Sandbox sharedInstance] libCachePath];
}

- (NSString *)libCachePath
{
    if (nil == _libCachePath)
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        
        [self touch:path];
        
        _libCachePath = path;
    }
    
    return _libCachePath;
}

+ (NSString *)tmpPath
{
    return [[Sandbox sharedInstance] tmpPath];
}

- (NSString *)tmpPath
{
    if ( nil == _tmpPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
        
        [self touch:path];
        
        _tmpPath = path;
    }
    
    return _tmpPath;
}

+ (BOOL)touch:(NSString *)path
{
    return [[Sandbox sharedInstance] touch:path];
}

- (BOOL)touch:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return YES;
}

+ (BOOL)touchFile:(NSString *)file
{
    return [[Sandbox sharedInstance] touchFile:file];
}

- (BOOL)touchFile:(NSString *)file
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:file] )
    {
        return [[NSFileManager defaultManager] createFileAtPath:file
                                                       contents:[NSData data]
                                                     attributes:nil];
    }
    
    return YES;
}

+ (BOOL)IsFileExists:(NSString *)filepath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

+ (NSString *)GetPathForDocuments:(NSString *)filename inDir:(NSString *)dir
{
    return [[self GetDirectoryForDocuments:dir] stringByAppendingPathComponent:filename];
    
}

/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊返回Documents下的指定文件路径(加创建)
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+ (NSString *)GetDirectoryForDocuments:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self docPath] stringByAppendingPathComponent:dir];
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        //        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}


@end

