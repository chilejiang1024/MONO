//
//  RecTeaView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecTeaView.h"

@interface RecTeaView () <UITableViewDataSource, UITableViewDelegate>

/** array tea model */
@property (nonatomic, retain) NSMutableArray *arrayTeaModel;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

@end


@implementation RecTeaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
        self.showBackButton = YES;
    }
    return self;
}

- (void)setArrayTeaModel:(NSMutableArray *)arrayTeaModel {
    _arrayTeaModel = arrayTeaModel;
    [self.tableView reloadData];
}

- (void)createView {
    [self createTableView];
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    self.tableView = tableView;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayTeaModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.backgroundColor = COLOR_RANDOM;
    return cell;
}

- (void)clickBackButton:(UIButton *)sender {
    self.dismissVCBlock();
}

@end
