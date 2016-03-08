//
//  CreatorHomeTableViewCell.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CreatorHomeTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CreatorHomeTableViewCell ()

/** <#comment#> */
@property (nonatomic, retain) UIImageView *imageViewAvator;

/** <#comment#> */
@property (nonatomic, retain) UILabel *labelScreenName;

/** <#comment#> */
@property (nonatomic, retain) UILabel *labelDescription;

@end

@implementation CreatorHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setModel:(CpModel *)model {
    _model = model;
    
    [self.imageViewAvator sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    self.labelScreenName.text = _model.screen_name;
    self.labelDescription.text = _model.Description;
}

- (void)createView {
    self.imageViewAvator = [[UIImageView alloc] init];
    self.imageViewAvator.clipsToBounds = YES;
    [self.contentView addSubview:self.imageViewAvator];
    
    self.labelScreenName = [[UILabel alloc] init];
    self.labelScreenName.font = [UIFont systemFontOfSize:18.f];
    [self.contentView addSubview:self.labelScreenName];
    
    self.labelDescription = [[UILabel alloc] init];
    self.labelDescription.font = [UIFont systemFontOfSize:15.f];
    self.labelDescription.numberOfLines = 0;
    [self.contentView addSubview:self.labelDescription];
}

- (void)layoutSubviews {
    self.imageViewAvator.frame = CGRectMake(20, 30, 40, 40);
    self.imageViewAvator.layer.cornerRadius = 20;
    
    self.labelScreenName.frame = CGRectMake(80, 20, 100, 30);
    
    self.labelDescription.frame = CGRectMake(80, 50, WIDTH - 100, 50);
}

@end
