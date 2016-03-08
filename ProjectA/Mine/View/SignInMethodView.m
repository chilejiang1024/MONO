//
//  SignInMethodView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SignInMethodView.h"

@implementation SignInMethodView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.alpha = 0.8;
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.userInteractionEnabled = YES;
    [self addSubview:backgroundView];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 80, 250)];
    mainView.center = backgroundView.center;
    mainView.userInteractionEnabled = YES;
    [self addSubview:mainView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH - 80 - 30, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"icon-x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:button];
    
    UILabel *labelMONO = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    labelMONO.text = @"登录MONO";
    labelMONO.font = [UIFont systemFontOfSize:20.f];
    labelMONO.textColor = [UIColor whiteColor];
    [mainView addSubview:labelMONO];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 30)];
    label1.text = @"你可以用以下方式登录";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:15.f];
    [mainView addSubview:label1];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, WIDTH - 80, 0)];
    UIImage *image1 = [UIImage imageNamed:@"SignInWithSina.png"];
    CGRect frame = imageView1.frame;
    frame.size.height = image1.size.height / (image1.size.width / (WIDTH - 80));
    imageView1.frame = frame;
    imageView1.image = image1;
    imageView1.userInteractionEnabled = YES;
    [mainView addSubview:imageView1];
    
    UIButton *buttonSignIn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSignIn.frame = imageView1.frame;
    [buttonSignIn addTarget:self action:@selector(clickSignIn:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:buttonSignIn];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70 + imageView1.frame.size.height + 20, WIDTH - 80, 0)];
    UIImage *image2 = [UIImage imageNamed:@"SignInWithQQ.png"];
    frame = imageView2.frame;
    frame.size.height = image2.size.height / (image2.size.width / (WIDTH - 80));
    imageView2.frame = frame;
    imageView2.image = image2;
    [mainView addSubview:imageView2];
    
    UIButton *buttonSignIn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSignIn2.frame = imageView2.frame;
    [buttonSignIn2 addTarget:self action:@selector(clickSignIn:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:buttonSignIn2];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView2.frame.origin.y + imageView2.frame.size.height + 20, WIDTH - 80, 30)];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:@"登录后意味着你同意MONO的<<使用协议>>"];
    [mutStr addAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 14)];
    [mutStr addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} range:NSMakeRange(14, 8)];
    [label2 setAttributedText:mutStr];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:13.f];
    [mainView addSubview:label2];
    
    
}

- (void)back:(UIButton *)sender {
    self.backBlock();
}

- (void)clickSignIn:(UIButton *)sender {
    if (sender.frame.origin.y == 70) {
        
    } else {
        self.goToSignInVCBlock();
    }
}


@end
