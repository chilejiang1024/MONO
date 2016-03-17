//
//  SpecialView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialView.h"
#import "UIImageView+WebCache.h"
#import "SpecialCollectionViewCell.h"

@interface SpecialView () <UISearchBarDelegate, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

/** collection view */
@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) SpecialModel *specialModel;

@end


@implementation SpecialView

#pragma mark - setter & init

- (void)setSpecialModel:(SpecialModel *)specialModel {
    if (_specialModel != specialModel) {
        _specialModel = specialModel;
        [self.collectionView reloadData];
    }
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

#pragma mark - create view & searchBar & collection view

- (void)createView {
    [self createSearchBar];
    [self createCollectionView];
}

- (void)createSearchBar {
    self.searchBar = [UISearchBar.alloc initWithFrame:CGRectMake(0, 20, WIDTH, 50)];
    self.searchBar.placeholder = @"搜索专题和内容";
    self.searchBar.delegate = self;
    [self addSubview:self.searchBar];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(WIDTH / 2, WIDTH / 2);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, WIDTH, HEIGHT - 70 - 49) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collection_header"];
    [self.collectionView registerClass:[SpecialCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [self addSubview:self.collectionView];
}

#pragma mark - collection view 协议方法
// -------------------------------------------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(WIDTH, 270);
    } else {
        return CGSizeMake(WIDTH, 70);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collection_header" forIndexPath:indexPath];
    
    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    
    // warning : dont touch this line...
    headerView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderView:)];
    [headerView addGestureRecognizer:tap];
    
    // 这是一个神奇的条件,如果你不知道什么意思,请不要动⬇️
    if (indexPath.section == 0 && self.specialModel) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:headerView.frame];
        imageView.backgroundColor = [UIColor blackColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.specialModel.tops[0] thumb].raw]];
        imageView.alpha = ALPHA;
        [headerView addSubview:imageView];
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60, 30, 120, 100)];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:[self.specialModel.tops[0] logo_url].raw]];
        [headerView addSubview:imageView2];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 100, 30, 100, 20)];
        label1.text = @"MONO专题";
        label1.textColor = [UIColor whiteColor];
        [headerView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, WIDTH, 30)];
        label2.text = [self.specialModel.tops[0] title];
        label2.textColor = [UIColor whiteColor];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont fontWithName:@"STKaiti" size:25.f];
        [headerView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 165, WIDTH - 40, 55)];
        label3.numberOfLines = 0;
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:15.f];
        label3.text = [self.specialModel.tops[0] content].desc;
        label3.textColor = [UIColor whiteColor];
        [headerView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, WIDTH, 40)];
        NSString *label4Str = [NSString stringWithFormat:@"%ld篇内容/%ld人订阅", [self.specialModel.tops[0] content_num], [self.specialModel.tops[0] subscriber_num]];
        NSMutableAttributedString *label4Text = [[NSMutableAttributedString alloc] initWithString:label4Str];
        [label4Text setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor], NSFontAttributeName : [UIFont systemFontOfSize:25.f]} range:NSMakeRange(0, 2)];
        [label4Text setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(2, 4)];
        [label4Text setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor], NSFontAttributeName : [UIFont systemFontOfSize:25.f]} range:NSMakeRange(5, 6)];
        [label4Text setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(11, 3)];
        [label4 setAttributedText:label4Text];
        label4.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:label4];
        
    } else if (indexPath.section != 0 && self.specialModel){
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
        label1.backgroundColor = [UIColor colorWithRed:0.99 green:0.84 blue:0.31 alpha:1.0];
        label1.transform = CGAffineTransformMakeRotation(M_PI_4);
        label1.layer.cornerRadius = 5;
        label1.clipsToBounds = YES;
        [headerView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:label1.frame];
        label2.text = [[self.specialModel.category_list[indexPath.section - 1] category_ename] substringToIndex:1];
        label2.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 200, 50)];
        label3.text = [NSString stringWithFormat:@"%@\n%@", [self.specialModel.category_list[indexPath.section - 1] category_ename], [self.specialModel.category_list[indexPath.section - 1] category_name]];
        label3.numberOfLines = 0;
        label3.font = [UIFont systemFontOfSize:13.f];
        [headerView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 175, 20, 155, 30)];
        label4.text = [NSString stringWithFormat:@"查看全部%ld个专题 >", [self.specialModel.category_list[indexPath.section - 1] special_num]];
        label4.textAlignment = NSTextAlignmentRight;
        label4.font = [UIFont systemFontOfSize:13.f];
        [headerView addSubview:label4];
    }
    
    return headerView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.specialModel.category_list.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SpecialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.model = self.specialModel.tops[indexPath.row + 1];
    } else {
        cell.model = [self.specialModel.category_list[indexPath.section - 1] specialList][indexPath.row];
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SpecialListModel *model;
    if (indexPath.section == 0) {
        model = self.specialModel.tops[indexPath.row + 1];
    } else {
        model = [self.specialModel.category_list[indexPath.section - 1]  specialList][indexPath.row];
    }
    self.goToDetailViewBlock(model);
}

#pragma mark - search bar 协议方法
// -------------------------------------------
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.showSearchViewBlock();
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"---------");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search for %@.", searchBar.text);
    self.searchBlock(searchBar.text);
}

#pragma mark - collection view header view 点击方法
// -------------------------------------------
- (void)tapHeaderView:(UITapGestureRecognizer *)sender {
    NSInteger section = (sender.view.frame.origin.y - 200) / (70 + WIDTH);
    NSString *url;
    switch (section) {
        case 0:
            url = [NSString stringWithFormat:@"http://mmmono.com/api/v2/special/%ld/content/", [self.specialModel.tops.firstObject Id]];
            self.goToDetailViewBlock(self.specialModel.tops.firstObject);
            break;
            
        default:
            NSLog(@"%ld", section);
            url = [NSString stringWithFormat:@"http://mmmono.com/api/v2/special/category/%ld/specials/?page=1", [self.specialModel.category_list[section - 1] category_id]];
            self.goToMoreViewBlock(url);
            break;
    }
}

@end
