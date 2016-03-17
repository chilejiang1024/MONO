//
//  CommentView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/10.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CommentView.h"

#import "CommentTableViewCell.h"

#import "CommentModel.h"

#import "UIImageView+WebCache.h"

@interface CommentView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSString *url;

@property (nonatomic, retain) NSMutableArray *arrayComment;

@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

/** comment text field */
@property (nonatomic, retain) UITextField *textField;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url {
    if (self = [super initWithFrame:frame]) {
        self.url = url;
        [self createView];
    }
    return self;
}

- (AFHTTPRequestOperationManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        [_manager.requestSerializer setValue:@"d93c6170bcd711e4a1cd5254000ccdad" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
        [_manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"Content-Length"];
        [_manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
        [_manager.requestSerializer setValue:@"$Version=1" forHTTPHeaderField:@"Cookie2"];
        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [_manager.requestSerializer setValue:@"mmmono.com" forHTTPHeaderField:@"HOST"];
        [_manager.requestSerializer setValue:@"api-client/2.0.0 com.mmmono.mono/2.0.6 Android/4.4.2 IUNI U810" forHTTPHeaderField:@"MONO-USER-AGENT"];
    }
    return _manager;
}




#pragma mark - 创建view , table view
- (void)createView {
    self.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self getCommentArray];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    float x = [pan translationInView:self].x;
    [self setTransform:CGAffineTransformMakeTranslation(x, 0)];
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (x > WIDTH / 2) {
            [UIView animateWithDuration:0.3 animations:^{
                [self setTransform:CGAffineTransformMakeTranslation(WIDTH, 0)];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self setTransform:CGAffineTransformMakeTranslation(0, 0)];
            }];
        }
    }
}


#pragma mark - 创建头, 尾视图

- (void)createHeaderFooterView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    UILabel *labelHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 30)];
    labelHeader.backgroundColor = [UIColor whiteColor];
    labelHeader.text = [NSString stringWithFormat:@"评论 %ld", self.arrayComment.count];
    labelHeader.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:labelHeader];
    [self addSubview:headerView];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 100, WIDTH, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    imageViewAvatar.layer.cornerRadius = 15;
    imageViewAvatar.clipsToBounds = YES;
    [imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar_url"]]];
    [footerView addSubview:imageViewAvatar];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, WIDTH - 60 - 50, 30)];
    textField.placeholder = @"填写评论...";
    self.textField = textField;
    [footerView addSubview:self.textField];
    
    UIButton *buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSubmit.frame = CGRectMake(WIDTH - 50, 0, 40, 50);
    [buttonSubmit setImage:[UIImage imageNamed:@"btn-comment-submit@3x.png"] forState:UIControlStateNormal];
    [buttonSubmit addTarget:self action:@selector(submitComment:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:buttonSubmit];
    
    [self addSubview:footerView];
}


- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT - 100) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCellID"];
    self.tableView = tableView;
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayComment.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCellID"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil].lastObject;
    }
    cell.model = self.arrayComment[indexPath.row];
    return cell;
}

#pragma mark - get comment

- (void)getCommentArray {
    NSString *itemId = [self.url substringFromIndex:@"http://mmmono.com/item/".length];
    NSString *url = [NSString stringWithFormat:URL_COMMENT, itemId];
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id object) {
        NSDictionary *dic = object;
        self.arrayComment = [CommentModel getCommentModelArrayWithArray:dic[@"comment_list"]];
        [self.tableView reloadData];
        [self createHeaderFooterView];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

#pragma mark - selector

- (void)submitComment:(UIButton *)sender {
    if (self.textField.text.length > 0) {
        [[MONOTools shareTools] postComment:self.textField.text URL:self.url];
    }
}


@end
