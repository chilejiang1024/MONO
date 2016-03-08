//
//  TeaModel.h
//  ProjectA
//
//  Created by JiangChile on 16/3/5.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@interface TeaModel : BaseModel


@property (nonatomic, copy) NSString *release_date;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *read_time;

@property (nonatomic, copy) NSString *bg_img_url;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *push_msg;

@property (nonatomic, copy) NSString *share_image;

@property (nonatomic, assign) NSInteger kind;

@property (nonatomic, copy) NSString *share_text;



@end
