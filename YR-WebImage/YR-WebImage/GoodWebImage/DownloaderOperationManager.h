//
//  DownloaderOperationManager.h
//  仿SD_imageWeb
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderOperationManager : NSObject


/**
 单例全局访问点

 @return 返回单例对象
 */
+ (instancetype)sharedDownloaderManager;


/**
 单例下载方法

 @param URLString    接收外界传入图片的地址
 @param successBlock 接收外界传入的下载完成回调
 */
- (void)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock;


/**
 单例取消上次正在执行的方法

 @param lastURLString 接收上次下载图片的地址
 */
- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString;

@end
