//
//  BaseViewController.m
//  ProjectA
//
//  Created by JiangChile on 16/2/25.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    completion = ^(){
        viewControllerToPresent.view.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = viewControllerToPresent.view.frame;
            frame.origin.x = 0;
            viewControllerToPresent.view.frame = frame;
        }];
    };
    [super presentViewController:viewControllerToPresent animated:NO completion:completion];

}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.x = WIDTH;
        self.view.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super dismissViewControllerAnimated:NO completion:completion];
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
