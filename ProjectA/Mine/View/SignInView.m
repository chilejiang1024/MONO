//
//  SignInView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SignInView.h"

@interface SignInView ()

@end

@implementation SignInView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
    UIImage *image = [UIImage imageNamed:@"SignIn.png"];
    CGRect frame = backgroundImage.frame;
    frame.size.height = image.size.height / (image.size.width / WIDTH);
    backgroundImage.frame = frame;
    backgroundImage.image = image;
    backgroundImage.userInteractionEnabled = YES;
    [self addSubview:backgroundImage];
    
    UIButton *buttonSignIn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSignIn.frame = CGRectMake(0, 0, 100, 100);
    buttonSignIn.center = self.center;
    buttonSignIn.layer.cornerRadius = 50;
    buttonSignIn.clipsToBounds = YES;
    [buttonSignIn addTarget:self action:@selector(clickButtonSignIn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonSignIn];
    
}

- (void)clickButtonSignIn:(UIButton *)sender {
    self.signInBlock();
}

@end
