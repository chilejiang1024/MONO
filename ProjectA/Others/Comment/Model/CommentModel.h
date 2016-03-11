//
//  CommentModel.h
//  ProjectA
//
//  Created by JiangChile on 16/3/10.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@class CommentUser,CommentCoordinate;

@interface CommentModel : BaseModel

@property (nonatomic, copy) NSString *action;

@property (nonatomic, assign) NSInteger bang_num;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, assign) NSInteger replies_num;

@property (nonatomic, strong) NSArray *reply_list;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger created_time;

@property (nonatomic, strong) CommentUser *user;

+ (NSMutableArray *)getCommentModelArrayWithArray:(NSMutableArray *)array;

@end


@interface CommentUser : BaseModel

@property (nonatomic, assign) NSInteger horoscope;

@property (nonatomic, strong) CommentCoordinate *coordinate;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) BOOL is_anonymous;

@property (nonatomic, copy) NSString *self_description;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *name;

@end


@interface CommentCoordinate : BaseModel

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger latitude;

@end

