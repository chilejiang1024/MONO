//
//  SpecialDetailViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "CreatorDetailViewController.h"

#import "SpecialDetailView.h"
#import "BaseWebView.h"

#import "SpecialListModel.h"
#import "SpecialDetailModel.h"

@interface SpecialDetailViewController ()

@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

/** special detail view */
@property (nonatomic, retain) SpecialDetailView *specialDetailView;

/** SpecialDetailModel */
@property (nonatomic, retain) SpecialDetailModel *specialDetailModel;

@end



@implementation SpecialDetailViewController

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:@"d93c6170bcd711e4a1cd5254000ccdad" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
        [_manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"Content-Length"];
        [_manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
        [_manager.requestSerializer setValue:@"$Version=1" forHTTPHeaderField:@"Cookie2"];
        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [_manager.requestSerializer setValue:@"mmmono.com" forHTTPHeaderField:@"HOST"];
    }
    return _manager;
}

- (void)setModel:(SpecialListModel *)model {
    _model = model;
    [self getData];
}

- (void)viewDidLoad {
    [self createView];
}

- (void)createView {
    self.specialDetailView = [[SpecialDetailView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:self.specialDetailView];
    
    __block typeof(self)weakSelf = self;
    
    // dismiss VC
    self.specialDetailView.backBlock = ^(){
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    // click content cell
    self.specialDetailView.clickContentCellBlock = ^(NSString *url){
        BaseWebView *webView = [[BaseWebView alloc] initWithFrame:weakSelf.view.frame URL:url];
        [weakSelf.view addSubview:webView];
    };
    
    // click cp cell
    self.specialDetailView.clickCPCellBlock = ^(CpModel *cpModel){
        CreatorDetailViewController *creatorDetailVC = [[CreatorDetailViewController alloc] init];
        [weakSelf presentViewController:creatorDetailVC animated:NO completion:nil];
        [creatorDetailVC setCpModel:cpModel];
    };
    
    // click subscriber cell
    self.specialDetailView.clickSubscriberCellBlock = ^(){
        
    };
    
}

- (void)getData {
    NSString *url = [NSString stringWithFormat:URL_SPECIAL_DETAIL, self.model.Id];
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        NSLog(@"%@", dic);
        self.specialDetailModel = [SpecialDetailModel getSpecialDetailModelWithDic:dic];
        [self.specialDetailView setDetailModel:self.specialDetailModel];
        [self.specialDetailView setSpecialModel:self.model];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}






@end
