//
//  UIImageView+WebImage.m
//  仿SD_imageWeb
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <objc/runtime.h>
#import "DownloaderOperationManager.h"

@implementation UIImageView (WebImage)

- (void)setLastURLString:(NSString *)lastURLString
{
    objc_setAssociatedObject(self, @"key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastURLString
{
    return objc_getAssociatedObject(self, @"key");
}

- (void)YR_setImagewithURLString:(NSString *)URLString placeHolderImage:(UIImage *)image
{
    //设置占位图
    self.image = image;
    
    //判断当前图片和上次的图片地址是否相同,如果不同,取消上次操作
    if (![URLString isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        //单例接管取消操作
        [[DownloaderOperationManager sharedDownloaderManager] cancelDownloadingOperationWithLastURLString:self.lastURLString];
    }
    
    //记录本次图片地址,当下一次再点击的时候,它自然就成为了上一张
    self.lastURLString = URLString;
    
    //单例接管下载
    [[DownloaderOperationManager sharedDownloaderManager] downloaderOperationWithURLString:URLString successBlock:^(UIImage *image) {
        
        self.image = image;
    }];
}



@end
