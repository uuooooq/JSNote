//
//  DbKeyValueGroup.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/18.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "DbKeyValueGroup.h"

@implementation DbKeyValueGroup

+(int)getCurrentTime{
    
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}

@end
