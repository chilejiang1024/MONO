//
//  CommentTableViewCell.m
//  ProjectA
//
//  Created by JiangChile on 16/3/10.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "CommentTableViewCell.h"

#import "UIImageView+WebCache.h"

@interface CommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUserAvatar;

@property (weak, nonatomic) IBOutlet UILabel *labelUserName;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (weak, nonatomic) IBOutlet UILabel *labelCommentText;

@property (weak, nonatomic) IBOutlet UILabel *labelBangNum;

@end

@implementation CommentTableViewCell


- (void)setModel:(CommentModel *)model {
    _model = model;
    
    [self.imageViewUserAvatar sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_url]];
    self.labelUserName.text = _model.user.name;
    self.labelBangNum.text = @" Bang!";
    self.labelCommentText.text = _model.text;
    
    NSString *time = [[NSString stringWithFormat:@"%@", [NSDate dateWithTimeIntervalSince1970: 1457579323]] substringWithRange:NSMakeRange(5, 11)];
    self.labelTime.text = time;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageViewUserAvatar.layer.cornerRadius = 30;
    self.imageViewUserAvatar.clipsToBounds = YES;
    
}


@end
