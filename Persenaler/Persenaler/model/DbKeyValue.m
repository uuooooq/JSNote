//
//  DbKeyValue.m
//  QinlingNovel
//
//  Created by zhu dongwei on 2020/1/1.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "DbKeyValue.h"

@implementation DbKeyValue

+(int)getCurrentTime{
    
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}


@end
