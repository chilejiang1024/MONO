//
//  SpecialMoreView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialMoreView.h"
#import "SpecialSearchResultCell.h"

@interface SpecialMoreView () <UITableViewDataSource, UITableViewDelegate>

/** special more array */
@property (nonatomic, retain) NSMutableArray *arraySpecialMore;

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation SpecialMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)setArraySpecialMore:(NSMutableArray *)arraySpecialMore {
    _arraySpecialMore = arraySpecialMore;
    [self.tableView reloadData];
}

- (void)createView {
    [self createTableView];
    [self createBackButton];
}


// ------------------------------------------------
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[SpecialSearchResultCell class] forCellReuseIdentifier:@"tableViewCell"];
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arraySpecialMore.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.model = self.arraySpecialMore[indexPath.row];
    return cell;
}

// ------------------------------------------------
- (void)createBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, HEIGHT - 100, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
}

- (void)clickBackButton:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = WIDTH;
        self.frame = frame;
    }];
}

@end
