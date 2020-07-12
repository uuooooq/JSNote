//
//  DbKeyValue.m
//  QinlingNovel
//
//  Created by zhu dongwei on 2020/1/1.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "DbKeyValue.h"
#import "DataSource.h"

@implementation DbKeyValue

+(int)getCurrentTime{
    
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}

-(NSDictionary*)getDicProperty{
    
    if (self.property) {
        return [NSJSONSerialization JSONObjectWithData:[self.property dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    else{
        return nil;
    }
    
    
}

-(NSString*)getLatestSubRecordValue{
    if (self.property) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[self.property dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        if ([dic objectForKey:@"latestsubkey"]) {
            NSString *subKey = [dic objectForKey:@"latestsubkey"];
            DbKeyValue* keyValue = [[DataSource sharedDataSource] getKeyValue:subKey];
            if (keyValue) {
                return keyValue.value;
            }else{
                return @"";
            }
        }
        return @"";
    }
    else{
        return @"";
    }
}


@end
