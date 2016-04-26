//
//  DetailModel.h
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface DetailModel : NSObject
{
    NSString *_description;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *coverBlurred;
@property (nonatomic, strong) NSString *coverForDetail;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *idx;
//描述
@property (nonatomic, strong) NSString *description;
//收藏数
@property (nonatomic, strong) NSNumber *collectionCount;
//播放数
@property (nonatomic, strong) NSNumber *playCount;
//分享数
@property (nonatomic, strong) NSNumber *shareCount;

//播放网址(数组里包含url,根据type:high高清/normal标清)
@property (nonatomic, strong) NSArray *playInfo;
@property (nonatomic, strong) NSString *playUrl;

@property (nonatomic, strong) NSString *rawWebUrl;



+ (DetailModel *)shareListModelWithVideoList:(NSDictionary *)VideoList consumption:(NSDictionary *)consumption;

@end
