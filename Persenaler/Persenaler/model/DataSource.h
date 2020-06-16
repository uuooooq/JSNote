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

NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject

+ (instancetype)sharedDataSource;

@property(nonatomic,strong) NSMutableArray * recordArr;
@property(nonatomic,strong) NSMutableArray * recordGroupArr;

-(void)addRecord:(DbKeyValue*)value;

-(void)addRecordGroup:(DbKeyValueGroup*)group;

-(NSArray*)getRecordsFrom:(int)start to:(int)end;

-(void)loadRecord;

-(NSArray*)getSearchWith:(NSString*)key;

-(NSArray*)getSearchKeyValueWith:(NSString*)key;

-(DbKeyValue*)getKeyValue:(NSString*)key;

- (NSArray *)getKeyValueGroups:(NSString*)rootID;

-(void)migrationDb;

@end

NS_ASSUME_NONNULL_END
