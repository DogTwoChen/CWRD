//
//  VideoModel.h
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

//图片
@property (nonatomic,strong)NSString *bgPicture;
//分类
@property (nonatomic,strong)NSString *name;

+ (VideoModel *)shareJsonWithDictionary:(NSDictionary *)dictionary;

@end
