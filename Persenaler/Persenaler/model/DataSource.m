//
//  DataSource.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/24.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "DataSource.h"

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

-(void)loadRecord{
//    DbKeyValue *mKeyValue = [DbKeyValue new];
//    mKeyValue.key = self.jsonObjectStrKey;
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValuesFrom:0 to:100];
    if (tmpArr) {
        //[self.recordArr addObjectsFromArray:tmpArr];
        [self.recordArr removeAllObjects];
        [self.recordArr addObjectsFromArray:tmpArr];
    }
}

-(NSArray*)getRecordsFrom:(int)start to:(int)end{
    NSArray* tmpArr = [[DataBase sharedDataBase] getKeyValuesStringFrom:start to:end];
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

@end
