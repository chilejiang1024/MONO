//
//  SignInViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SignInViewController.h"
#import "UserSignInModel.h"
#import "SignInWithQQView.h"

@interface SignInViewController ()

@property (nonatomic, retain) SignInWithQQView *signInWithQQView;

/** user  */
@property (nonatomic, retain) UserSignInModel *userModel;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [self createView];
}

- (void)createView {
    
    SignInWithQQView *signInWithQQView = [[SignInWithQQView alloc] initWithFrame:self.view.frame];
    
    signInWithQQView.signInBlock = ^(){
        [self signInWithQQ];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.signInWithQQView = signInWithQQView;
    
    [self.view addSubview:signInWithQQView];
    
}

- (void)signInWithQQ {

    NSString *str = @"http://mmmono.com/api/v2/accounts/qq/C181634DA2DDD21640674C9F2BB5B2F2/bind/";
    NSString *bodyStr = @"{\"ts\":\"cRLbwaKdi5CUR6GehrgSkHgwioGx5YwjyR3ab4iznLmWDRCxhlBsED2rmwwltr3B1HkHpDhwZfOb6NYvtfVaRX5DMnQFwHj9hPUupx6e93w=\",\"token\":\"A3FC8AB626C2C4FCCE8BB7709CAA2B72\"}";
    NSURL *url = [NSURL URLWithString:str];
    NSURLSessionConfiguration *sessionCfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionCfg];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:@"eeb58fb5e29911e5b9f6525400097b5b" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
    [request addValue:@"160" forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request addValue:@"mmmono.com" forHTTPHeaderField:@"HOST"];
    
#pragma mark - 将json data 转换成dic 并记录登录状态
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // 将json data 转换成dic
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.userModel = [[UserSignInModel alloc] initWithDic:dic];
        if (!error) {
            NSLog(@"sign in successfully!! name : %@", self.userModel.name);
            
            // 保存用户登录信息
            // -----------------------------------------------------------
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:self.userModel.name forKey:@"username"];
            [user setObject:self.userModel.user_id forKey:@"user_id"];
            [user setObject:@(self.userModel.id_old_user) forKey:@"id_old_user"];
            [user setObject:self.userModel.avatar_url forKey:@"avatar_url"];
            [user setObject:self.userModel.access_token forKey:@"access_token"];
            // -----------------------------------------------------------
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.signInSuccessBlock();
            });
            [self.signInWithQQView.indicatorView stopAnimating];
        } else {
            NSLog(@"sign in failuer.");
        }
        
    }];
    [dataTask resume];
    
    
    
}

@end
