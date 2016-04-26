//
//  ArticleModel.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (ArticleModel *)shareJsonWithDictionary:(NSDictionary *)dictionary {
    ArticleModel *model = [[ArticleModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
@end
