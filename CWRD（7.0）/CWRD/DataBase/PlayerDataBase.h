//
//  PlayerDataBase.h
//  WXMusic
//
//  Created by 漫步人生路 on 15/9/9.
//  Copyright (c) 2015年 漫步人生路. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DetailModel.h"
#import "PKModel.h"
@interface PlayerDataBase : NSObject
@property (nonatomic, strong) FMDatabase *dataBase;
//创建单例类
+ (PlayerDataBase *)shareDataBase;
//指定数据库路径
- (NSString *)sqlitePaths:(NSString *)sqlitePaths;
//打开数据库
- (void)openSqliteWithPaths:(NSString *)paths;
//关闭数据库
- (void)closeSqlite;
//建表
- (void)createCollectList;
//插入一条数据
- (void)insertVideoWithModel:(DetailModel *)model;
- (void)insertReadingWithModel:(PKModel *)model;
//获取所有数据
- (NSMutableArray *)selegetAllVideoList;
- (NSMutableArray *)selegetAllReadingList;
//删除收藏的一条数据
- (void)deleteCollectVideoModelWithTitle:(NSString *)title;
- (void)deleteCollectReadingModelWithTitle:(NSString *)title;

@end
