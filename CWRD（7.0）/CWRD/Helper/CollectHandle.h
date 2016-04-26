//
//  CollectHandle.h
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectHandle : NSObject

+ (CollectHandle *)shareCollectVideo;
//是否收藏
@property (nonatomic) BOOL isCollected;
//阅读是否收藏
@property (nonatomic) BOOL isCollectedRead;

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, assign) NSInteger index;
//视频收藏列表数组
@property (nonatomic, strong) NSMutableArray *collectArray;
//阅读收藏列表数组
@property (nonatomic, strong) NSMutableArray *collectReadArray;
//是否通过touch ID检测
@property (nonatomic) BOOL isPassTouchID;

//放入收藏数组
- (void)collect;
//移出收藏数组
- (void)cancelCollect;
//遍历数组看是否收藏
- (void)yesOrNoCollect;


//放入阅读收藏数组
- (void)collectRead;
//移出阅读收藏数组
- (void)cancelCollectRead;
//遍历阅读数组看是否收藏
- (void)yesOrNoCollectRead;



@end
