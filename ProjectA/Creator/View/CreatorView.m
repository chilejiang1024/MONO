//
//  CreatorView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CreatorView.h"

#import "CreatorHomeTableViewCell.h"

@interface CreatorView () <UITableViewDataSource, UITableViewDelegate>

/** array */
@property (nonatomic, retain) NSMutableArray *arrayCPModel;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation CreatorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

#pragma mark - setter property

- (void)setArrayCPModel:(NSMutableArray *)arrayCPModel {
    _arrayCPModel = arrayCPModel;
    [self.tableView reloadData];
}

#pragma mark - create view

- (void)createView {
    [self createTableView];
    
}

#pragma mark - table view

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[CreatorHomeTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    self.tableView = tableView;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayCPModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.goToDetailVC(self.arrayCPModel[indexPath.row]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreatorHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.model = self.arrayCPModel[indexPath.row];
    return cell;
}



@end
