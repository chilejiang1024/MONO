//
//  FavContentTableViewCell.h
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseTableViewCell.h"

@class Items;

@interface FavContentTableViewCell : BaseTableViewCell

/** user fav list item model */
@property (nonatomic, retain) Items *model;

@end
