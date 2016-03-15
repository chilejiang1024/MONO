//
//  CreatorINFOView.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CreatorINFOView.h"

#import "UIImageView+WebCache.h"

@interface CreatorINFOView ()

@property (nonatomic, retain) CpModel *model;

/** sina */
@property (nonatomic, retain) UILabel *labelSina;

/** we chat */
@property (nonatomic, retain) UILabel *labelWeChat;

/** url */
@property (nonatomic, retain) UILabel *labelURL;

@end

@implementation CreatorINFOView

- (instancetype)initWithFrame:(CGRect)frame CpModel:(CpModel *)model{
    if (self = [super initWithFrame:frame]) {
        _model = model;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.8;
    [self addSubview:backgroundView];
    
    [self createMainView];
    
}

- (void)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 20, 270)];
    mainView.center = self.center;
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 10;
    [self addSubview:mainView];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, WIDTH - 40, 2)];
    line1.backgroundColor = [UIColor blackColor];
    [mainView addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, WIDTH - 40, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [mainView addSubview:line2];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, WIDTH - 40, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [mainView addSubview:line3];
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, WIDTH - 40, 1)];
    line4.backgroundColor = [UIColor lightGrayColor];
    [mainView addSubview:line4];
    
    UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, WIDTH - 40, 1)];
    line5.backgroundColor = [UIColor lightGrayColor];
    [mainView addSubview:line5];
    
    UIImageView *imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    imageViewAvatar.layer.cornerRadius = 15;
    imageViewAvatar.clipsToBounds = YES;
    [imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    [mainView addSubview:imageViewAvatar];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 100, 30)];
    labelName.text = _model.screen_name;
    [mainView addSubview:labelName];
    
    UILabel *labelCooperation = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 40 - 100, 25, 100, 30)];
    labelCooperation.text = @"合作媒体";
    labelCooperation.font = [UIFont systemFontOfSize:13.f];
    labelCooperation.textColor = [UIColor cyanColor];
    labelCooperation.textAlignment = NSTextAlignmentRight;
    [mainView addSubview:labelCooperation];
    
    UILabel *labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, WIDTH - 40, 60)];
    labelDescription.text = _model.Description;
    labelDescription.numberOfLines = 0;
    labelDescription.font = [UIFont systemFontOfSize:13.f];
    labelDescription.textColor = [UIColor lightGrayColor];
    [mainView addSubview:labelDescription];
    
    UIImageView *imageViewSina = [[UIImageView alloc] initWithFrame:CGRectMake(20, 140, 30, 20)];
    imageViewSina.image = [UIImage imageNamed:@"sina.jpg"];
    [mainView addSubview:imageViewSina];
    
    UIImageView *imageViewWeiChat = [[UIImageView alloc] initWithFrame:CGRectMake(20, 180, 25, 20)];
    imageViewWeiChat.image = [UIImage imageNamed:@"weichat.jpg"];
    [mainView addSubview:imageViewWeiChat];
    
    UIImageView *imageViewURL = [[UIImageView alloc] initWithFrame:CGRectMake(20, 220, 20, 20)];
    imageViewURL.image = [UIImage imageNamed:@"lianjie.png"];
    [mainView addSubview:imageViewURL];
    
    self.labelSina = [[UILabel alloc] initWithFrame:CGRectMake(60, 130, 100, 40)];
    self.labelSina.textColor = [UIColor colorWithRed:0.80 green:0.06 blue:0.09 alpha:1.0];
    self.labelSina.text = _model.weibo_name;
    self.labelSina.font = [UIFont systemFontOfSize:14.f];
    [mainView addSubview:self.labelSina];
    
    self.labelWeChat = [[UILabel alloc] initWithFrame:CGRectMake(60, 170, 100, 40)];
    self.labelWeChat.textColor = [UIColor colorWithRed:0.47 green:0.73 blue:0.09 alpha:1.0];
    self.labelWeChat.text = _model.wechat_uid;
    self.labelWeChat.font = [UIFont systemFontOfSize:14.f];
    [mainView addSubview:self.labelWeChat];
    
    self.labelURL = [[UILabel alloc] initWithFrame:CGRectMake(60, 210, 200, 40)];
    self.labelURL.textColor = [UIColor colorWithRed:0.28 green:0.60 blue:0.87 alpha:1.0];
    self.labelURL.text = _model.web_site_url;
    self.labelURL.font = [UIFont systemFontOfSize:14.f];
    [mainView addSubview:self.labelURL];
    
    UIButton *buttonSina = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSina.frame = CGRectMake(WIDTH - 40 - 70, 140, 70, 20);
    buttonSina.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [buttonSina setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [buttonSina setTitle:@"点击复制" forState:UIControlStateNormal];
    [buttonSina addTarget:self action:@selector(buttonClickSelector:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:buttonSina];
    
    UIButton *buttonWeChat = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonWeChat.frame = CGRectMake(WIDTH - 40 - 70, 180, 70, 20);
    buttonWeChat.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [buttonWeChat setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [buttonWeChat setTitle:@"点击复制" forState:UIControlStateNormal];
    [buttonWeChat addTarget:self action:@selector(buttonClickSelector:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:buttonWeChat];
    
    UIButton *buttonUrl = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonUrl.frame = CGRectMake(WIDTH - 40 - 70, 220, 70, 20);
    buttonUrl.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [buttonUrl setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [buttonUrl setTitle:@"访问网站" forState:UIControlStateNormal];
    [buttonUrl addTarget:self action:@selector(buttonClickSelector:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:buttonUrl];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(WIDTH / 2 - 10, HEIGHT / 2 + 135 + 20, 20, 20);
    [buttonBack setImage:[UIImage imageNamed:@"icon-x.png"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(disappearThisView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonBack];
    
    
}

- (void)disappearThisView:(UIButton *)sender {
    self.disappearViewBlock();
}

- (void)buttonClickSelector:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (sender.frame.origin.y == 140) {
        NSLog(@"%@", _model.weibo_name);
        pasteboard.string = _model.weibo_name;
    } else if (sender.frame.origin.y == 180) {
        NSLog(@"%@", _model.wechat_uid);
        pasteboard.string = _model.wechat_uid;
    } else {
        // 打开浏览器, 打开网址, 就这一句 ... 还以为多难 ... 通过URL来定位app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.web_site_url]];

    }
}

@end
