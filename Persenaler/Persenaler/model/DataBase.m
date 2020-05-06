//
//  DataBase.m
//  QinlingNovel
//
//  Created by zhu dongwei on 2019/12/29.
//  Copyright © 2019 zhu dongwei. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>

static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}

@end

@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    if (![self isTableOK:@"kvTb"]) {
        NSLog(@"---------- start create kvTb");
        NSString *keyValueTbSql = @"CREATE TABLE 'kvTb' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'key' VARCHAR(1024),'value' TEXT,'type' INTEGER,'createTime' INTEGER,'extCategory' TEXT)";
        [_db executeUpdate:keyValueTbSql];
    }
    //[_db close];

}

- (BOOL)isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", (long)count);

        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }

    return NO;
}

#pragma mark - 接口
- (void)addKeyValue:(DbKeyValue *)keyValue{
    [_db open];
    
  //  FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvTb where key = ?",keyValue.key];
 //   DbKeyValue *tmpKeyValue = [[DbKeyValue alloc] init];
//    while ([res next]) {
//
//        tmpKeyValue.key = [res stringForColumn:@"key"];
//        tmpKeyValue.value = [res stringForColumn:@"value"];
//        //[self deleteKeyValue:tmpKeyValue];
//        [_db executeUpdate:@"DELETE FROM kvTb WHERE key = ?",tmpKeyValue.key];
//    }
//
//    if (tmpKeyValue.key) {
//        [_db executeUpdate:@"UPDATE 'kvTb' SET value = ?  WHERE key = ? ",keyValue.value,keyValue.key];
//    }
//    else{
        [_db executeUpdate:@"INSERT INTO kvTb(key,value,type,createTime,extCategory) values(?, ?, ?,?, ?)",keyValue.key,keyValue.value,@(keyValue.type),@(keyValue.createTime),keyValue.extCategory];
//    }
    
    

    //[_db close];
    
}

//- (void)addPerson:(Person *)person{
//    [_db open];
//
//    NSNumber *maxID = @(0);
//
//    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person "];
//    //获取数据库中最大的ID
//    while ([res next]) {
//        if ([maxID integerValue] < [[res stringForColumn:@"person_id"] integerValue]) {
//            maxID = @([[res stringForColumn:@"person_id"] integerValue] ) ;
//        }
//
//    }
//    maxID = @([maxID integerValue] + 1);
//
//    [_db executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)VALUES(?,?,?,?)",maxID,person.name,@(person.age),@(person.number)];
//
//
//
//    [_db close];
//
//}
- (void)deleteKeyValue:(DbKeyValue *)keyValue{
    
    [_db open];

    [_db executeUpdate:@"DELETE FROM kvTb WHERE key = ?",keyValue.key];

    //[_db close];
    
}

//
//- (void)deletePerson:(Person *)person{
//    [_db open];
//
//    [_db executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];
//
//    [_db close];
//}
//
//- (void)updatePerson:(Person *)person{
//    [_db open];
//
//    [_db executeUpdate:@"UPDATE 'person' SET person_name = ?  WHERE person_id = ? ",person.name,person.ID];
//    [_db executeUpdate:@"UPDATE 'person' SET person_age = ?  WHERE person_id = ? ",@(person.age),person.ID];
//    [_db executeUpdate:@"UPDATE 'person' SET person_number = ?  WHERE person_id = ? ",@(person.number + 1),person.ID];
//
//
//
//    [_db close];
//}

- (DbKeyValue *)getKeyValue:(NSString*)key{
    
    [_db open];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvTb where key = ?",key];
    DbKeyValue *keyValue = [[DbKeyValue alloc] init];
    while ([res next]) {
        
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.type = [res intForColumn:@"type"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        keyValue.extCategory = [res stringForColumn:@"extCategory"];
    }
    
    //[_db close];
    
    if (keyValue.key) {
        return keyValue;
    }
    else{
        return nil;
    }
}

- (NSArray *)getKeyValuesFrom:(int)start to:(int)end{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvTb ORDER BY id desc LIMIT ?,?",@(start),@(end)];
    
    while ([res next]) {
        DbKeyValue *keyValue = [[DbKeyValue alloc] init];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        keyValue.extCategory = [res stringForColumn:@"extCategory"];
        keyValue.type = [res intForColumn:@"type"];
        [arr addObject:keyValue];
    }
    
    //[_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
}

- (NSArray *)getKeyValuesStringFrom:(int)start to:(int)end{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvTb ORDER BY id desc LIMIT ?,?",@(start),@(end)];
    
    while ([res next]) {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
        [tmpDict setObject:[res stringForColumn:@"key"] forKey:@"key"];
        [tmpDict setObject:[res stringForColumn:@"value"] forKey:@"value"];
        [tmpDict setObject:[res stringForColumn:@"createTime"] forKey:@"createTime"];
        [tmpDict setObject:[res stringForColumn:@"extCategory"] forKey:@"extCategory"];
        [tmpDict setObject:[res stringForColumn:@"type"] forKey:@"type"];
        [arr addObject:tmpDict];
    }
    
    //[_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
}

-(NSArray*)getKeyValuesWith:(NSString*)key{
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM kvTb WHERE value like '%%%@%%'",key];

    FMResultSet *res = [_db executeQuery:selectSQL];
    
    while ([res next]) {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
        //keyValue.key = [res stringForColumn:@"key"];
        [tmpDict setObject:[res stringForColumn:@"key"] forKey:@"key"];
        //keyValue.value = [res stringForColumn:@"value"];
        [tmpDict setObject:[res stringForColumn:@"value"] forKey:@"value"];
        //keyValue.createTime = [res intForColumn:@"createTime"];
        [tmpDict setObject:[res stringForColumn:@"createTime"] forKey:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
        [tmpDict setObject:[res stringForColumn:@"extCategory"] forKey:@"extCategory"];
        [arr addObject:tmpDict];
    }
    
    //[_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
}


@end
