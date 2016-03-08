//
//  UserFavListModel.h
//  ProjectA
//
//  Created by JiangChile on 16/3/7.
//  Copyright (c) 2016年 JiangChile. All rights reserved.
//

#import "BaseModel.h"

@class Items,User,Image_Gallery,Images,Image,Text;

@interface UserFavListModel : BaseModel

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) NSInteger user_fav_num;

@property (nonatomic, assign) NSInteger page;


@end


@interface Items : BaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *text_align;

@property (nonatomic, assign) NSInteger created_at;

@property (nonatomic, assign) NSInteger action_count;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Image *image;

@property (nonatomic, assign) NSInteger item_type;

@property (nonatomic, strong) Text *text;

@property (nonatomic, assign) NSInteger read_count;

@property (nonatomic, strong) Image_Gallery *image_gallery;

@property (nonatomic, assign) NSInteger package_date;

@property (nonatomic, assign) NSInteger share_count;

@property (nonatomic, strong) User *user;

@property (nonatomic, assign) BOOL has_video;

@property (nonatomic, copy) NSString *item_url;

+ (NSMutableArray *)getItemsArrayWithArray:(NSMutableArray *)array;

@end



@interface User : BaseModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *web_site_url;

@property (nonatomic, copy) NSString *apk_store_url;

@property (nonatomic, copy) NSString *app_store_url;

@property (nonatomic, copy) NSString *weibo_name;

@property (nonatomic, assign) NSInteger Id;

/** user description */
@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *avatar_large;

@property (nonatomic, copy) NSString *wechat_uid;

@end



@interface Image_Gallery : BaseModel

@property (nonatomic, strong) NSArray *images;

@end



@interface Images : BaseModel

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, copy) NSString *caption;

@end



@interface Image : BaseModel

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end



@interface Text : BaseModel

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *entities;

@end

