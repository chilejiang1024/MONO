//
//  SpecialDetailModel.h
//  ProjectA
//
//  Created by JiangChile on 16/3/3.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"
#import "WaterfallModel.h"

@class CoordinateModel;


@interface SpecialDetailModel : BaseModel

@property (nonatomic, retain) NSMutableArray *item_list;

@property (nonatomic, assign) NSInteger is_subscribed;

@property (nonatomic, retain) NSMutableArray *recent_subscribers;

@property (nonatomic, retain) NSMutableArray *cp_list;

@property (nonatomic, assign) NSInteger page;

+ (SpecialDetailModel *)getSpecialDetailModelWithDic:(NSDictionary *)dic;

@end


@interface RecentSubscriberModel : BaseModel

@property (nonatomic, assign) NSInteger horoscope;

@property (nonatomic, strong) CoordinateModel *coordinate;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) BOOL is_anonymous;

@property (nonatomic, copy) NSString *self_description;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *name;

+ (NSMutableArray *)getRecSubModelArrayWithArray:(NSArray *)array;

@end


@interface CoordinateModel : BaseModel

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger latitude;

@end

