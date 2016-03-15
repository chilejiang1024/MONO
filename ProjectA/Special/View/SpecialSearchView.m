//
//  SpecialSearchView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialSearchView.h"
#import "BaseWebView.h"

#import "SpecialSearchResultModel.h"

#import "SpecialSearchResultCell.h"
#import "ContentSearchResultCell.h"

@interface SpecialSearchView () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, retain) UILabel *label;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIButton *backButton;

// data
@property (nonatomic, retain) NSMutableArray *arraySearchResult;

@end

@implementation SpecialSearchView

- (void)setArraySearchResult:(NSMutableArray *)arraySearchResult {
    _arraySearchResult = arraySearchResult;
    SpecialSearchResultModel *model = self.arraySearchResult.firstObject;
    if (model.special.count > 0 || model.item.count > 0) {
        self.label.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } else {
        [self showNoResultView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

#pragma mark - create view

- (void)createView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, WIDTH, 50)];
    self.label.text = @"搜索内容和专题";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor lightGrayColor];
    [self addSubview:self.label];
    
    
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(20, 500, 30, 30);
    [self.backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    

}

#pragma mark - 创建tableview & 协议方法
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 50 - 49) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SpecialSearchResultCell class] forCellReuseIdentifier:@"tableViewCell_0"];
    [self.tableView registerClass:[ContentSearchResultCell class] forCellReuseIdentifier:@"tableViewCell_1"];
    self.tableView.hidden = YES;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SpecialSearchResultModel *model = self.arraySearchResult.firstObject;
    switch (section) {
        case 0 :
            return model.special.count;
            break;
        
        case 1 :
            return model.item.count;
            break;
            
        default:
            return 0;
            break;
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialSearchResultModel *model = self.arraySearchResult.firstObject;
    if (indexPath.section == 0) {
        NSLog(@"%@", model.special[indexPath.row]);
    } else {
        self.showResultWebViewBlock([model.item[indexPath.row] item_url]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    if (section == 0) {
        label.text = @"专题";
    } else {
        label.text = @"内容";
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17.f];
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialSearchResultModel *model = self.arraySearchResult.firstObject;
    if (indexPath.section == 0) {
        SpecialSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell_0"];
        cell.model = model.special[indexPath.row];
        return cell;
    } else {
        ContentSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell_1"];
        cell.model = model.item[indexPath.row];
        return cell;
    }
}


#pragma mark - selector

- (void)clickBackButton:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = WIDTH;
        self.frame = frame;
    }];
    
    // 让search bar 失去第一响应者
    [[self.superview.subviews[0] searchBar] resignFirstResponder];
    
    // clean data
    [self.arraySearchResult removeAllObjects];
}

#pragma mark - show no result alert view

- (void)showNoResultView {
    UIView *noResultView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 120 / 0.618 / 2, 200, 120 / 0.618, 120)];
    noResultView.backgroundColor = [UIColor blackColor];
    noResultView.alpha = 0.1;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:noResultView.bounds];
    messageLabel.text = @"未搜索到结果\nPlease change key word!";
    messageLabel.numberOfLines = 2;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor whiteColor];
    [noResultView addSubview:messageLabel];
    
    [self addSubview:noResultView];
    
    [UIView animateWithDuration:0.3 animations:^{
        noResultView.alpha = 0.8;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            noResultView.alpha = 0;
            [noResultView removeFromSuperview];
        });
    }];
    
    
}



@end
