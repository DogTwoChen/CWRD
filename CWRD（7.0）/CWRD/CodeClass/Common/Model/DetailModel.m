//
//  DetailModel.m
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

@synthesize description = _description;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (DetailModel *)shareListModelWithVideoList:(NSDictionary *)videoList consumption:(NSDictionary *)consumption {
    DetailModel *model = [[DetailModel alloc] init];
    [model setValuesForKeysWithDictionary:videoList];
    [model setValuesForKeysWithDictionary:consumption];
    return model;
}

@end
