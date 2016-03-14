//
//  DynamicCollectionViewCell.h
//  ProjectA
//
//  Created by JiangChile on 16/3/12.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseCollectionViewCell.h"

#import "WaterfallModel.h"

@interface DynamicCollectionViewCell : BaseCollectionViewCell

/** cp model */
@property (nonatomic, retain) CpModel *model;

@end
