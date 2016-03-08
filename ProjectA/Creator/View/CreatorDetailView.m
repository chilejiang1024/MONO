//
//  CreatorDetailView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CreatorDetailView.h"
#import "WaterfallModel.h"
#import "UIImageView+WebCache.h"
#import "RecTextTableViewCell.h"

@interface CreatorDetailView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) CpModel *cpModel;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

/** array data source */
@property (nonatomic, retain) NSMutableArray *arrayItems;


@end

@implementation CreatorDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
        self.showBackButton = YES;
    }
    return self;
}

- (void)setCpModel:(CpModel *)cpModel {
    _cpModel = cpModel;
    [self.tableView reloadData];
}

- (void)setArrayItems:(NSMutableArray *)arrayItems {
    _arrayItems = arrayItems;
    [self.tableView reloadData];
}

- (void)createView {
    self.backgroundColor = [UIColor yellowColor];
    [self createTableView];
}

#pragma mark - table view

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[RecTextTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    self.tableView = tableView;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    WaterfallModel *waterfallModel = [[WaterfallModel alloc] init];
    waterfallModel.item = self.arrayItems[indexPath.row];
    CGFloat h = 15 * waterfallModel.item.content.desc.length / 22;
    height = 40 + waterfallModel.item.thumb.height / (waterfallModel.item.thumb.width / (WIDTH - 20)) + 30 + (h < 50 ? h : 50) + 30 + 50;
    return height;  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    view.backgroundColor = [UIColor colorWithRed:0.15 green:0.16 blue:0.20 alpha:1.0f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderView:)];
    [view addGestureRecognizer:tap];
    
    UIImageView *imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 50, 50)];
    [imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:_cpModel.avatar]];
    imageViewAvatar.layer.cornerRadius = 25;
    imageViewAvatar.clipsToBounds = YES;
    [view addSubview:imageViewAvatar];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 100, 20)];
    labelTitle.text = _cpModel.screen_name;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:18.f];
    [view addSubview:labelTitle];
    
    UILabel *labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(110, 70, WIDTH - 100 - 40, 50)];
    labelDesc.textColor = [UIColor whiteColor];
    labelDesc.text = _cpModel.Description;
    labelDesc.font = [UIFont systemFontOfSize:13.f];
    labelDesc.numberOfLines = 0;
    [view addSubview:labelDesc];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.arrayItems[indexPath.row] item_url]);
    self.goToWebView([self.arrayItems[indexPath.row] item_url]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    WaterfallModel *model = [[WaterfallModel alloc] init];
    model.item = self.arrayItems[indexPath.row];
    cell.waterfallModel = model;
    return cell;
}

#pragma mark - click

- (void)clickBackButton:(UIButton *)sender {
    self.backBlock();
}

- (void)clickHeaderView:(UITapGestureRecognizer *)sender {
    self.popINFOVIewBlock(self.cpModel);
}


@end
