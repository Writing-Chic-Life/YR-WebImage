//
//  NSString+path.m
//  NSOperation实现列表异步加载网络图片
//
//  Created by 袁应荣 on 10/22/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appendAppPath
{
    // 获取沙盒路径
   NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //获取文件名  lastPathComponent: 会遍历所有'/',取出最后一个'/'后的字符串
    NSString *name = [self lastPathComponent];
    
    //拼接文件路径
    NSString *fileName = [path stringByAppendingPathComponent:name];
    
    return fileName;
}

@end
