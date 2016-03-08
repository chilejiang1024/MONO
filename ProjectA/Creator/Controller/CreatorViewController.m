//
//  CreatorViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CreatorViewController.h"
#import "CreatorDetailViewController.h"
#import "AFNetworking.h"
#import "CreatorView.h"
#import "WaterfallModel.h"

@interface CreatorViewController ()

/** cp Model array*/
@property (nonatomic, retain) NSMutableArray *arrayCPModel;

/** manager */
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

/** view */
@property (nonatomic, retain) CreatorView *creatorView;

@end

@implementation CreatorViewController

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

- (NSMutableArray *)arrayCPModel {
    if (!_arrayCPModel) {
        _arrayCPModel = [NSMutableArray array];
    }
    return _arrayCPModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
    [self getDataFromURL];
    
}

#pragma mark - 获取数据

- (void)getDataFromURL {
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:URL_CREATOR_HOME parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        for (NSDictionary *dicTemp in dic[@"providers"]) {
            [self.arrayCPModel addObject:[[CpModel alloc] initWithDic:dicTemp]];
        }
        [self.creatorView setArrayCPModel:self.arrayCPModel];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
    
}

#pragma mark - 创建视图

- (void)createView {
    __block typeof(self) weakSelf = self;
    
    self.creatorView = [[CreatorView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20 - 49)];
    self.creatorView.goToDetailVC = ^(CpModel *model){
        CreatorDetailViewController *detailVC = [[CreatorDetailViewController alloc] init];
        [weakSelf presentViewController:detailVC animated:NO completion:^{
            // code 
        }];
        // 此处为顺序执行问题, 必须放在这
        [detailVC setCpModel:model];
    };
    [self.view addSubview:self.creatorView];
}

@end
