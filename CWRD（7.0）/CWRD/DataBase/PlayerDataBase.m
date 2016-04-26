//
//  PlayerDataBase.m
//  WXMusic
//
//  Created by 漫步人生路 on 15/9/9.
//  Copyright (c) 2015年 漫步人生路. All rights reserved.
//

#import "PlayerDataBase.h"
@implementation PlayerDataBase
static PlayerDataBase *playerDataBase;
+ (PlayerDataBase *)shareDataBase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerDataBase = [[PlayerDataBase alloc]init];
    });
    return playerDataBase;
}
//创建fmdb
- (FMDatabase *)dataBase
{
    if (!_dataBase) {
        _dataBase = [[FMDatabase alloc]init];
    }
    return _dataBase;
}

//指定数据库路径
- (NSString *)sqlitePaths:(NSString *)sqlitePaths
{
    NSString *str = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:sqlitePaths];
//    NSLog(@"%@",str);
    return str;
}
//打开数据库
- (void)openSqliteWithPaths:(NSString *)paths
{

    self.dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:paths]];

}
//关闭数据
- (void)closeSqlite
{
    [self.dataBase close];
}
//创建数据库表
- (void)createCollectList {
    if (!_dataBase) {
        [self openSqliteWithPaths:@"CollectList.db"];
    }
    if ([_dataBase open]) {
        
        BOOL VideoUpdate = [_dataBase executeUpdate:@"CREATE TABLE VideoCollectList(VideoName TEXT,Type TEXT,Duration Integer,VideoImage TEXT,WebUrl TEXT)"];
        
        BOOL ReadingUpdate = [_dataBase executeUpdate:@"CREATE TABLE ReadingCollectList(ReadName TEXT,Type TEXT,Content TEXT,ReadImage TEXT,WebID TEXT)"];
        
        if (ReadingUpdate && VideoUpdate) {
//            NSLog(@"建表成功");
        }else
        {
//            NSLog(@"建表失败");
        }
    }
}


#pragma mark ---------- 插入一条数据 ----------
//视频
- (void)insertVideoWithModel:(DetailModel *)model {
    if (!model) {
//        NSLog(@"model为空");
        return;
    }
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:@"CollectList.db"]];
    }
    if ([_dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into VideoCollectList(VideoName,Type,Duration,VideoImage,WebUrl) values(?,?,?,?,?)"];
        BOOL insertModel = [_dataBase executeUpdate:sql,model.title,model.category,model.duration,model.coverForDetail,model.rawWebUrl];
        
        if (insertModel) {
//            NSLog(@"插入成功");
        }else
        {
//            NSLog(@"插入失败");
        }
    }
}
//阅读
- (void)insertReadingWithModel:(PKModel *)model {
    if (!model) {
//        NSLog(@"model为空");
        return;
    }
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:@"CollectList.db"]];
    }
    if ([_dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into ReadingCollectList(ReadName,Type,Content,ReadImage,WebID) values(?,?,?,?,?)"];
        BOOL insertModel = [_dataBase executeUpdate:sql,model.title,model.name,model.content,model.coverimg,model.id];
        
        if (insertModel) {
//            NSLog(@"插入成功");
        }else
        {
//            NSLog(@"插入失败");
        }
    }
}


#pragma mark ---------- 获取所有数据 ----------
//视频
- (NSMutableArray *)selegetAllVideoList {
    NSMutableArray *model = [[NSMutableArray alloc]init];
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:@"CollectList.db"]];
    }
    if ([_dataBase open]) {
        NSString *sql = @"select * from VideoCollectList";
        FMResultSet *rs = [_dataBase executeQuery:sql];
        while ([rs next]) {
            DetailModel *videoModel = [[DetailModel alloc]init];
            videoModel.title = [rs stringForColumn:@"VideoName"];
            videoModel.category = [rs stringForColumn:@"Type"];
            videoModel.duration = [rs stringForColumn:@"Duration"];
            videoModel.coverForDetail = [rs stringForColumn:@"VideoImage"];
            videoModel.rawWebUrl = [rs stringForColumn:@"WebUrl"];
            [model addObject:videoModel];
        }
    }
    return model;
}
//阅读
- (NSMutableArray *)selegetAllReadingList {
    NSMutableArray *model = [[NSMutableArray alloc]init];
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:@"CollectList.db"]];
    }
    if ([_dataBase open]) {
        NSString *sql = @"select * from ReadingCollectList";
        FMResultSet *rs = [_dataBase executeQuery:sql];
        while ([rs next]) {
            PKModel *readModel = [[PKModel alloc]init];
            readModel.title = [rs stringForColumn:@"ReadName"];
            readModel.name = [rs stringForColumn:@"Type"];
            readModel.content = [rs stringForColumn:@"Content"];
            readModel.coverimg = [rs stringForColumn:@"ReadImage"];
            readModel.id = [rs stringForColumn:@"WebID"];
            [model addObject:readModel];
        }
    }
    return model;
}


#pragma mark ---------- 删除收藏的一条数据 ----------
//视频
- (void)deleteCollectVideoModelWithTitle:(NSString *)title {
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:@"CollectList.db"]];
    }
    if ([_dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from VideoCollectList where VideoName = ?"];
        BOOL b = [_dataBase executeUpdate:sql,title];
        if (b) {
//            NSLog(@"删除成功");
        }else{
//            NSLog(@"删除失败");
        }
    }
}
//阅读
- (void)deleteCollectReadingModelWithTitle:(NSString *)title {
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self sqlitePaths:@"CollectList.db"]];
    }
    if ([_dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from ReadingCollectList where ReadName = ?"];
        BOOL b = [_dataBase executeUpdate:sql,title];
        if (b) {
//            NSLog(@"删除成功");
        }else{
//            NSLog(@"删除失败");
        }
    }
}




@end
