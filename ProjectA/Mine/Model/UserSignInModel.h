//
//  UserSignInModel.h
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@class Coordinate;


@interface UserSignInModel : BaseModel

@property (nonatomic, assign) NSInteger horoscope;

@property (nonatomic, strong) Coordinate *coordinate;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) BOOL id_old_user;

@property (nonatomic, assign) BOOL is_anonymous;

@property (nonatomic, copy) NSString *self_description;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *name;

@end


@interface Coordinate : BaseModel

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger latitude;

@end

