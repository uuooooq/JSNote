//
//  DataBase.m
//  QinlingNovel
//
//  Created by zhu dongwei on 2019/12/29.
//  Copyright © 2019 zhu dongwei. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>
#import "ZDWUtility.h"



#define INSERT_RECORD_STR(tbname) [NSString stringWithFormat:@"INSERT INTO %@(key,value,type,createTime) values(?, ?, ?, ?)",tbname]



static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    NSString* recordTBName;
    NSString* subRecordTBName;
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
    if (![self isTableOK:@"kvGroupTb"]) {
        NSLog(@"---------- start create kvGroupTb");
        NSString *keyValueTbSql = @"CREATE TABLE 'kvGroupTb' ('gid' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'rootID' INTEGER,'rootValue' TEXT,'rootType' INTEGER,'subID' INTEGER,'subValue' TEXT,'subType' INTEGER,'type' INTEGER,'createTime' INTEGER,'extCategory' TEXT)";
        [_db executeUpdate:keyValueTbSql];
    }
    
    // 升级到 recordTBz003
    if (![self isTableOK:@"recordTbz003"]) {
        
        
        NSLog(@"---------- start create recordTbz003");
        NSString *keyValueTbSql = @"CREATE TABLE 'recordTbz003' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'key' VARCHAR(1024),'value' TEXT,'type' INTEGER,'createTime' INTEGER)";
        [_db executeUpdate:keyValueTbSql];
        
        NSLog(@"---------- start create subRecordTbz003");
        NSString *subKeyValueTbSql = @"CREATE TABLE 'subRecordTbz003' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'rootKey' VARCHAR(1024),'subKey' VARCHAR(1024))";
        [_db executeUpdate:subKeyValueTbSql];
        
           recordTBName = @"kvTb";
           subRecordTBName = @"kvGroupTb";
        
           NSLog(@"start .... ");
           NSLog(@"========== kvTb migration start ");
           [self migrationKvtb];
           
           NSLog(@"========== kvTb migration start ");
           [self migrationKvgrouptb];
           
           NSLog(@"========== migration done ");
        
        recordTBName = @"recordTbz003";
        subRecordTBName = @"subRecordTbz003";
    }
    else{
        recordTBName = @"recordTbz003";
        subRecordTBName = @"subRecordTbz003";
    }
    
    
    // update database to V6
    
    if (![self isTableOK:@"recordTbz006"]) {
        
        [_db beginTransaction];
        BOOL isRollBack = NO;
        @try {

            NSLog(@"---------- start create recordTbz006");
            NSString *keyValueTbSql = @"CREATE TABLE 'recordTbz006' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'key' VARCHAR(1024),'value' TEXT,'type' INTEGER,'createTime' INTEGER)";
            [_db executeUpdate:keyValueTbSql];
            
            NSLog(@"---------- start create subRecordTbz006");
            NSString *subKeyValueTbSql = @"CREATE TABLE 'subRecordTbz006' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'rootKey' VARCHAR(1024),'subKey' VARCHAR(1024),'createTime' INTEGER)";
            [_db executeUpdate:subKeyValueTbSql];


        } @catch (NSException *exception) {
            isRollBack = YES;
            [_db rollback];
        } @finally {
            if (!isRollBack) {
                [_db commit];
            }
        }
        
        if (!isRollBack) {
            
            recordTBName = @"recordTbz003";
            subRecordTBName = @"subRecordTbz003";
            NSLog(@"start .... ");
            
            NSLog(@"========== recordTbz005 migration start ");
            [self migrationRecordTbV6];
            
            NSLog(@"========== subRecordTbz005 migration start ");
            [self migrationSubrecordTbV6];
            
            
            recordTBName = @"recordTbz006";
            subRecordTBName = @"subRecordTbz006";
        }
    


    }
    else{
        recordTBName = @"recordTbz006";
        subRecordTBName = @"subRecordTbz006";
    }
    
    // update database to V7
     
     if (![self isTableOK:@"recordTbz007"]) {
         
         [_db beginTransaction];
         BOOL isRollBack = NO;
         @try {

             NSLog(@"---------- start create recordTbz007");
             NSString *keyValueTbSql = @"CREATE TABLE 'recordTbz007' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'key' VARCHAR(1024),'value' TEXT,'type' INTEGER,'createTime' INTEGER)";
             [_db executeUpdate:keyValueTbSql];
             
             NSLog(@"---------- start create subRecordTbz007");
             NSString *subKeyValueTbSql = @"CREATE TABLE 'subRecordTbz007' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'rootKey' VARCHAR(1024),'subKey' VARCHAR(1024),'createTime' INTEGER)";
             [_db executeUpdate:subKeyValueTbSql];


         } @catch (NSException *exception) {
             isRollBack = YES;
             [_db rollback];
         } @finally {
             if (!isRollBack) {
                 [_db commit];
             }
         }
         
         if (!isRollBack) {
             
             recordTBName = @"recordTbz006";
             subRecordTBName = @"subRecordTbz006";
             NSLog(@"start .... ");
             
             NSLog(@"========== subRecordTbz005 migration start ");
             [self migrationSubrecordTbV7];
             
             NSLog(@"========== recordTbz005 migration start ");
             [self migrationRecordTbV7];
             
             
             recordTBName = @"recordTbz007";
             subRecordTBName = @"subRecordTbz007";
         }
     


     }
     else{
         recordTBName = @"recordTbz007";
         subRecordTBName = @"subRecordTbz007";
     }


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
    
    [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(key,value,type,createTime) values(?, ?, ?, ?)",recordTBName],keyValue.key,keyValue.value,@(keyValue.type),@(keyValue.createTime)];

    [_db close];
    
}

-(void)updateKeyValue:(DbKeyValue*)keyValue{
    
    [_db open];
    
    [_db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET type = ?  WHERE id = ? ",recordTBName],@(keyValue.type),@(keyValue.kvid)];
    
    [_db close];
    
}

-(void)addkeyValueGroup:(DbKeyValueGroup*)kvGroup{

    [_db open];
    [_db executeUpdate:@"INSERT INTO kvGroupTb(rootID,rootValue,rootType,subID,subValue,subType,type,createTime,extCategory) values(?, ?,?, ?, ?,?, ?,?, ?)",@(kvGroup.rootID),kvGroup.rootValue,@(kvGroup.rootType),@(kvGroup.subID),kvGroup.subValue,@(kvGroup.subType),@(kvGroup.type),@(kvGroup.createTime),kvGroup.extCategory];
    [_db close];
}

-(void)addKeyValueSubRelation:(SubRecord*)subRecord{
    
    [_db open];
    [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(rootKey,subKey,createTime) values(?, ?,?)",subRecordTBName],subRecord.rootKey,subRecord.subKey,@(subRecord.createTime)];
    [_db close];
    
}

- (DbKeyValueGroup *)getRootKeyValue:(NSString*)subID{
    [_db open];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvGroupTb where subID = ?",subID];
    DbKeyValueGroup *keyValueGroup = [[DbKeyValueGroup alloc] init];
    while ([res next]) {
        
        keyValueGroup.gID = [res intForColumn:@"gid"];
        keyValueGroup.rootID = [res intForColumn:@"rootID"];
        keyValueGroup.rootValue = [res stringForColumn:@"rootValue"];
        keyValueGroup.rootType = [res intForColumn:@"rootType"];
        keyValueGroup.subID = [res intForColumn:@"subID"];
        keyValueGroup.subValue = [res stringForColumn:@"subValue"];
        keyValueGroup.subType = [res intForColumn:@"subType"];
        keyValueGroup.type = [res intForColumn:@"type"];
        keyValueGroup.createTime = [res intForColumn:@"createTime"];
        keyValueGroup.extCategory = [res stringForColumn:@"extCategory"];
    }
    
    [_db close];
    
    if (keyValueGroup.gID) {
        return keyValueGroup;
    }
    else{
        return nil;
    }
}

//- (NSArray *)getKeyValueGroups:(NSString*)rootID{
//    
//    [_db open];
//    NSMutableArray *arr = [NSMutableArray new];
//    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvGroupTb where rootID = ?",rootID];
//    
//    while ([res next]) {
//        DbKeyValueGroup *keyValueGroup = [[DbKeyValueGroup alloc] init];
//        keyValueGroup.gID = [res intForColumn:@"gid"];
//        keyValueGroup.rootID = [res intForColumn:@"rootID"];
//        keyValueGroup.rootValue = [res stringForColumn:@"rootValue"];
//        keyValueGroup.rootType = [res intForColumn:@"rootType"];
//        keyValueGroup.subID = [res intForColumn:@"subID"];
//        keyValueGroup.subValue = [res stringForColumn:@"subValue"];
//        keyValueGroup.subType = [res intForColumn:@"subType"];
//        keyValueGroup.type = [res intForColumn:@"type"];
//        keyValueGroup.createTime = [res intForColumn:@"createTime"];
//        keyValueGroup.extCategory = [res stringForColumn:@"extCategory"];
//        [arr addObject:keyValueGroup];
//    }
//    
//    [_db close];
//    
//    if ([arr count]>0) {
//        return arr;
//    }
//    else{
//        return nil;
//    }
//}

- (NSArray*)getKeyValueGroups:(NSString *)rootKey{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where rootKey = ?",subRecordTBName] ,rootKey];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        subRecord.createTime = [res intForColumn:@"createTime"];
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.subKey];//[DbKeyValue new];
        
        if (keyValue) {
            [arr addObject:keyValue];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
    
}

- (NSArray*)getSubRecordsWith:(NSString *)rootKey{
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where rootKey = ?",subRecordTBName] ,rootKey];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        subRecord.createTime = [res intForColumn:@"createTime"];
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.subKey];//[DbKeyValue new];
        
        if (keyValue) {
            [arr addObject:keyValue];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
}

- (NSArray*)getSubRecordsWith:(NSString *)rootKey from:(int)start to:(int)end{
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where rootKey = ? ORDER BY createTime desc LIMIT ?,?",subRecordTBName] ,rootKey,@(start),@(end)];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        subRecord.createTime = [res intForColumn:@"createTime"];
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.subKey];//[DbKeyValue new];
        
        if (keyValue) {
            [arr addObject:keyValue];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
}

- (NSArray*)getSubRecordsWith:(NSString *)rootKey pageNumWith:(int)pageNum pageWith:(int)createTime{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where rootKey = ? AND createTime < ? ORDER BY createTime desc LIMIT 0,?",subRecordTBName] ,rootKey,@(createTime),@(pageNum)];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        subRecord.createTime = [res intForColumn:@"createTime"];
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.subKey];//[DbKeyValue new];
        
        if (keyValue) {
            [arr addObject:keyValue];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
    
    
    
    return nil;
}


- (void)deleteKeyValue:(DbKeyValue *)keyValue{
    
//    [_db open];
//
//    [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE key = ?",recordTBName],keyValue.key];
//
//    [_db close];
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE key = ?",recordTBName],keyValue.key];
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE rootKey = ?",subRecordTBName],keyValue.key];
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE subKey = ?",subRecordTBName],keyValue.key];
        
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}


- (DbKeyValue *)getKeyValue:(NSString*)key{
    
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where key = ?",recordTBName],key];
    DbKeyValue *keyValue = [[DbKeyValue alloc] init];
    while ([res next]) {
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.type = [res intForColumn:@"type"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
    }
    
    //[_db close];
    
    if (keyValue.key) {
        return keyValue;
    }
    else{
        return nil;
    }
}

- (DbKeyValue *)getKeyValueBy:(int)id{
    
    [_db open];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where id = ?",recordTBName],@(id)];
    DbKeyValue *keyValue = [[DbKeyValue alloc] init];
    while ([res next]) {
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.type = [res intForColumn:@"type"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
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
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE type < 12 ORDER BY createTime desc LIMIT ?,?",recordTBName],@(start),@(end)];
    
    while ([res next]) {
        DbKeyValue *keyValue = [[DbKeyValue alloc] init];
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
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
//pageNumWith:(int)pageNum pageWith:(int)createTime
- (NSArray *)getKeyValuesPageNumWith:(int)pageNum pageWith:(int)createTime{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where createTime < ? AND type < 12 ORDER BY createTime desc LIMIT 0,?",recordTBName],@(createTime),@(pageNum)];
    
    while ([res next]) {
        DbKeyValue *keyValue = [[DbKeyValue alloc] init];
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
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
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY createTime desc LIMIT ?,?",recordTBName],@(start),@(end)];
    
    while ([res next]) {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
        
        [tmpDict setObject:[res stringForColumn:@"id"] forKey:@"id"];
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
    
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE value like '%%%@%%'",recordTBName,key];

    FMResultSet *res = [_db executeQuery:selectSQL];
    
    while ([res next]) {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
        //keyValue.key = [res stringForColumn:@"key"];
        [tmpDict setObject:[res stringForColumn:@"id"] forKey:@"id"];
        [tmpDict setObject:[res stringForColumn:@"key"] forKey:@"key"];
        //keyValue.value = [res stringForColumn:@"value"];
        [tmpDict setObject:[res stringForColumn:@"value"] forKey:@"value"];
        //keyValue.createTime = [res intForColumn:@"createTime"];
        [tmpDict setObject:[res stringForColumn:@"createTime"] forKey:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
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

-(NSArray*)getKeyValuesObjWith:(NSString*)key{
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE value like '%%%@%%'",recordTBName,key];

    FMResultSet *res = [_db executeQuery:selectSQL];
    
    while ([res next]) {
        DbKeyValue *keyValue = [[DbKeyValue alloc] init];
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
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

-(NSArray*)getNewSubRecordsWithCreateTime:(int)createTime withRootKey:(NSString*)rootKey{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where rootKey = ? AND createTime > ?",subRecordTBName] ,rootKey,@(createTime)];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        subRecord.createTime = [res intForColumn:@"createTime"];
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.subKey];//[DbKeyValue new];
        
        if (keyValue) {
            [arr addObject:keyValue];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        return arr;
    }
    else{
        return nil;
    }
    
}

-(NSArray*)getNewRecordsWithCreateTime:(int)createTime{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where createTime > ? AND type < 12 ORDER BY createTime desc ",recordTBName],@(createTime)];
    
    while ([res next]) {
        DbKeyValue *keyValue = [[DbKeyValue alloc] init];
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        //keyValue.extCategory = [res stringForColumn:@"extCategory"];
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

#pragma mark migration

-(void)migrationDb{
    
    recordTBName = @"kvTb";
    subRecordTBName = @"kvGroupTb";
 
    NSLog(@"start .... ");
    NSLog(@"========== kvTb migration start ");
    [self migrationKvtb];
    
    NSLog(@"========== kvTb migration start ");
    [self migrationKvgrouptb];
    
    NSLog(@"========== migration done ");

}


-(void)migrationKvtb{
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvTb ORDER BY id desc"];
    
    while ([res next]) {
        DbKeyValue *keyValue = [[DbKeyValue alloc] init];
        keyValue.kvid = [res intForColumn:@"id"];
        keyValue.key = [res stringForColumn:@"key"];
        keyValue.value = [res stringForColumn:@"value"];
        keyValue.createTime = [res intForColumn:@"createTime"];
        keyValue.type = [res intForColumn:@"type"];
        [arr addObject:keyValue];
    }
    
    [_db close];
    
    if ([arr count]>0) {
        //return;
        [self insertRecordTbUseTransaction:arr];
    }
    else{
        return;
    }
}

-(void)insertRecordTbUseTransaction:(NSArray<DbKeyValue*>*)keyvalues{
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (DbKeyValue *keyValue in keyvalues) {
            BOOL isSuccess = [_db executeUpdate:@"INSERT INTO recordTbz003(key,value,type,createTime) values(?, ?, ?, ?)",keyValue.key,keyValue.value,@(keyValue.type),@(keyValue.createTime)];
            NSLog(@"%@",isSuccess ? @"插入 keyvalue 成功" : @"插入keyvalue失败");
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}

-(void)migrationKvgrouptb{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM kvGroupTb"];
    
    while ([res next]) {
        DbKeyValueGroup *keyValueGroup = [[DbKeyValueGroup alloc] init];
        keyValueGroup.gID = [res intForColumn:@"gid"];
        keyValueGroup.rootID = [res intForColumn:@"rootID"];
        keyValueGroup.rootValue = [res stringForColumn:@"rootValue"];
        keyValueGroup.rootType = [res intForColumn:@"rootType"];
        keyValueGroup.subID = [res intForColumn:@"subID"];
        keyValueGroup.subValue = [res stringForColumn:@"subValue"];
        keyValueGroup.subType = [res intForColumn:@"subType"];
        keyValueGroup.type = [res intForColumn:@"type"];
        keyValueGroup.createTime = [res intForColumn:@"createTime"];
        keyValueGroup.extCategory = [res stringForColumn:@"extCategory"];
        [arr addObject:keyValueGroup];
    }
    
    [_db close];
    
    if ([arr count]>0) {
        //return arr;
        NSArray * subRecords = [self getKey:arr];
        if (subRecords) {
            [self insertSubRecordsTransaction:subRecords];
        }
    }
    else{
        //return nil;
    }
    
}

-(NSArray*)getKey:(NSArray<DbKeyValueGroup*>*)groups{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (DbKeyValueGroup *group in groups) {
        
        DbKeyValue * rootKeyValue = [self getKeyValueBy:group.rootID];
        
        rootKeyValue.type = rootKeyValue.type + 9;
        [self updateKeyValue:rootKeyValue];
        
        DbKeyValue * subKeyValue = [self getKeyValueBy:group.subID];
        
        rootKeyValue.type = rootKeyValue.type + 19;
        [self updateKeyValue:rootKeyValue];
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.rootKey = rootKeyValue.key;
        subRecord.subKey = subKeyValue.key;
        
        [arr addObject:subRecord];
    }
    
    if ([arr count] > 0) {
        return  [NSArray arrayWithArray:arr];
    }else{
        return nil;
    }
    
    
}

-(void)insertSubRecordsTransaction:(NSArray<SubRecord*>*)subrecords{
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (SubRecord *subRecord in subrecords) {
            BOOL isSuccess = [_db executeUpdate:@"INSERT INTO subRecordTbz003(rootKey,subKey) values(?, ?)",subRecord.rootKey,subRecord.subKey];
            NSLog(@"%@",isSuccess ? @"插入 SubRecord 成功" : @"插入SubRecord失败");
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}

#pragma mark migration v = 6

-(void)migrationRecordTbV6{
    
    [_db open];
     NSMutableArray *arr = [NSMutableArray new];
     FMResultSet *res = [_db executeQuery:@"SELECT * FROM recordTbz003 ORDER BY id desc"];
     
     while ([res next]) {
         DbKeyValue *keyValue = [[DbKeyValue alloc] init];
         keyValue.kvid = [res intForColumn:@"id"];
         keyValue.key = [res stringForColumn:@"key"];
         keyValue.value = [res stringForColumn:@"value"];
         keyValue.createTime = [res intForColumn:@"createTime"];
         keyValue.type = [res intForColumn:@"type"];
         [arr addObject:keyValue];
     }
     
     [_db close];
     
     if ([arr count]>0) {
         //return;
         NSArray* tmpArr = [self filerInvalidItem:arr];
         [self insertRecordTbV6UseTransaction:tmpArr];
     }
     else{
         return;
     }
    
}

-(NSArray*)filerInvalidItem:(NSArray*)items{
    
    int currentTime = [ZDWUtility getCurrentTime];
    NSMutableArray *tmpArr = [NSMutableArray new];
    for (DbKeyValue *item in items) {
        if (item.createTime < currentTime) {
            [tmpArr addObject:item];
        }
    }
    
    return [NSArray arrayWithArray:tmpArr];
    
}

-(void)insertRecordTbV6UseTransaction:(NSArray<DbKeyValue*>*)keyvalues{
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (DbKeyValue *keyValue in keyvalues) {
            BOOL isSuccess = [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(key,value,type,createTime) values(?, ?, ?, ?)",@"recordTbz006"],keyValue.key,keyValue.value,@(keyValue.type),@(keyValue.createTime)];
            NSLog(@"%@",isSuccess ? @"插入 keyvalue 成功" : @"插入keyvalue失败");
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}

-(void)migrationSubrecordTbV6{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",@"subRecordTbz003"]];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.subKey];//[DbKeyValue new];
        
        
        if (keyValue) {
            subRecord.createTime = keyValue.createTime;
            [arr addObject:subRecord];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        //return arr;
        [self insertSubRecordsV6Transaction:arr];
    }
    else{
        //return nil;
    }
    
}

-(void)insertSubRecordsV6Transaction:(NSArray<SubRecord*>*)subrecords{
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (SubRecord *subRecord in subrecords) {
            BOOL isSuccess = [_db executeUpdate:@"INSERT INTO subRecordTbz006(rootKey,subKey,createTime) values(?, ?, ?)",subRecord.rootKey,subRecord.subKey,@(subRecord.createTime)];
            NSLog(@"%@",isSuccess ? @"插入 SubRecord 成功" : @"插入SubRecord失败");
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}

#pragma mark migration v = 7

-(void)migrationRecordTbV7{
    
    [_db open];
     NSMutableArray *arr = [NSMutableArray new];
     FMResultSet *res = [_db executeQuery:@"SELECT * FROM recordTbz006 ORDER BY id desc"];
     
     while ([res next]) {
         DbKeyValue *keyValue = [[DbKeyValue alloc] init];
         keyValue.kvid = [res intForColumn:@"id"];
         keyValue.key = [res stringForColumn:@"key"];
         keyValue.value = [res stringForColumn:@"value"];
         keyValue.createTime = [res intForColumn:@"createTime"];
         keyValue.type = [res intForColumn:@"type"];
         
         if (keyValue.type >2 && keyValue.type < 10) {
            
         }
         else{
             if (keyValue.type == 10) {
                 keyValue.type = VT_ROOT;
             }
             if (keyValue.type == 11) {
                 keyValue.type = VT_IMG;
             }
             [arr addObject:keyValue];
         }
         
         
     }
     
     [_db close];
     
     if ([arr count]>0) {
         //return;
         //NSArray* tmpArr = [self filerInvalidItem:arr];
         [self insertRecordTbV7UseTransaction:arr];
     }
     else{
         return;
     }
    
}

-(void)insertRecordTbV7UseTransaction:(NSArray<DbKeyValue*>*)keyvalues{
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (DbKeyValue *keyValue in keyvalues) {
            BOOL isSuccess = [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(key,value,type,createTime) values(?, ?, ?, ?)",@"recordTbz007"],keyValue.key,keyValue.value,@(keyValue.type),@(keyValue.createTime)];
            NSLog(@"%@",isSuccess ? @"插入 keyvalue 成功" : @"插入keyvalue失败");
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}

-(void)migrationSubrecordTbV7{
    
    [_db open];
    NSMutableArray *arr = [NSMutableArray new];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",@"subRecordTbz006"]];
    
    while ([res next]) {
        
        SubRecord * subRecord = [SubRecord new];
        subRecord.gID = [res intForColumn:@"id"];
        subRecord.rootKey = [res stringForColumn:@"rootKey"];
        subRecord.subKey = [res stringForColumn:@"subKey"];
        subRecord.createTime = [res intForColumn:@"createTime"];
        
        
        DbKeyValue * keyValue = [self getKeyValue:subRecord.rootKey];//[DbKeyValue new];
        
        
        if (keyValue.type == 11) {
            
             DbKeyValue * tmpKeyValue = [self getKeyValue:subRecord.subKey];
            if (tmpKeyValue.type == VT_SUB_IMG) {
                tmpKeyValue.type = VT_IMG;
            }
            if (tmpKeyValue.type == VT_SUB_TEXT) {
                tmpKeyValue.type = VT_TEXT;
            }
            
            [self updateKeyValue:tmpKeyValue];
        }
        else{
            subRecord.createTime = keyValue.createTime;
            [arr addObject:subRecord];
        }
        
    }
    
    [_db close];
    
    if ([arr count]>0) {
        //return arr;
        [self insertSubRecordsV7Transaction:arr];
    }
    else{
        //return nil;
    }
    
}

-(void)insertSubRecordsV7Transaction:(NSArray<SubRecord*>*)subrecords{
    
    [_db open];
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (SubRecord *subRecord in subrecords) {
            BOOL isSuccess = [_db executeUpdate:@"INSERT INTO subRecordTbz007(rootKey,subKey,createTime) values(?, ?, ?)",subRecord.rootKey,subRecord.subKey,@(subRecord.createTime)];
            NSLog(@"%@",isSuccess ? @"插入 SubRecord 成功" : @"插入SubRecord失败");
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    } @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
    NSLog(@"migration kvtb to recordTb done!");
    [_db class];
    
}


@end
