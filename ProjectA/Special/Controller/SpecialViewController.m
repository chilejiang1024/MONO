//
//  SpecialViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/2/27.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialViewController.h"
#import "SpecialDetailViewController.h"
#import "CreatorDetailViewController.h"

#import "SpecialModel.h"
#import "SpecialDetailModel.h"
#import "SpecialSearchResultModel.h"

#import "SpecialView.h"
#import "SpecialMoreView.h"
#import "SpecialSearchView.h"
#import "SpecialDetailView.h"
#import "BaseWebView.h"

#import "AFNetworking.h"

@interface SpecialViewController ()

/** special home models, really dont know what name is good... */
@property (nonatomic, retain) NSMutableArray *arrayHomeSpecialModels;

/** special more array */
@property (nonatomic, retain) NSMutableArray *arraySpecialMore;

@property (nonatomic, retain) NSMutableArray *arraySearchResult;

@property (nonatomic, retain) SpecialDetailModel *specialDetailModel;

@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

@property (nonatomic, retain) SpecialView *specialView;

@property (nonatomic, retain) SpecialSearchView *searchView;

@property (nonatomic, retain) SpecialMoreView *specialMoreView;

@property (nonatomic, retain) SpecialDetailView *specialDetailView;

@end

@implementation SpecialViewController

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

- (NSMutableArray *)arraySearchResult {
    if (!_arraySearchResult) {
        _arraySearchResult = [NSMutableArray array];
    }
    return _arraySearchResult;
}

- (NSMutableArray *)arraySpecialMore {
    if (!_arraySpecialMore) {
        _arraySpecialMore = [NSMutableArray array];
    }
    return _arraySpecialMore;
}

- (SpecialMoreView *)specialMoreView {
    if (!_specialMoreView) {
        _specialMoreView = [[SpecialMoreView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
        [self.view addSubview:_specialMoreView];
    }
    return _specialMoreView;
}

- (SpecialDetailView *)specialDetailView {
    if (!_specialDetailView) {
        _specialDetailView = [[SpecialDetailView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
        [self.view addSubview:_specialDetailView];
    }
    return _specialDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
    [self requestHomeSpecialModels];
}

- (void)createView {
    __weak typeof(self)weakSelf = self;
    self.specialView = [[SpecialView alloc] initWithFrame:self.view.frame];
    
    self.specialView.showSearchViewBlock = ^(){
        weakSelf.searchView = [[SpecialSearchView alloc] initWithFrame:CGRectMake(WIDTH, 70, WIDTH, HEIGHT - 70)];
        [weakSelf.view addSubview:weakSelf.searchView];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = weakSelf.searchView.frame;
            frame.origin.x = 0;
            weakSelf.searchView.frame = frame;
        }];
    };
    
    self.specialView.searchBlock = ^(NSString *searchText){
        NSDictionary *dic = @{@"format" : @"json"};
        // 将搜索字符串转为legal URL string（主要是中文字符串）
        searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *url = [NSString stringWithFormat:URL_SPECIAL_SEARCH, searchText];
        [weakSelf.manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
            NSDictionary *dic = object;
            weakSelf.arraySearchResult = [@[[SpecialSearchResultModel getModelWithDic:dic]] mutableCopy];
            [weakSelf.searchView setArraySearchResult:weakSelf.arraySearchResult];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    };
    
    self.specialView.goToMoreViewBlock = ^(NSString *url){
        NSLog(@"%@", url);
        NSDictionary *dic = @{@"format" : @"json"};
        [weakSelf.manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
            NSDictionary *dic = object;
            weakSelf.arraySpecialMore = [SpecialListModel getSpecialListModelArrayWithArray:dic[@"special_list"]];
            [weakSelf.specialMoreView setArraySpecialMore:weakSelf.arraySpecialMore];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = weakSelf.specialMoreView.frame;
            frame.origin.x = 0;
            weakSelf.specialMoreView.frame = frame;
        }];
    };
    
    self.specialView.goToDetailViewBlock = ^(SpecialListModel *model){
        
        SpecialDetailViewController *specialDetailVC = [[SpecialDetailViewController alloc] init];
        [weakSelf presentViewController:specialDetailVC animated:NO completion:nil];
        [specialDetailVC setModel:model];
        
    };
    
    [self.view addSubview:self.specialView];
    
}

- (void)requestHomeSpecialModels {
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:URL_SPECIAL_HOME parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        self.arrayHomeSpecialModels = [NSMutableArray array];
        [self.arrayHomeSpecialModels addObject:[SpecialModel getSpecialModelWithDic:dic]];
        [self.specialView setSpecialModel:self.arrayHomeSpecialModels.firstObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
