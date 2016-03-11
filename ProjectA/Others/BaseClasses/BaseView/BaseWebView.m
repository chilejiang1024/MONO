//
//  BaseWebView.m
//  ProjectA
//
//  Created by JiangChile on 16/2/27.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseWebView.h"
#import "CommentView.h"

@interface BaseWebView () <UIWebViewDelegate>

@property (nonatomic, retain) NSString *url;

@property (nonatomic, retain) UIButton *backButton;

@property (nonatomic, retain) UIButton *likeButton;

@property (nonatomic, retain) UIButton *commentButton;

@property (nonatomic, retain) UIButton *shareButton;


@end

@implementation BaseWebView

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url{
    frame.origin.y = -49;
    frame.size.height += 49;
    if (self = [super initWithFrame:frame]) {
        self.url = url;
        [self createView];
    }
    return self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)createView {
    self.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self loadRequest:request];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(30, 0, 30, 30);
    [self.backButton setImage:[UIImage imageNamed:@"icon-back.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likeButton.frame = CGRectMake(200, 0, 30, 30);
    [self.likeButton setImage:[UIImage imageNamed:@"bottom_btn_like@2x.png"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"bottom_btn_liked@2x.png"] forState:UIControlStateSelected];
    [self.likeButton addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton.frame = CGRectMake(250, 0, 30, 30);
    [self.commentButton setImage:[UIImage imageNamed:@"bottom_btn_comment@2x"] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(300, 0, 30, 30);
    [self.shareButton setImage:[UIImage imageNamed:@"bottom_btn_share@2x.png"] forState:UIControlStateNormal];
    
    UIView *viewPanel = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 50, WIDTH, 30)];
    [viewPanel addSubview:self.backButton];
    [viewPanel addSubview:self.likeButton];
    [viewPanel addSubview:self.commentButton];
    [viewPanel addSubview:self.shareButton];
    [self addSubview:viewPanel];
    
}

#pragma mark - 滑动协议方法

// 禁止下滑
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}


#pragma mark - selector

- (void)clickBackButton:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = WIDTH;
        self.frame = frame;
    }];
}

- (void)clickLikeButton:(UIButton *)sender {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] != nil) {
        sender.selected = !sender.selected;
        NSString *strId = [self.url substringFromIndex:[@"http://mmmono.com/item/" length]];
        if (sender.selected) {
            [[MONOTools shareTools] likeThisArticleWithURL:[NSString stringWithFormat:URL_FAV, strId]];
        } else {
            [[MONOTools shareTools] unlikeThisArticleWithURL:[NSString stringWithFormat:URL_FAV, strId]];
        }
    } else {
        [self notSignIn];
    }
}

- (void)clickShareButton:(UIButton *)sender {
    
    
    
    
}

- (void)clickCommentButton:(UIButton *)sender {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] != nil) {
        CommentView *commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT) URL:self.url];
        [self addSubview:commentView];
    } else {
        [self notSignIn];
    }
    
    
}

- (void)notSignIn {
    UILabel *labelAlert= [[UILabel alloc] initWithFrame:CGRectMake(0, 50, WIDTH, 50)];
    labelAlert.backgroundColor = [UIColor blackColor];
    labelAlert.alpha = 0;
    labelAlert.text = @"未登录";
    labelAlert.textAlignment = NSTextAlignmentCenter;
    labelAlert.textColor = [UIColor whiteColor];
    [self addSubview:labelAlert];
    [UIView animateWithDuration:0.3 animations:^{
        labelAlert.alpha = 0.8;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            labelAlert.alpha = 0;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [labelAlert removeFromSuperview];
        });
    });
    
}



@end
