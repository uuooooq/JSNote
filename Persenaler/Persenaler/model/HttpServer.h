//
//  HttpServer.h
//  Persenaler
//
//  Created by zhudongwei on 2020/8/19.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GCDWebUploader.h>
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebServerMultiPartFormRequest.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpServer : NSObject<GCDWebUploaderDelegate>

@property(nonatomic,strong) GCDWebUploader * webServer;

-(void)startServer;

-(NSString*)getAddr;


@end

NS_ASSUME_NONNULL_END
