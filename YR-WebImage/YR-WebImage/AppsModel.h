//
//  AppsModel.h
//  仿SDWebImage
//
//  Created by 袁应荣 on 10/21/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppsModel : NSObject

/* APP图标名 */
@property (copy, nonatomic) NSString *icon;
/* APP的名字 */
@property (copy, nonatomic) NSString *name;
/* APP的下载总量 */
@property (copy, nonatomic) NSString *download;


@end
