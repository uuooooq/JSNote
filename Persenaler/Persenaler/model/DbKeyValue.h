//
//  DbKeyValue.h
//  QinlingNovel
//
//  Created by zhu dongwei on 2020/1/1.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TXT @"txt"
#define IMG @"img"
#define VIDEO @"video"
#define FILE @"file"
#define AUDIO @"audio"

typedef enum _ValueType{
    VT_ALL = 0,
    VT_TEXT,
    VT_IMG,
    VT_VIDEO,
    VT_AUDIO,
    VT_ROOT_TEXT = 10,
    VT_ROOT_IMG,
    VT_ROOT_VIDEO,
    VT_ROOT_AUDIO,
    VT_SUB_TEXT = 20,
    VT_SUB_IMG,
    VT_SUB_VIDEO,
    VT_SUB_AUDIO,
    VT_SUB_ROOT_TEXT = 30
}ValueType;

@interface DbKeyValue : NSObject

@property(nonatomic,assign) int kvid;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *value;
@property(nonatomic,assign) int createTime;
@property(nonatomic,assign) ValueType type;

+(int)getCurrentTime;

@end

NS_ASSUME_NONNULL_END
