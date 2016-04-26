//
//  ArticleModel.h
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *text;
@property (nonatomic,strong) NSString *title;

+ (ArticleModel *)shareJsonWithDictionary:(NSDictionary *)dictionary;
@end