//
//  DataSource.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbKeyValue.h"
#import "DataBase.h"
#import "SubRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject

+ (instancetype)sharedDataSource;

@property(nonatomic,strong) NSMutableArray * recordArr;
@property(nonatomic,strong) NSMutableArray * recordGroupArr;

-(void)addRecord:(DbKeyValue*)value;

//-(void)addRecordGroup:(DbKeyValueGroup*)group;

-(NSArray*)getRecordsFrom:(int)start to:(int)end;
-(NSArray*)getRecordsObjFrom:(int)start to:(int)end;

-(void)loadRecord;

-(NSArray*)getSearchWith:(NSString*)key;

-(NSArray*)getSearchKeyValueWith:(NSString*)key;

-(DbKeyValue*)getKeyValue:(NSString*)key;

- (NSArray *)getKeyValueGroups:(NSString*)rootID;

-(void)updateKeyValueSubRelation:(SubRecord*)subRecord;

-(void)addSubRecord:(SubRecord*)subRecord;

-(void)migrationDb;

-(NSArray*)getSubRecordsWith:(NSString*)rootKey;
-(NSArray*)getSubRecordsWith:(NSString*)rootKey from:(int)start to:(int)end;

-(NSArray*)getNewSubRecordsWithCreateTime:(int)createTime withRootKey:(NSString*)rootKey;
-(NSArray*)getNewRecordsWithCreateTime:(int)createTime;

- (NSArray*)getSubRecordsWith:(NSString *)rootKey pageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray *)getKeyValuesPageNumWith:(int)pageNum pageWith:(int)createTime;

-(void)updateKeyValue:(DbKeyValue*)keyValue;

- (void)deleteKeyValue:(DbKeyValue *)keyValue;

- (NSArray *)getKeyValuesFolderPageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray*)getSubRecordsFolderWith:(NSString *)rootKey pageNumWith:(int)pageNum pageWith:(int)createTime;

- (NSArray*)getKeyValueGroups:(NSString *)rootKey withSubKey:(NSString*)subKey;

- (NSArray*)getSubRecordWithSubKey:(NSString*)subKey;

- (void)deleteSubRecord:(SubRecord *)subRecord;

-(void)updateSubRecord:(SubRecord*)subRecord;

@end

NS_ASSUME_NONNULL_END
