//
//  BaseView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/25.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void)setShowBackButton:(BOOL)showBackButton {
    _showBackButton = showBackButton;
    if (_showBackButton) {
        [self createBackButton];
    }
}

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


