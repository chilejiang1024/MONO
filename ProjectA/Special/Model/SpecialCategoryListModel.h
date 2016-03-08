//
//  SpecialCategoryListModel.h
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@interface SpecialCategoryListModel : BaseModel

@property (nonatomic, retain) NSMutableArray *specialList;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, copy) NSString *category_ename;

@property (nonatomic, assign) NSInteger special_num;

/** array for category_list */
+ (NSMutableArray *)getSpecialCategoryListModelArrayWithArray:(NSArray *)array;

@end



