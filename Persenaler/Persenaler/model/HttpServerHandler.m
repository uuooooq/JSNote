//
//  HttpServerHandler.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/3/12.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "HttpServerHandler.h"
#import "DataSource.h"

@interface HttpServerHandler (){
    GCDWebServer* _webServer;
}

@property(nonatomic,strong) DataSource *dataSource;

@end

@implementation HttpServerHandler

-(void)startServer{
    self.dataSource = [DataSource new];
    [self.dataSource loadRecord];
    
    NSString *rootDir = [[NSBundle mainBundle] pathForResource:@"website" ofType:nil];
    
    //创建http服务器
    _webServer = [[GCDWebServer alloc] init];
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:rootDir indexFilename:@"index.html" cacheAge:3600 allowRangeRequests:YES];
    
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"GET" path:@"/hello" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        NSLog(@"%@ %@",[request.query objectForKey:@"start"],[request.query objectForKey:@"end"]);
        int start = [[request.query objectForKey:@"start"] intValue];
        int end = [[request.query objectForKey:@"end"] intValue];
        
        NSArray * obj = [weakSelf.dataSource getRecordsFrom:start to:end];
        GCDWebServerDataResponse* response = [GCDWebServerDataResponse responseWithJSONObject:obj];
        //response = [GCDWebServerDataResponse responseWithStatusCode:200];
        //响应头设置，跨域请求需要设置，只允许设置的域名或者ip才能跨域访问本接口）
        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        [response setValue:@"Content-Type" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        //设置options的实效性（我设置了12个小时=43200秒）
        [response setValue:@"43200" forAdditionalHeader:@"Access-Control-max-age"];
        [response setStatusCode:200];
        
        return response;
    }];
    
    
    [_webServer addHandlerForMethod:@"POST" path:@"/" requestClass:[GCDWebServerMultiPartFormRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        NSArray *arr = [(GCDWebServerMultiPartFormRequest*)request arguments];
        for (GCDWebServerMultiPartArgument *argument in arr) {
            DbKeyValue * keyValue = [DbKeyValue new];
            keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
            keyValue.value = argument.string;
            keyValue.createTime =[DbKeyValue getCurrentTime];
            keyValue.extCategory = @"text";
            [weakSelf.dataSource addRecord:keyValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                //[weakSelf.shuKucollectionView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
            });
            
        }
        
        GCDWebServerDataResponse* response = [GCDWebServerDataResponse responseWithJSONObject:[weakSelf.dataSource getRecordsFrom:0 to:100]];
        //response = [GCDWebServerDataResponse responseWithStatusCode:200];
        //响应头设置，跨域请求需要设置，只允许设置的域名或者ip才能跨域访问本接口）
        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        [response setValue:@"Content-Type" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        //设置options的实效性（我设置了12个小时=43200秒）
        [response setValue:@"43200" forAdditionalHeader:@"Access-Control-max-age"];
        [response setStatusCode:200];
        return response;
    }];
    
    // Start server on port 8080
    [_webServer startWithPort:8080 bonjourName:nil];
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
    
}

@end
