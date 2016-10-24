//
//  ViewController.m
//  YR-WebImage
//
//  Created by 袁应荣 on 10/23/16.
//  Copyright © 2016 yyr. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "AppsModel.h"
#import "UIImageView+WebImage.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/* Json转换为模型数据数组 */
@property (strong, nonatomic) NSArray<AppsModel *> *appsList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadJSONData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    int random = arc4random_uniform((uint32_t)self.appsList.count);
    
    AppsModel *app = self.appsList[random];
    
    [self.iconImageView YR_setImagewithURLString:app.icon placeHolderImage:[UIImage imageNamed:@"user_default"]];
    
}



- (void)loadJSONData
{
    //创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //获取Json数据
    [manager GET:@"https://raw.githubusercontent.com/Writing-Chic-Life/ServerFile01/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *dictArr = responseObject;
        
        //字典数组转换为模型数组
        self.appsList = [NSArray yy_modelArrayWithClass:[AppsModel class] json:dictArr];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
