//
//  RecViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecViewController.h"
#import "RecModel.h"
#import "RecView.h"
#import "MJRefresh.h"
#import "BaseWebView.h"
#import "RecTeaViewController.h"

@interface RecViewController ()

@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

/** waterfall 数组 */
@property (nonatomic, retain) NSMutableArray *arrayRecModels;

/** 首部轮播图3张 */
@property (nonatomic, retain) NSMutableArray *arrayImages;

/** view */
@property (nonatomic, retain) RecView *recView;

/** webview */
@property (nonatomic, retain) BaseWebView *webView;

@end

@implementation RecViewController

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

- (NSMutableArray *)arrayRecModels {
    if (!_arrayRecModels) {
        _arrayRecModels = [NSMutableArray array];
    }
    return _arrayRecModels;
}

- (NSMutableArray *)arrayImages {
    if (!_arrayImages) {
        _arrayImages = [NSMutableArray array];
    }
    return _arrayImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestScrollViewImages];
    
    
}


// ---------------------------------------------

- (void)createView {
    self.recView = [[RecView alloc] initWithFrame:[UIScreen mainScreen].bounds Images:self.arrayImages Waterfalls:self.arrayRecModels];
    
    __weak typeof (self) weakSelf = self;
    self.recView.refreshBlcok = ^(NSUInteger page) {
        [weakSelf requestDataWithPage:(page == 1 ? page : page + 1)];
        NSLog(@"%ld", page);
    };
    
    self.recView.clickBlock = ^(NSString *url) {
        weakSelf.webView = [[BaseWebView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT) URL:url];
        [weakSelf.view insertSubview:weakSelf.webView atIndex:weakSelf.view.subviews.count];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = weakSelf.webView.frame;
            frame.origin.x = 0;
            weakSelf.webView.frame = frame;
        }];
    };
    
    self.recView.goToTeaVCBlock = ^(){
        RecTeaViewController *teaVC = [[RecTeaViewController alloc] init];
        [weakSelf presentViewController:teaVC animated:NO completion:^{
            
        }];
    };
    
    [self.view addSubview:self.recView];
}

// ---------------------------------------------

- (void)requestScrollViewImages {
    NSDictionary *dic = @{@"format" : @"json"};
    [self.manager GET:URL_REC_IMAGES parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        self.arrayImages = [[WaterfallModel getWaterfallArrayWithArray:dic[@"data"]] mutableCopy];
        [self requestDataWithPage:0];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

- (void)requestDataWithPage:(NSInteger)page {
    NSDictionary *dic = @{@"format" : @"json"};
    NSString *dateTime = @"";
    dateTime = page > 1 ? [[[self.arrayRecModels.lastObject next] w_datetime] substringToIndex:10] : @"";
    [self.manager GET:[NSString stringWithFormat:URL_REC_WATERFALL, 1, dateTime] parameters:dic success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        // 接手这个项目的同志， 优化一下这段代码吧 。。。。
        if (page == 0) {
            self.arrayRecModels = [[RecModel getRecModelArrayWithDic:dic] mutableCopy];
            [self createView];
        } else if (page == 1){
            self.arrayRecModels = [[RecModel getRecModelArrayWithDic:dic] mutableCopy];
            [self.recView.tableView reloadData];
            [self.recView.tableView.mj_header endRefreshing];
        } else {
            [self.arrayRecModels addObjectsFromArray:[RecModel getRecModelArrayWithDic:dic]];
            [self.recView.tableView reloadData];
            [self.recView.tableView.mj_footer endRefreshing];
        }
        NSLog(@"request data %@", dateTime);
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

// ---------------------------------------------


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
