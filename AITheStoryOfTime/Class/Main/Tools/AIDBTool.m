//
//  XLDBModel.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-23.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "AIDBTool.h"
#import "FMDatabase.h"
#import "AIEverydayCellModel.h"
#import "AIJokeGroupModel.h"
#import "AIJokeUserModel.h"
#define DBPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"everydayCell.db"]
@interface AIDBTool ()
@property(nonatomic,strong)FMDatabase *fmdb;
@end
@implementation AIDBTool

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        //1.在沙盒路径下创建数据库
        _fmdb = [[FMDatabase alloc]initWithPath:DBPATH];
        //2这里必须打开一次
        BOOL isOpen = [_fmdb open];
        //3.判断数据库是否打开成功
        if (!isOpen) {
            AILog(@"数据库打开失败！");
        }

    }
    return self;
}

//创建数据库
+(instancetype)shareDBTool{
    static AIDBTool *model = nil;
    if (model == nil) {
        model = [[AIDBTool alloc]init];
    }
    return model;
}
-(void)createEverdayTable{
    //1.创建数据库
    BOOL isOpen = [_fmdb open];
    
    if (isOpen) {
        //3创建表格
        NSString *sql = @"create table if not exists everydayTable(ID integer primary key autoincrement,everydayImage blob,imageTime varchar(256))";
        BOOL isSuccess = [_fmdb executeUpdate:sql];
        if (isSuccess) {
            AILog(@"创建表格成功");
        }else{
            AILog(@"创建失败%@",_fmdb.lastErrorMessage);
        }
    }else{
        AILog(@"%@",_fmdb.lastErrorMessage);
    }
}
//向表格中插入数据
-(void)insertEverydayCellModel:(AIEverydayCellModel*)everydayCellModel{
    NSString *sql = @"insert into everydayTable(everydayImage,imageTime) values(?,?)";
    //将图片转换为NSData
    NSData *imageData = UIImagePNGRepresentation(everydayCellModel.everydayImage);
    BOOL isSuccess = [_fmdb executeUpdate:sql,imageData,everydayCellModel.time];
    if (isSuccess) {
        AILog(@"插入成功");
    }else{
        AILog(@"插入失败%@",_fmdb.lastErrorMessage);
    }
}
//删除
-(void)deleteEverdayCellModelWithID:(NSInteger)index{
    //1.
    NSString *sql = @"delete from everydayTable where ID = ?";
    //2.
    BOOL isSuccess = [_fmdb executeUpdate:sql,@(index)];
    //3.
    if (isSuccess) {
        AILog(@"删除成功");
    }else{
        AILog(@"%@",_fmdb.lastErrorMessage);
    }
}

//查询全部
-(NSMutableArray*)selectAllEverdayCellModel{
    NSString *sql = @"select * from everydayTable";
    NSMutableArray *arrayM = [NSMutableArray array];
    FMResultSet *reult = [_fmdb executeQuery:sql];
    while ([reult next]) {
        AIEverydayCellModel *model = [[AIEverydayCellModel alloc]init];
        NSData *imageData = [reult dataForColumn:@"everydayImage"];
        model.everydayImage = [UIImage imageWithData:imageData];
        model.time = [reult stringForColumn:@"imageTime"];
        model.cellId = @([reult intForColumn:@"ID"]);
        [arrayM insertObject:model atIndex:0];
    }
    return arrayM;
}

#pragma mark -----------------------Joke----------------
/**创建Joke表格*/
-(void)createJokeTable{
    //1.打开数据库
    BOOL isOpen = [_fmdb open];
    if (isOpen) {
        //3创建表格
        NSString *sql = @"create table if not exists jokeTable(jokeID integer primary key autoincrement,jokeIcon blob,jokeUserName varchar(256),jokeContent varchar(256),jokeBury_count varchar(256),jokeDigg_count varchar(256))";
        BOOL isSuccess = [_fmdb executeUpdate:sql];
        if (isSuccess) {
            AILog(@"创建表格成功");
        }else{
            AILog(@"创建失败%@",_fmdb.lastErrorMessage);
        }
    }else{
        AILog(@"%@",_fmdb.lastErrorMessage);
    }
}
#warning TODO-------
/**向表格中插入数据*/
-(void)insertJokeCellModel:(AIJokeGroupModel*)AIJokeGroupModel{
    
}
/**查询Joke全部数据*/
-(NSMutableArray*)selectAllJokeCellModel{
    NSString *sql = @"select * from jokeTable";
    NSMutableArray *JokeCellModels = [NSMutableArray array];
    FMResultSet *reult = [_fmdb executeQuery:sql];
    while ([reult next]) {
        AIJokeGroupModel *model = [[AIJokeGroupModel alloc]init];
        NSData *imageData = [reult dataForColumn:@"jokeIcon"];
        model.user.iconImage = [UIImage imageWithData:imageData];
        model.user.name = [reult stringForColumn:@"jokeUserName"];
        model.content = [reult stringForColumn:@"jokeContent"];
        model.bury_count = @([[reult stringForColumn:@"jokeBury_count"]integerValue]);
        model.digg_count = @([[reult stringForColumn:@"jokeDigg_count"]integerValue]);
//        model.cellId = @([reult intForColumn:@"ID"]);
        [JokeCellModels insertObject:model atIndex:0];
    }
    return JokeCellModels;
}

@end
