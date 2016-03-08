//
//  SettingTableViewCell.m
//  ProjectA
//
//  Created by JiangChile on 16/3/8.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    self.contentView.backgroundColor = MONO_COLOR_DARK;
    
    self.labelMenuText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetHeight(self.contentView.frame), 0, 200, CGRectGetHeight(self.contentView.frame))];
    self.labelMenuText.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.52 alpha:1.0];
    [self.contentView addSubview:self.labelMenuText];
    
    self.imageViewMenu = [[UIImageView alloc] initWithFrame:CGRectMake(13, 13, 20, 20)];
    [self.contentView addSubview:self.imageViewMenu];
}



@end
