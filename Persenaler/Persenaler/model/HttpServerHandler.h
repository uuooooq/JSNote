//
//  HttpServerHandler.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/3/12.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GCDWebServer.h"
//#import "GCDWebServerDataResponse.h"
//#import "GCDWebServerMultiPartFormRequest.h"
//#import "GCDWebDAVServer.h"
#import <GCDWebUploader.h>
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebServerMultiPartFormRequest.h>


NS_ASSUME_NONNULL_BEGIN

@interface HttpServerHandler : NSObject<GCDWebUploaderDelegate>

@property(nonatomic,strong) GCDWebUploader * webServer; //GCDWebServer* webServer;;

-(void)startServer;

-(NSString*)getAddr;

@end

NS_ASSUME_NONNULL_END
