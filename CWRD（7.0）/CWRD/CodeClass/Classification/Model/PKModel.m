//
//  PKModel.m
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "PKModel.h"

@implementation PKModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (PKModel *)shareJsonWithColumnsDictionary:(NSDictionary *)columnsDictionary listDictionary:(NSDictionary *)listDictionary {
    PKModel *pkModel = [[PKModel alloc]init];
    [pkModel setValuesForKeysWithDictionary:columnsDictionary];
    [pkModel setValuesForKeysWithDictionary:listDictionary];
    return pkModel;
}

@end
