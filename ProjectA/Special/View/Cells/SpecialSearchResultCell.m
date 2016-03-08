//
//  SpecialSearchResultCell.m
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialSearchResultCell.h"
#import "UIImageView+WebCache.h"

@interface SpecialSearchResultCell ()

@property (nonatomic, retain) UIImageView *imageViewThumb;

@property (nonatomic, retain) UIImageView *imageViewLogo;

@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UILabel *labelINFO;

@end

@implementation SpecialSearchResultCell

- (void)setModel:(SpecialListModel *)model {
    _model = model;
    
    [self.imageViewThumb sd_setImageWithURL:[NSURL URLWithString:_model.thumb.raw]];
    [self.imageViewLogo sd_setImageWithURL:[NSURL URLWithString:_model.logo_url.raw]];
    self.labelTitle.text = _model.title;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld订阅 | %ld篇", model.subscriber_num, model.content_num]];
    NSInteger len1 = [NSString stringWithFormat:@"%ld", model.subscriber_num].length;
    NSInteger len2 = [NSString stringWithFormat:@"%ld", model.content_num].length;
    [attStr addAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(0, len1)];
    [attStr addAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(len1 + 5, len2)];
    [self.labelINFO setAttributedText:attStr];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    self.contentView.backgroundColor = [UIColor blackColor];
    
    self.imageViewThumb = [[UIImageView alloc] init];
    // 截取中间部分显示
    self.imageViewThumb.contentMode = UIViewContentModeScaleAspectFill;
    self.imageViewThumb.clipsToBounds = YES;
    self.imageViewThumb.alpha = ALPHA;
    [self.contentView addSubview:self.imageViewThumb];
    
    self.imageViewLogo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewLogo];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont fontWithName:@"STKaiti" size:25.f];
    [self.contentView addSubview:self.labelTitle];
    
    self.labelINFO = [[UILabel alloc] init];
    self.labelINFO.textColor = [UIColor whiteColor];
    self.labelINFO.font = [UIFont systemFontOfSize:12.f];
    self.labelINFO.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.labelINFO];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageViewThumb.frame = self.contentView.bounds;
    self.imageViewLogo.frame = CGRectMake(20, 20, self.bounds.size.height - 40, self.bounds.size.height - 40);
    self.labelTitle.frame = CGRectMake(40 + self.imageViewLogo.frame.size.width, 20, 200, self.frame.size.height - 40);
    self.labelINFO.frame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
}

@end
