//
//  DailySelectionModel.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "DailySelectionModel.h"

@implementation DailySelectionModel
@synthesize description = _description;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (DailySelectionModel *)shareJsonWithShowDictionary:(NSDictionary *)showDictionary DetailDictionary:(NSDictionary *)detialDictionary ConsumptionDictionary:(NSDictionary *)consumptionary{
    DailySelectionModel *model = [[DailySelectionModel alloc]init];
    [model setValuesForKeysWithDictionary:showDictionary];
    [model setValuesForKeysWithDictionary:detialDictionary];
    [model setValuesForKeysWithDictionary:consumptionary];
    return model;
}
@end
