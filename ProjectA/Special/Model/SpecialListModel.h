//
//  SpecialTopModel.h
//  ProjectA
//
//  Created by JiangChile on 16/2/29.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@class Special_Logo_Url,Special_Thumb,Special_Content;


@interface SpecialListModel : BaseModel

@property (nonatomic, strong) Special_Logo_Url *logo_url;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *share_text;

@property (nonatomic, copy) NSString *content_update_time;

@property (nonatomic, strong) Special_Thumb *thumb;

@property (nonatomic, copy) NSString *title_font;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *share_image;

@property (nonatomic, assign) NSInteger content_num;

@property (nonatomic, assign) NSInteger subscriber_num;

@property (nonatomic, strong) Special_Content *content;

/** array for tops */
+ (NSMutableArray *)getSpecialListModelArrayWithArray:(NSArray *)array;

@end




@interface Special_Logo_Url : BaseModel

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end





@interface Special_Thumb : BaseModel

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end





@interface Special_Content : BaseModel

@property (nonatomic, copy) NSString *desc;

@end

