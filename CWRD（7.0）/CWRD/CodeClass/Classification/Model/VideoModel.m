//
//  VideoModel.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (VideoModel *)shareJsonWithDictionary:(NSDictionary *)dictionary
{
    VideoModel *model = [[VideoModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

@end
