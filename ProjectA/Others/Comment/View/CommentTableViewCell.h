//
//  CommentTableViewCell.h
//  ProjectA
//
//  Created by JiangChile on 16/3/10.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseTableViewCell.h"

#import "CommentModel.h"

@interface CommentTableViewCell : BaseTableViewCell


/** comment model */
@property (nonatomic, retain) CommentModel *model;

@end
