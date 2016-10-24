//
//  DownloaderOperationManager.m
//  仿SD_imageWeb
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import "DownloaderOperationManager.h"
#import "DownloaderOperation.h"

@interface DownloaderOperationManager ()

/* 全局队列 */
@property (strong, nonatomic) NSOperationQueue *queue;

/* 图片缓存池 */
@property (strong, nonatomic) NSMutableDictionary *imageCache;

/* 操作缓存池 */
@property (strong, nonatomic) NSMutableDictionary *OPCache;

@end

@implementation DownloaderOperationManager

+ (instancetype)sharedDownloaderManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self == [super init]) {
        
        //实例化全局队列
        self.queue = [[NSOperationQueue alloc] init];
        
        //实例化操作缓存池
        self.OPCache = [[NSMutableDictionary alloc] init];
        
        //实例化图片缓存池
        self.imageCache = [[NSMutableDictionary alloc] init];

    }
    return self;
}

- (void)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void (^)(UIImage *))successBlock
{
    //判断是否有缓存
    if ([self checkedCacheURLStringWith:URLString]) {
        
        if (successBlock != nil) {
            //回调
            successBlock([self.imageCache objectForKey:URLString]);
        }
        return;
    }
    
    //判断要建立的操作是否存在,如果存在就不再建立新的操作
    if ([self.OPCache objectForKey:URLString]) {
        
        return;
    }
    
    //创建自定义NSOperation
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithURLString:URLString successBlock:^(UIImage *image) {
        
        //回调控制器给单例的代码块,把image传给控制器
        if (successBlock != nil) {
            
            //回调
            successBlock(image);
        }
        
        //图片下载完成之后移除操作
        [self.OPCache removeObjectForKey:URLString];
    }];
    
    //把创建的操作添加到缓存池
    [self.OPCache setObject:op forKey:URLString];
    
    //把操作添加到队列
    [self.queue addOperation:op];
}

- (BOOL)checkedCacheURLStringWith:(NSString *)URLString
{
    //判断内存中是否有图片,如果有返回YES
    if ([self.imageCache objectForKey:URLString]) {
        
        return YES;
    }
    //判断沙盒中是否有,如果有,给内存一份,再赋值返回
    UIImage *memImage = [self.imageCache objectForKey:[URLString appendAppPath]];
    if (memImage) {
        
        [self.imageCache setObject:memImage forKey:URLString];
        return YES;
    }
    
    return NO;
}

- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString
{
    //取消上次操作
    [[self.OPCache objectForKey:lastURLString] cancel];
    
    //把操作缓存池移除
    [self.OPCache removeObjectForKey:lastURLString];

}

@end
