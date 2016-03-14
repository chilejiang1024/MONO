//
//  CreatorView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//


#import "CreatorView.h"

#import "DynamicFlowLayout.h"

#import "CreatorHomeTableViewCell.h"
#import "DynamicCollectionViewCell.h"

@interface CreatorView () <UITableViewDataSource, UITableViewDelegate, UICollisionBehaviorDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

/** array */
@property (nonatomic, retain) NSMutableArray *arrayCPModel;

/** table view */
@property (nonatomic, retain) UITableView *tableView;

/** collection view */
@property (nonatomic, retain) UICollectionView *collectionView;

/** DynamicFlowLayout */
@property (nonatomic, retain) DynamicFlowLayout *layout;

/** dynamic animator */
@property (nonatomic, retain) UIDynamicAnimator *animator;

/** view */
@property (nonatomic, retain) UIView *view;

@end


static NSString *collectionReuseID = @"collectionReuseID";


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
    // [self.tableView reloadData];
    
    // reload data not work
    //    [self.collectionView reloadData];
    [self createCollectionView];
}

#pragma mark - create view

- (void)createView {
    // [self createTableView];
    
    //    [self createCollectionView];
    
    // 受到重力感应的圆形view
    // ----------------------------------
    /*
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 30, 30)];
    view.layer.cornerRadius = 15;
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
    [self addSubview:self.view];
    */
    // ----------------------------------
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    self.view.frame = CGRectMake(arc4random() % (int)WIDTH, 50, 30, 30);
//    
//    
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//    
//    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.view]];
//    [animator addBehavior:gravityBehavior];
//    
//    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.view]];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    collisionBehavior.collisionDelegate = self;
//    [animator addBehavior:collisionBehavior];
//    
//    self.animator = animator;
//}

#pragma mark - collection view

- (void)createCollectionView {
    self.layout = [[DynamicFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(WIDTH, 100);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[DynamicCollectionViewCell class] forCellWithReuseIdentifier:collectionReuseID];
    self.collectionView = collectionView;
    [self addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     return self.arrayCPModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DynamicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionReuseID forIndexPath:indexPath];
    cell.model = self.arrayCPModel[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.goToDetailVC(self.arrayCPModel[indexPath.row]);
}


#pragma mark - table view

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 100;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.goToDetailVC(self.arrayCPModel[indexPath.row]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreatorHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.model = self.arrayCPModel[indexPath.row];
    return cell;
}





@end
