//
//  SignInWithQQView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SignInWithQQView.h"

@interface SignInWithQQView () 


@end


@implementation SignInWithQQView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.center = self.center;
        UIView *background = [[UIView alloc] initWithFrame:self.frame];
        background.backgroundColor = [UIColor blackColor];
        background.alpha = 0.7;
        [self addSubview:background];
        [self addSubview:_indicatorView];
    }
    return _indicatorView;
}


- (void)createView {
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.0];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 50)];
    labelTitle.backgroundColor = [UIColor whiteColor];
    labelTitle.text = @"QQ登录";
    labelTitle.font = [UIFont systemFontOfSize:20.f];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelTitle];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 50, 50);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0.13 green:0.67 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [self addSubview:backButton];
    
    UIImageView *mainView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 90, WIDTH - 30, 350)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 10.f;
    mainView.clipsToBounds = YES;
    mainView.image = [UIImage imageNamed:@"background.jpg"];
    [self addSubview:mainView];
    
    UILabel *qqName = [[UILabel alloc] initWithFrame:CGRectMake(100, 260, 200, 30)];
    qqName.text = @"⊙︿⊙  (873439975)";
    [mainView addSubview:qqName];
    
    UILabel *qqPower = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
    qqPower.text = @"你已经对该应用授权";
    qqPower.textColor = [UIColor lightGrayColor];
    [mainView addSubview:qqPower];
    
    UIImageView *qqAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 266, 60, 60)];
    qqAvatar.layer.cornerRadius = 30.f;
    qqAvatar.backgroundColor = [UIColor lightGrayColor];
    [mainView addSubview:qqAvatar];
    
    UIImageView *monoIcon = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 30) / 2 - 40, 90, 80, 80)];
    monoIcon.image = [UIImage imageNamed:@"icon-mono.png"];
    [mainView addSubview:monoIcon];
    
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signInButton.frame = CGRectMake(15, 460, WIDTH - 30, 50);
    signInButton.layer.cornerRadius = 5.f;
    signInButton.clipsToBounds = YES;
    signInButton.backgroundColor = [UIColor colorWithRed:0.13 green:0.67 blue:0.94 alpha:1.0];
    [signInButton setTitle:@"登录" forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signInButton];
    
    
    
}

- (void)signIn:(UIButton *)sender {
    [self.indicatorView startAnimating];
    self.signInBlock();
}



@end
