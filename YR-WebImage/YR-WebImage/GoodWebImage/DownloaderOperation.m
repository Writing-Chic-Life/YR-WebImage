//
//  DownloaderOperation.m
//  仿SD_imageWeb
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import "DownloaderOperation.h"


@interface DownloaderOperation ()

/* 图片的地址 */
@property (copy, nonatomic) NSString *URLStr;

/* 代码块 */
@property (copy, nonatomic) void(^successBlock)(UIImage *);



@end

@implementation DownloaderOperation

- (void)main
{
    [NSThread sleepForTimeInterval:1.0];
    
    //图片下载
    NSURL *URL = [NSURL URLWithString:self.URLStr];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    
    //写入沙盒缓存
    if (image) {
        
        [data writeToFile:[self.URLStr appendAppPath] atomically:YES];
    }
    
    //判断当前操作是否被取消,如果被取消,直接返回
    if (self.cancelled == YES) {
        NSLog(@"取消 %@",self.URLStr);
        return;
    }
    
    //图片下载完成之后回调
    //断言:
    NSAssert(self.successBlock != nil, @"传入的代码块success为nil");
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"完成 %@",self.URLStr);
        self.successBlock(image);
    }];
}

+ (instancetype)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void (^)(UIImage *image))successBlock
{
    NSLog(@"传入 %@",URLString);
    
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    op.URLStr = URLString;
    
    op.successBlock = successBlock;
    
    return op;
}

@end
