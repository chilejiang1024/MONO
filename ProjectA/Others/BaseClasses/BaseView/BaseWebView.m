//
//  BaseWebView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/27.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseWebView.h"

@interface BaseWebView () <UIWebViewDelegate>

@property (nonatomic, retain) NSString *url;

@property (nonatomic, retain) UIButton *backButton;

@end

@implementation BaseWebView

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url{
    if (self = [super initWithFrame:frame]) {
        self.url = url;
        [self createView];
    }
    return self;
}

- (void)createView {
    self.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self loadRequest:request];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(30, HEIGHT - 100, 30, 30);
    [self.backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
}

- (void)clickBackButton:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = WIDTH;
        self.frame = frame;
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

@end
