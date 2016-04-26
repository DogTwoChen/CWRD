//
//  ClassificationModel.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ClassificationModel.h"

@implementation ClassificationModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (ClassificationModel *)shareJsonWithDictionary:(NSDictionary *)dictionary
{
    ClassificationModel *model = [[ClassificationModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
@end
