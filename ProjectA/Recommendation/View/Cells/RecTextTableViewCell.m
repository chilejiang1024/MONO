//
//  RecTextTableViewCell.m
//  ProjectA
//
//  Created by JiangChile on 16/2/26.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "RecTextTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface RecTextTableViewCell ()

@property (nonatomic, retain) UILabel *labelType;

@property (nonatomic, retain) UIImageView *imageViewShow;

@property (nonatomic, retain) UILabel *labelTypeNum;

@property (nonatomic, retain) UILabel *labelTypeNumShow;

@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UILabel *labelDesc;

@property (nonatomic, retain) UIImageView *imageViewAvatar;

@property (nonatomic, retain) UILabel *labelScreenName;

@end

@implementation RecTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setWaterfallModel:(WaterfallModel *)waterfallModel {
    if (_waterfallModel != waterfallModel) {
        _waterfallModel = waterfallModel;
    }
    
    self.labelType.text = [NSString stringWithFormat:@"/%@", _waterfallModel.item.type_name];
    
    [self.imageViewShow sd_setImageWithURL:[NSURL URLWithString:_waterfallModel.item.thumb.raw]];
    CGRect frame = self.imageViewShow.frame;
    frame.size.height = _waterfallModel.item.thumb.height / (_waterfallModel.item.thumb.width / frame.size.width);
    self.imageViewShow.frame = frame;
    
    self.labelTypeNum.backgroundColor = MONO_COLOR;
    self.labelTypeNum.center = CGPointMake(35, frame.origin.y + frame.size.height + 30);
    
    self.labelTypeNumShow.center = self.labelTypeNum.center;
    self.labelTypeNumShow.text = [NSString stringWithFormat:@"%ld", _waterfallModel.item.type];
    
    self.labelTitle.text = _waterfallModel.item.title;
    CGRect frameNew = self.labelTitle.frame;
    frameNew.origin.y = frame.origin.y + frame.size.height + 3;
    self.labelTitle.frame = frameNew;
    
    self.labelDesc.text = _waterfallModel.item.content.desc;
    frame = self.labelDesc.frame;
    frame.origin.y = frameNew.origin.y + frameNew.size.height;
    CGFloat h = 15 * self.labelDesc.text.length / 22;
    frame.size.height = h < 50 ? h : 50;
    self.labelDesc.frame = frame;
    
    [self.imageViewAvatar sd_setImageWithURL:[NSURL URLWithString:_waterfallModel.item.cp.avatar]];
    frameNew = self.imageViewAvatar.frame;
    frameNew.origin.y = frame.origin.y + frame.size.height + 20;
    self.imageViewAvatar.frame = frameNew;
    
    self.labelScreenName.text = _waterfallModel.item.cp.screen_name;
    frame = self.labelScreenName.frame;
    frame.origin.y = frameNew.origin.y;
    self.labelScreenName.frame = frame;
    
}

- (void)createView {
    // 类型 高度 0~40
    self.labelType = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH - 20, 40)];
    self.labelType.font = [UIFont systemFontOfSize:11.f];
    self.labelType.textColor = MONO_COLOR;
    [self.contentView addSubview:self.labelType];
    
    // 展示图片 高度40~240
    self.imageViewShow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, WIDTH - 20, 200)];
    [self.contentView addSubview:self.imageViewShow];
    
    // 推荐等 270
    self.labelTypeNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 30, 30)];
    self.labelTypeNum.layer.cornerRadius = 5;
    self.labelTypeNum.clipsToBounds = YES;
    self.labelTypeNum.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.contentView addSubview:self.labelTypeNum];
    
    self.labelTypeNumShow = [[UILabel alloc] initWithFrame:self.labelTypeNum.frame];
    self.labelTypeNumShow.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.labelTypeNumShow];
    
    // title 320
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 270, WIDTH - 80, 50)];
    [self.contentView addSubview:self.labelTitle];
    
    // content->desc 370
    self.labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(70, 320, WIDTH - 90, 50)];
    self.labelDesc.numberOfLines = 0;
    self.labelDesc.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:self.labelDesc];
    
    // cp->avatar
    self.imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(70, 370, 30, 30)];
    self.imageViewAvatar.layer.cornerRadius = 15.f;
    self.imageViewAvatar.clipsToBounds = YES;
    [self.contentView addSubview:self.imageViewAvatar];
    
    //cp->screen_name
    self.labelScreenName = [[UILabel alloc] initWithFrame:CGRectMake(120, 370, 200, 30)];
    self.labelScreenName.textColor = MONO_COLOR;
    self.labelScreenName.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:self.labelScreenName];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
