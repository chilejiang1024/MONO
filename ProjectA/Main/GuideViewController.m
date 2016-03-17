//
//  GuideViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/3/11.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "GuideViewController.h"

#import "TabBarViewController.h"

@interface GuideViewController () <UIScrollViewDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createGuideView];
    
    
}

- (void)createGuideView {
    
    UIScrollView *guideScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    guideScrollView.delegate = self;
    guideScrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:@"LaunchImage.png"];
        [guideScrollView addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(38 + WIDTH * i, HEIGHT - 70, 150, 50);
        [button addTarget:self action:@selector(skipGuideView:) forControlEvents:UIControlEventTouchUpInside];
        [guideScrollView addSubview:button];
    }
    guideScrollView.pagingEnabled = YES;
    [self.view addSubview:guideScrollView];
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x > WIDTH * 2) {
        [self changeRootController];
    }
}

- (void)skipGuideView:(UIButton *)sender {
    [self changeRootController];
}

- (void)changeRootController {
    [UIView animateWithDuration:1 animations:^{
        // self.view.alpha = 0;
        self.view.transform = CGAffineTransformMakeScale(1.5 * WIDTH, 1.5 * HEIGHT);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TabBarViewController *root = [[TabBarViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = root;
    });
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
