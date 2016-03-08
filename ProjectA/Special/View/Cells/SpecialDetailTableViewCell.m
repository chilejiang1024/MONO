//
//  SpecialDetailTableViewCell.m
//  ProjectA
//
//  Created by JiangChile on 16/3/4.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SpecialDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface SpecialDetailTableViewCell ()

@property (nonatomic, retain) UIImageView *imageViewAvatar;

@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UILabel *labelDetail;

@end

@implementation SpecialDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setCpModel:(CpModel *)cpModel {
    _cpModel = cpModel;
    
    [self.imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:_cpModel.avatar]];
    self.labelTitle.text = _cpModel.screen_name;
    self.labelDetail.text = _cpModel.Description;
    self.labelDetail.hidden = NO;
}

- (void)setRecSubModel:(RecentSubscriberModel *)recSubModel {
    _recSubModel = recSubModel;
    
    [self.imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:_recSubModel.avatar_url]];
    self.labelTitle.text = _recSubModel.name;
    self.labelDetail.hidden = YES;
}

- (void)createView {
    self.imageViewAvatar = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewAvatar];
    
    self.labelTitle = [[UILabel alloc] init];
    [self.contentView addSubview:self.labelTitle];
    
    self.labelDetail = [[UILabel alloc] init];
    self.labelDetail.numberOfLines = 0;
    self.labelDetail.font = [UIFont systemFontOfSize:15.f];
    [self.contentView addSubview:self.labelDetail];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageViewAvatar.frame = CGRectMake(20, 30, 40, 40);
    self.imageViewAvatar.layer.cornerRadius = 20;
    self.imageViewAvatar.clipsToBounds = YES;
    
    if (!self.labelDetail.hidden) {
        self.labelTitle.frame = CGRectMake(80, 20, 200, 20);
        self.labelDetail.frame = CGRectMake(80, 50, WIDTH - 100, 40);
    } else {
        self.labelTitle.frame = CGRectMake(80, 40, 200, 20);
    }
    
}

@end
