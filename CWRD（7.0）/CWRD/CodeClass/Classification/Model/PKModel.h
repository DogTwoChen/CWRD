//
//  PKModel.h
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKModel : NSObject
{
    NSString *_id;
}
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *coverimg;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *typeid;
@property (nonatomic, strong) NSString *typename;

+ (PKModel *)shareJsonWithColumnsDictionary:(NSDictionary *)columnsDictionary listDictionary:(NSDictionary *)listDictionary;
@end
