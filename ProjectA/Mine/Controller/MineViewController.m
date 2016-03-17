//
//  MineViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "MineViewController.h"
#import "SignInViewController.h"

#import "SpecialUpdateModel.h"
#import "UserFavListModel.h"

#import "SignInView.h"
#import "SignInMethodView.h"
#import "UserView.h"
#import "UserSettingView.h"
#import "BaseWebView.h"

#import "SDWebImageManager.h"


@interface MineViewController ()

@property (nonatomic, retain) SignInMethodView *signInMethodView;

/** manager */
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

/** special update model */
@property (nonatomic, retain) SpecialUpdateModel *specialUpdateModel;

/** user */
@property (nonatomic, retain) NSUserDefaults *user;

/** fav list */
@property (nonatomic, retain) UserFavListModel *favListModel;

/** user view */
@property (nonatomic, retain) UserView *userView;

@end

@implementation MineViewController

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:[self.user objectForKey:@"access_token"] forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
    }
    return _manager;
}

- (NSUserDefaults *)user {
    if (!_user) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (void)viewDidLoad {
    [self createView];
    [self checkSpecialUpdate];
    [self getFavList];
}

#pragma mark - create view

- (void)createView {
    
    // 在这里使用__weak修饰 dont use __block
    __weak typeof(self) weakSelf = self;
    
    SignInView *signInView = [[SignInView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49)];
    __weak typeof(SignInView *) weakSignInView = signInView;
    
    signInView.signInBlock = ^(){

        SignInMethodView *signInMethodView = [[SignInMethodView alloc] initWithFrame:self.view.frame];
        __weak typeof(SignInMethodView *) weakSignInMethodView = signInMethodView;
        
        signInMethodView.backBlock = ^(){
            [UIView animateWithDuration:0.3 animations:^{
                weakSignInMethodView.alpha = 0;
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSignInMethodView removeFromSuperview];
            });
        };
        
        signInMethodView.goToSignInVCBlock = ^(){
            SignInViewController *signInVC = [[SignInViewController alloc] init];
            
            signInVC.signInSuccessBlock = ^(){
                // 选择登录方法页面消失
                [UIView animateWithDuration:0.3 animations:^{
                    weakSignInMethodView.alpha = 0;
                }];
                
                // 选择登录方法页面移除
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSignInMethodView removeFromSuperview];
                });
                
                // 移除登录页面
                [weakSignInView removeFromSuperview];
                
                // 显示用户页面
                self.userView = [[UserView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49)];
                
                self.userView.refreshDataBlock = ^(){
                    [weakSelf checkSpecialUpdate];
                    [weakSelf getFavList];
                };
                
                self.userView.goToUserSettingViewBlock = ^(){
                    UserSettingView *settingView = [[UserSettingView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
                    settingView.alpha = 0;
                    __weak typeof(UserSettingView *)weakSettingView = settingView;
                    
                    settingView.backBlock = ^(){
                        [UIView animateWithDuration:0.3 animations:^{
                            weakSettingView.alpha = 0;
                        }];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [weakSettingView removeFromSuperview];
                        });
                    };
                    
                    settingView.cleanSDWebIamgeCachesBlock = ^(){
                        NSString *message = [NSString stringWithFormat:@"Clear Caches %.2fMB", [SDWebImageManager.sharedManager.imageCache getSize] / 1024 / 1024.0];
                        [weakSelf showMessageLabelWithMessage:message OnView:weakSettingView];
                        NSLog(@"%ld Bytes.", [SDWebImageManager.sharedManager.imageCache getSize]);
                        [SDWebImageManager.sharedManager.imageCache clearMemory];
                        [SDWebImageManager.sharedManager.imageCache clearDisk];
                    };
                    
                    // 注销登录状态, 移除mine页所有页面, 重新生成.
                    settingView.signOutBlock = ^(){
                        NSLog(@"sign out.");
                        [weakSelf.user setObject:nil forKey:@"username"];
                        for (UIView *view in weakSelf.view.subviews) {
                            [view removeFromSuperview];
                        }
                        [weakSettingView removeFromSuperview];
                        [weakSelf createView];
                        [weakSelf checkSpecialUpdate];
                        [weakSelf getFavList];
                    };
                    
                    // 此处使用tabbarController.view 可以盖住tabbar
                    [weakSelf.tabBarController.view addSubview:settingView];
                    [UIView animateWithDuration:0.3 animations:^{
                        settingView.alpha = 1;
                    }];
                };
                
                self.userView.goToWebViewBlock = ^(NSString *url){
                    BaseWebView *webView = [[BaseWebView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT) URL:url];
                    [weakSelf.view addSubview:webView];
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frame = [webView frame];
                        frame.origin.x = 0;
                        webView.frame = frame;
                    }];
                };
                
                [self.view addSubview:self.userView];
                
            };
            
            [self presentViewController:signInVC animated:NO completion:nil];
        };
        
        signInMethodView.alpha = 0;
        self.signInMethodView = signInMethodView;
        [self.view addSubview:self.signInMethodView];
        [UIView animateWithDuration:0.3 animations:^{
            signInMethodView.alpha = 1;
        }];

        
    };
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user objectForKey:@"username"]) {
        NSLog(@"Already sign in with name : %@, access_token is : %@", [user objectForKey:@"access_token"], [user objectForKey:@"user_id"]);
        self.userView = [[UserView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49)];
        
        self.userView.refreshDataBlock = ^(){
            [weakSelf checkSpecialUpdate];
            [weakSelf getFavList];
        };
        
        self.userView.goToWebViewBlock = ^(NSString *url){
            BaseWebView *webView = [[BaseWebView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT) URL:url];
            [weakSelf.view addSubview:webView];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = [webView frame];
                frame.origin.x = 0;
                webView.frame = frame;
            }];
        };
        
        self.userView.goToUserSettingViewBlock = ^(){
            UserSettingView *settingView = [[UserSettingView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            settingView.alpha = 0;
            __weak typeof(UserSettingView *)weakSettingView = settingView;
            
            settingView.backBlock = ^(){
                [UIView animateWithDuration:0.3 animations:^{
                    weakSettingView.alpha = 0;
                }];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSettingView removeFromSuperview];
                });
            };
            
            
            // 清除缓存
            settingView.cleanSDWebIamgeCachesBlock = ^(){
                NSString *message = [NSString stringWithFormat:@"Clear Caches %.2fMB", [SDWebImageManager.sharedManager.imageCache getSize] / 1024 / 1024.0];
                [weakSelf showMessageLabelWithMessage:message OnView:weakSettingView];
                NSLog(@"%ld Bytes.", [SDWebImageManager.sharedManager.imageCache getSize]);
                [SDWebImageManager.sharedManager.imageCache clearMemory];
                [SDWebImageManager.sharedManager.imageCache clearDisk];
            };
            
            // 注销登录状态, 移除mine页所有页面, 重新生成.
            settingView.signOutBlock = ^(){
                NSLog(@"sign out.");
                [user setObject:nil forKey:@"username"];
                for (UIView *view in weakSelf.view.subviews) {
                    [view removeFromSuperview];
                }
                [weakSettingView removeFromSuperview];
                [weakSelf createView];
                [weakSelf checkSpecialUpdate];
                [weakSelf getFavList];
            };
            
            // 此处使用tabbarController.view 可以盖住tabbar
            [weakSelf.tabBarController.view addSubview:settingView];
            [UIView animateWithDuration:0.3 animations:^{
                settingView.alpha = 1;
            }];
        };
        
        [self.view addSubview:self.userView];
    } else {
        [self.view addSubview:signInView];
    }

}

#pragma mark - request data

// 获取special update
- (void)checkSpecialUpdate {
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:URL_CHECK_SPECIAL_UPDATE parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        self.specialUpdateModel = [[SpecialUpdateModel alloc] initWithDic:dic];
        [self.userView setSpecialUpdateModel:self.specialUpdateModel];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];

}

// 获取fav list
- (void)getFavList {
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:[NSString stringWithFormat:URL_FAVLIST, [self.user objectForKey:@"user_id"]] parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        self.favListModel = [[UserFavListModel alloc] initWithDic:dic];
        [self.userView setFavListModel:self.favListModel];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

#pragma mark - show message label

- (void)showMessageLabelWithMessage:(NSString *)message OnView:(UIView *)view {
    UILabel *labelCaches = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, WIDTH, 50)];
    labelCaches.backgroundColor = [UIColor blackColor];
    labelCaches.text = message;
    labelCaches.textAlignment = NSTextAlignmentCenter;
    labelCaches.textColor = [UIColor whiteColor];
    [view addSubview:labelCaches];
    [UIView animateWithDuration:0.5 animations:^{
        labelCaches.frame = CGRectMake(0, 0, WIDTH, 50);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            [UIView animateWithDuration:0.3 animations:^{
                labelCaches.frame = CGRectMake(0, -50, WIDTH, 50);
            }];
        }];
    });
}



@end
