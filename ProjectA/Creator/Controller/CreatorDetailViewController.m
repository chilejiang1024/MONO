//
//  CreatorDetailViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CreatorDetailViewController.h"
#import "CreatorDetailView.h"
#import "WaterfallModel.h"
#import "BaseWebView.h"
#import "CreatorINFOView.h"

@interface CreatorDetailViewController ()

@property (nonatomic, retain) CreatorDetailView *detailView;

/** array detail item */
@property (nonatomic, retain) NSMutableArray *arrayDetailItem;

/** manager */
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

@end

@implementation CreatorDetailViewController

- (void)setCpModel:(CpModel *)cpModel {
    _cpModel = cpModel;
    [self.detailView setCpModel:_cpModel];
    [self getDataFromURL];
}

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        [_manager.requestSerializer setValue:@"d93c6170bcd711e4a1cd5254000ccdad" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
        [_manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"Content-Length"];
        [_manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
        [_manager.requestSerializer setValue:@"$Version=1" forHTTPHeaderField:@"Cookie2"];
        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [_manager.requestSerializer setValue:@"mmmono.com" forHTTPHeaderField:@"HOST"];
        [_manager.requestSerializer setValue:@"api-client/2.0.0 com.mmmono.mono/2.0.6 Android/4.4.2 IUNI U810" forHTTPHeaderField:@"MONO-USER-AGENT"];
    }
    return _manager;
}

- (NSMutableArray *)arrayDetailItem {
    if (!_arrayDetailItem) {
        _arrayDetailItem = [NSMutableArray array];
    }
    return _arrayDetailItem;
}

- (void)viewDidLoad {
    [self createView];
    
}

- (void)createView {
    __block typeof(self) weakSelf = self;
    self.detailView = [[CreatorDetailView alloc] initWithFrame:self.view.frame];
    
    self.detailView.backBlock = ^(){
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            // code
        }];
    };
    
    self.detailView.goToWebView = ^(NSString *url){
        BaseWebView *webView = [[BaseWebView alloc] initWithFrame:weakSelf.view.frame URL:url];
        [weakSelf.view addSubview:webView];
    };
    
    // 弹出显示页面,显示!!
    self.detailView.popINFOVIewBlock = ^(CpModel *model){
        CreatorINFOView *infoView = [[CreatorINFOView alloc] initWithFrame:weakSelf.view.frame CpModel:model];
        
        __block typeof(CreatorINFOView *)weakInfoView = infoView;
        infoView.disappearViewBlock = ^(){
            [UIView animateWithDuration:0.3 animations:^{
                weakInfoView.alpha = 0;
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakInfoView removeFromSuperview];
            });
        };
        
        infoView.alpha = 0;
        [weakSelf.view addSubview:infoView];
        [UIView animateWithDuration:0.3 animations:^{
            weakInfoView.alpha = 1;
        }];
    };
    
    [self.view addSubview:self.detailView];
}

- (void)getDataFromURL {
    NSString *url = [NSString stringWithFormat:URL_CREATOR_DETAIL, _cpModel.Id];
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        for (NSDictionary *dicTemp in dic[@"items"]) {
            [self.arrayDetailItem addObject:[[ItemModel alloc] initWithDic:dicTemp]];
        }
        [self.detailView setArrayItems:self.arrayDetailItem];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
    
    
}

@end
