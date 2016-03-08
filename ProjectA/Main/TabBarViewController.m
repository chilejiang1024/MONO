//
//  TabBarViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "TabBarViewController.h"
#import "RecViewController.h"
#import "SpecialViewController.h"
#import "CreatorViewController.h"
#import "MineViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
    backView.backgroundColor = [UIColor blackColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    RecViewController *recVC = [[RecViewController alloc] init];
    SpecialViewController *specialVC = [[SpecialViewController alloc] init];
    CreatorViewController *creatorVC = [[CreatorViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    [self addChildVC:recVC Title:@"推荐" imageName:@"icon-m.png" SelectedImageName:@"icon-m-selected.png"];
    [self addChildVC:specialVC Title:@"专题" imageName:@"icon-o.png" SelectedImageName:@"icon-o-selected.png"];
    [self addChildVC:creatorVC Title:@"造物主" imageName:@"icon-n.png" SelectedImageName:@"icon-n-selected.png"];
    [self addChildVC:mineVC Title:@"我" imageName:@"icon-o.png" SelectedImageName:@"icon-o-selected.png"];
}

- (void)addChildVC:(UIViewController *)childVC Title:(NSString *)title imageName:(NSString *)imageName SelectedImageName:(NSString *)selectedImageName {
    // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    childVC.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[NSForegroundColorAttributeName] = MONO_COLOR;
    [childVC.tabBarItem setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:dic2 forState:UIControlStateSelected];
    [self addChildViewController:childVC];
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
