//
//  UIImageView+WebImage.h
//  仿SD_imageWeb
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

/* 上一次图片地址 */
@property (copy, nonatomic) NSString *lastURLString;
/**
 分类实现图片下载,取消,缓存的方法

 @param URLString 接收图片的下载地址
 */
- (void)YR_setImagewithURLString:(NSString *)URLString placeHolderImage:(UIImage *)image;

@end
