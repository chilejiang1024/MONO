//
//  WaterfallModel.h
//  ProjectA
//
//  Created by JiangChile on 16/2/24.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@class ItemModel,ThumbModel,ContentModel,CpModel,WaterFallSpecialModel;

@interface WaterfallModel : BaseModel

@property (nonatomic, assign) NSInteger current_date;

@property (nonatomic, strong) ItemModel *item;

+ (NSArray *)getWaterfallArrayWithArray:(NSArray *)array;

@end

@interface ItemModel : BaseModel

@property (nonatomic, copy) NSString *item_url;

@property (nonatomic, strong) ThumbModel *thumb;

@property (nonatomic, copy) NSString *share_text;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *type_name;

@property (nonatomic, strong) CpModel *cp;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger create_at;

@property (nonatomic, copy) NSString *read_time;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) WaterFallSpecialModel *special;

@property (nonatomic, assign) NSInteger today;

@property (nonatomic, copy) NSString *share_image;

@property (nonatomic, assign) BOOL is_recommended;

@property (nonatomic, assign) BOOL has_video;

@property (nonatomic, strong) ContentModel *content;

@end

@interface ThumbModel : BaseModel

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@interface ContentModel : BaseModel

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *text_align;

@end

@interface CpModel : BaseModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *apk_store_url;

@property (nonatomic, copy) NSString *app_store_url;

@property (nonatomic, copy) NSString *weibo_name;

@property (nonatomic, assign) NSInteger Id;

/** 描述是这个 */
@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *web_site_url;

@property (nonatomic, copy) NSString *avatar_large;

@property (nonatomic, copy) NSString *wechat_uid;

@end

@interface WaterFallSpecialModel : BaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *title;

@end

