//
//  RecTeaViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecTeaViewController.h"
#import "RecTeaView.h"
#import "TeaModel.h"

@interface RecTeaViewController ()

/** array tea model */
@property (nonatomic, retain) NSMutableArray *arrayTeaModel;

/** manager */
@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

/** tea view */
@property (nonatomic, retain) RecTeaView *teaView;

@end

@implementation RecTeaViewController

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

- (NSMutableArray *)arrayTeaModel {
    if (!_arrayTeaModel) {
        _arrayTeaModel = [NSMutableArray array];
    }
    return _arrayTeaModel;
}

- (void)viewDidLoad {
    [self createView];
    [self getDataFormURL];
}

- (void)createView {
    self.teaView = [[RecTeaView alloc] initWithFrame:self.view.frame];
    __block typeof(self) weakSelf = self;
    self.teaView.dismissVCBlock = ^(){
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    [self.view addSubview:self.teaView];
}

- (void)getDataFormURL {
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:URL_REC_TEA parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        for (NSDictionary *dicTemp in dic[@"recent_tea"]) {
            [self.arrayTeaModel addObject:[[TeaModel alloc] initWithDic:dicTemp]];
        }
        [self.teaView setArrayTeaModel:self.arrayTeaModel];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

@end
