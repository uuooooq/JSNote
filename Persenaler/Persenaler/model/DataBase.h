//
//  DataBase.h
//  QinlingNovel
//
//  Created by zhu dongwei on 2019/12/29.
//  Copyright © 2019 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbKeyValue.h"
#import "DbKeyValueGroup.h"
#import "SubRecord.h"
#import <FMDB.h>
#import "ZDWUtility.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataBase : NSObject

+ (instancetype)sharedDataBase;
@property(nonnull,strong)FMDatabase  *db;

#pragma mark - DbKeyValue
/**
 *  添加 DbKeyValue
 *
 */
- (void)addKeyValue:(DbKeyValue *)keyValue;
/**
 *  删除 DbKeyValue
 *
 */
- (void)deleteKeyValue:(DbKeyValue *)keyValue;
/**
 *  更新 DbKeyValue
 *
 */
- (void)updateKeyValue:(DbKeyValue *)keyValue;

- (DbKeyValue *)getKeyValue:(NSString*)key;

- (NSArray *)getKeyValuesFrom:(int)start to:(int)end;

- (NSArray *)getKeyValuesStringFrom:(int)start to:(int)end;

-(NSArray*)getKeyValuesWith:(NSString*)key;

-(NSArray*)getKeyValuesObjWith:(NSString*)key;

//- (DbKeyValueGroup *)getRootKeyValue:(NSString*)subID;

//- (NSArray *)getKeyValueGroups:(NSString*)rootID;

//-(void)addkeyValueGroup:(DbKeyValueGroup*)kvGroup;

- (NSArray*)getKeyValueGroups:(NSString *)rootKey;
- (NSArray*)getKeyValueGroups:(NSString *)rootKey withSubKey:(NSString*)subKey;

-(void)addKeyValueSubRelation:(SubRecord*)subRecord;

-(void)updateKeyValueSubRelation:(SubRecord*)subRecord;

- (NSArray*)getSubRecordsWith:(NSString *)rootKey;

- (NSArray*)getSubRecordsWith:(NSString *)rootKey from:(int)start to:(int)end;

-(NSArray*)getNewSubRecordsWithCreateTime:(int)createTime withRootKey:(NSString*)rootKey;
-(NSArray*)getNewRecordsWithCreateTime:(int)createTime;

- (NSArray*)getSubRecordsWith:(NSString *)rootKey pageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray *)getKeyValuesPageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray *)getKeyValuesFolderPageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray*)getSubRecordsFolderWith:(NSString *)rootKey pageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray*)getSubRecordWithSubKey:(NSString*)subKey;

- (void)deleteSubRecord:(SubRecord *)subRecord;

// migration kvTb kvGroupTb

-(void)migrationDb;
@end

NS_ASSUME_NONNULL_END
