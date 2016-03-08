//
//  SpecialCollectionViewCell.m
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface SpecialCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageViewThumb;

@property (nonatomic, retain) UILabel *labelTitle;

/** 底部订阅和篇数 */
@property (nonatomic, retain) UILabel *labelINFO;

@end

@implementation SpecialCollectionViewCell

- (void)setModel:(SpecialListModel *)model {
    _model = model;
    
    [self.imageViewThumb sd_setImageWithURL:[NSURL URLWithString:model.thumb.raw]];
    
    self.labelTitle.text = model.title;
    
    NSInteger len1 = [NSString stringWithFormat:@"%ld", model.subscriber_num].length;
    NSInteger len2 = [NSString stringWithFormat:@"%ld", model.content_num].length;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld人订阅 | %ld篇", model.subscriber_num, model.content_num]];
    [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(0, len1)];
    [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(len1 + 5, len2)];
    [self.labelINFO setAttributedText:attStr];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    // 此处必须使用bounds(x, y) -> (0, 0)
    self.imageViewThumb = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageViewThumb.alpha = ALPHA;
    [self.contentView addSubview:self.imageViewThumb];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:self.bounds];
    self.labelTitle.font = [UIFont fontWithName:@"STKaiti" size:20.f];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.numberOfLines = 0;
    self.labelTitle.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelTitle];
    
    self.labelINFO = [[UILabel alloc] initWithFrame:CGRectMake(0, WIDTH / 2 - 30, WIDTH / 2, 20)];
    self.labelINFO.textAlignment = NSTextAlignmentCenter;
    self.labelINFO.font = [UIFont systemFontOfSize:13.f];
    self.labelINFO.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelINFO];
    
}

@end
