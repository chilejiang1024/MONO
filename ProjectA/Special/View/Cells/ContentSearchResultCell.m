//
//  ContentSearchResultCell.m
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "ContentSearchResultCell.h"
#import "UIImageView+WebCache.h"


@interface ContentSearchResultCell ()

@property (nonatomic, retain) UIImageView *imageViewThumb;

@property (nonatomic, retain) UILabel *labelSpecialTitle;

@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UILabel *labelCPScreenName;

@end

@implementation ContentSearchResultCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setModel:(ItemModel *)model {
    _model = model;
    
    [self.imageViewThumb sd_setImageWithURL:[NSURL URLWithString:_model.thumb.raw]];
    
    if ([_model.special.title isEqualToString:@""]) {
        self.labelSpecialTitle.text = [NSString stringWithFormat:@"/%@", _model.type_name];
    } else {
        self.labelSpecialTitle.text = [NSString stringWithFormat:@"/%@", _model.special.title];
    }
    
    self.labelTitle.text = _model.title;
    self.labelCPScreenName.text = _model.cp.screen_name;
    
}

- (void)createView {
    self.imageViewThumb = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewThumb];
    
    self.labelSpecialTitle = [[UILabel alloc] init];
    self.labelSpecialTitle.font = [UIFont systemFontOfSize:15.f];
    self.labelSpecialTitle.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.labelSpecialTitle];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.numberOfLines = 0;
    [self.contentView addSubview:self.labelTitle];
    
    self.labelCPScreenName = [[UILabel alloc] init];
    self.labelCPScreenName.font = [UIFont systemFontOfSize:15.f];
    self.labelCPScreenName.textColor = MONO_COLOR_CYAN;
    [self.contentView addSubview:self.labelCPScreenName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageViewThumb.frame = CGRectMake(10, 5, 120, self.frame.size.height - 10);
    self.labelSpecialTitle.frame = CGRectMake(140, 5, 200, 15);
    self.labelTitle.frame = CGRectMake(140, 30, WIDTH - 150, 50);
    self.labelCPScreenName.frame = CGRectMake(140, 80, 100, 20);
}

@end
