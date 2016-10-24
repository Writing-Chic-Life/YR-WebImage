//
//  DownloaderOperation.h
//  仿SD_imageWeb
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+path.h"

@interface DownloaderOperation : NSOperation


/**
 类方法实例化操作,并传入图片地址和下载完成回调

 @param URLString    图片地址
 @param successBlock 下载完成回调

 @return 返回自定义操作对象
 */
+ (instancetype)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock;


@end
