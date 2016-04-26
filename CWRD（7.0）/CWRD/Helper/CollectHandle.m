//
//  CollectHandle.m
//  CWRD
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "CollectHandle.h"
#import "DetailModel.h"
#import "PKModel.h"
#import "PlayerDataBase.h"

@implementation CollectHandle

static CollectHandle *collect;
+ (CollectHandle *)shareCollectVideo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (collect == nil) {
            collect = [[CollectHandle alloc] init];
            collect.isCollected = NO;
            collect.isCollectedRead = NO;
            collect.isPassTouchID = NO;
        }
    });
    return collect;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}
//视频收藏数组
- (NSMutableArray *)collectArray {
    if (!_collectArray) {
        _collectArray = [[NSMutableArray alloc] init];
    }
    return _collectArray;
}
//阅读收藏数组
- (NSMutableArray *)collectReadArray {
    if (!_collectReadArray) {
        _collectReadArray = [[NSMutableArray alloc] init];
    }
    return _collectReadArray;
}


#pragma mark ------------- 视频收藏操作 -------------

//收藏-放入数组
- (void)collect {
    DetailModel *model = self.modelArray[self.index];
    [[PlayerDataBase shareDataBase] insertVideoWithModel:model];
}
//取消收藏-移出数组
- (void)cancelCollect {
    DetailModel *model = self.modelArray[self.index];
    [[PlayerDataBase shareDataBase] deleteCollectVideoModelWithTitle:model.title];
}
//遍历数组看是否收藏
- (void)yesOrNoCollect {
    int count = 0;
    self.collectArray = [[PlayerDataBase shareDataBase] selegetAllVideoList];
    for (int i = 0; i < self.collectArray.count; i++) {
        if ([[self.collectArray[i] title] isEqualToString:[self.modelArray[self.index] title]]) {
            self.isCollected = YES;
            count = 1;
        }
    }
    if (count != 1) {
        self.isCollected = NO;
    }
}


#pragma mark ------------- 阅读收藏操作 --------------

//放入阅读收藏数组
- (void)collectRead {
    PKModel *model = self.modelArray[self.index];
    [[PlayerDataBase shareDataBase] insertReadingWithModel:model];
}
//移出阅读收藏数组
- (void)cancelCollectRead {
    PKModel *model = self.modelArray[self.index];
    [[PlayerDataBase shareDataBase] deleteCollectReadingModelWithTitle:model.title];
}
//遍历阅读数组看是否收藏
- (void)yesOrNoCollectRead {
    int count = 0;
    self.collectReadArray = [[PlayerDataBase shareDataBase] selegetAllReadingList];
    for (int i = 0; i < self.collectReadArray.count; i++) {
        if ([[self.collectReadArray[i] title] isEqualToString:[self.modelArray[self.index] title]]) {
            self.isCollectedRead = YES;
            count = 1;
        }
    }
    if (count != 1) {
        self.isCollectedRead = NO;
    }
}



@end
