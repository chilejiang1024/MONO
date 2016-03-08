//
//  SpicalModel.h
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"
#import "SpecialListModel.h"
#import "SpecialCategoryListModel.h"

@interface SpecialModel : BaseModel

/** tops */
@property (nonatomic, retain) NSMutableArray *tops;

/** category_list */
@property (nonatomic, retain) NSMutableArray *category_list;


+ (SpecialModel *)getSpecialModelWithDic:(NSDictionary *)dic;


@end
