//
//  DataSource.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "DataSource.h"
#import "ZDWUtility.h"

static DataSource *_DBCtl = nil;

@implementation DataSource

+(instancetype)sharedDataSource{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataSource alloc] init];
        
        //[_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(NSMutableArray*)recordArr{
    if (!_recordArr) {
        _recordArr = [NSMutableArray new];
    }
    return _recordArr;
}
-(NSMutableArray*)recordGroupArr{
    if (!_recordGroupArr) {
        _recordGroupArr = [NSMutableArray new];
    }
    return _recordGroupArr;
}

-(void)loadRecord{
//    DbKeyValue *mKeyValue = [DbKeyValue new];
//    mKeyValue.key = self.jsonObjectStrKey;
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValuesFrom:0 to:10];
    if (tmpArr) {
        //[self.recordArr addObjectsFromArray:tmpArr];
        [self.recordArr removeAllObjects];
        [self.recordArr addObjectsFromArray:tmpArr];
    }
}

-(void)loadRecordGroup:(NSString*)rootID{
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValueGroups:rootID];
    if (tmpArr) {
        //[self.recordArr addObjectsFromArray:tmpArr];
        [self.recordGroupArr removeAllObjects];
        [self.recordGroupArr addObjectsFromArray:tmpArr];
    }
}

-(NSArray*)getRecordsFrom:(int)start to:(int)end{
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValuesStringFrom:start to:end];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
}

-(NSArray*)getRecordsObjFrom:(int)start to:(int)end{
    
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValuesFrom:start to:end];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}

-(NSArray*)getSearchWith:(NSString*)key{
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getKeyValuesWith:key];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}

-(DbKeyValue*)getKeyValue:(NSString*)key{
    
    DbKeyValue *tmpKeyValue = [[DataBase sharedDataBase] getKeyValue:key];
    if (tmpKeyValue) {
        return tmpKeyValue;
    }
    return nil;
    
}

- (NSArray *)getKeyValueGroups:(NSString*)rootID{
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getKeyValueGroups:rootID];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
}

-(NSArray*)getSubRecordsWith:(NSString*)rootKey{
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getSubRecordsWith:rootKey];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
}

-(NSArray*)getSubRecordsWith:(NSString*)rootKey from:(int)start to:(int)end{
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getSubRecordsWith:rootKey from:start to:end];//getSubRecordsWith:rootKey];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}

-(NSArray*)getNewSubRecordsWithCreateTime:(int)createTime withRootKey:(NSString*)rootKey{
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getNewSubRecordsWithCreateTime:createTime withRootKey:rootKey];//getSubRecordsWith:rootKey];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}

-(NSArray*)getNewRecordsWithCreateTime:(int)createTime{
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getNewRecordsWithCreateTime:createTime];//getSubRecordsWith:rootKey];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}

-(void)addRecord:(DbKeyValue*)value{
    [[DataBase sharedDataBase] addKeyValue:value];
    //if ([self.recordArr count] <101) {
    [self loadRecord];
    //[[DataBase sharedDataBase] addKeyValue:value];
    //}
}

-(void)addRecordGroup:(DbKeyValueGroup*)group{
    [[DataBase sharedDataBase] addkeyValueGroup:group];
}

-(void)addSubRecord:(SubRecord*)subRecord{
    [[DataBase sharedDataBase] addKeyValueSubRelation:subRecord];
}

-(NSArray*)getSearchKeyValueWith:(NSString*)key{
    NSArray *tmpArr = [[DataBase sharedDataBase] getKeyValuesObjWith:key];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
}


- (NSArray*)getSubRecordsWith:(NSString *)rootKey pageNumWith:(int)pageNum pageWith:(int)createTime{
    
    if (createTime == 0) {
        createTime = [ZDWUtility getCurrentTime];
    }
    
    NSArray *tmpArr = [[DataBase sharedDataBase] getSubRecordsWith:rootKey pageNumWith:pageNum pageWith:createTime];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}

- (NSArray *)getKeyValuesPageNumWith:(int)pageNum pageWith:(int)createTime{
    
    if (createTime == 0) {
        createTime = [ZDWUtility getCurrentTime];
    }
    
    //NSArray *tmpArr = [[DataBase sharedDataBase] getSubRecordsWith:rootKey pageNumWith:pageNum pageWith:createTime];
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValuesPageNumWith:pageNum pageWith:createTime];
    if (tmpArr) {
        return tmpArr;
    }
    return [[NSArray alloc] init];
    
}


@end
