//
//  HttpServerHandler.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/3/12.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "HttpServerHandler.h"
#import "DataSource.h"
#import "ZDWUtility.h"



@interface HttpServerHandler (){
    //GCDWebDAVServer* davServer;
    
}

@property(nonatomic,strong) DataSource *dataSource;

@end

@implementation HttpServerHandler

-(void)startServer{
    self.dataSource = [DataSource new];
    [self.dataSource loadRecord];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSLog(@"path:   %@",documentsDirectory);
    self.webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsDirectory];
    self.webServer.delegate = self;
    [self startIndexServices];
    [self startFetchListApi];
    [self startAddItemApi];
    [self startSearchApi];
    [self startTestServices];
    
    // 启动服务器在8080端口
    [_webServer startWithPort:8080 bonjourName:nil];
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
    
    
    
}


-(void)startIndexServices{
        
    NSString *rootDir = [[NSBundle mainBundle] pathForResource:@"website" ofType:nil];
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:rootDir indexFilename:@"index.html" cacheAge:3600 allowRangeRequests:YES];
}

-(void)startTestServices{
    
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"GET" path:@"/file" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        NSLog(@"==================%@",[request.query objectForKey:@"imageName"]);
        NSString* imageName = [request.query objectForKey:@"imageName"];
        NSData *obj = [NSData dataWithContentsOfFile:[weakSelf getImagePath:imageName]];
        GCDWebServerDataResponse* response = [GCDWebServerDataResponse responseWithData:obj contentType:@"image/png"];

        [response setStatusCode:200];
        
        return response;
    }];
}

- (NSString*)getImagePath:(NSString *)name {

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);

    NSString *docPath = [path objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *finalPath = [docPath stringByAppendingPathComponent:name];
    
//    NSString *finalPath = [[NSBundle mainBundle] pathForResource:@"website" ofType:nil];
//    finalPath = [finalPath stringByAppendingFormat:@"/data/files/test2.png"];

    

    // Remove the filename and create the remaining path

    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键

    

    return finalPath;

}


// 获取指定条目数据
-(void)startFetchListApi{
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"GET" path:@"/hello" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        NSLog(@"%@ %@",[request.query objectForKey:@"start"],[request.query objectForKey:@"end"]);
        int start = [[request.query objectForKey:@"start"] intValue];
        int end = [[request.query objectForKey:@"end"] intValue];
        
        NSArray * obj = [weakSelf.dataSource getRecordsFrom:start to:end];
        GCDWebServerDataResponse* response = [GCDWebServerDataResponse responseWithJSONObject:obj];

        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        [response setValue:@"Content-Type" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        //设置options的实效性（我设置了12个小时=43200秒）
        [response setValue:@"43200" forAdditionalHeader:@"Access-Control-max-age"];
        [response setStatusCode:200];
        
        return response;
    }];
}


// 添加数据接口
-(void)startAddItemApi{
    
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"POST" path:@"/" requestClass:[GCDWebServerMultiPartFormRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        NSArray *arr = [(GCDWebServerMultiPartFormRequest*)request arguments];
        for (GCDWebServerMultiPartArgument *argument in arr) {
            NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
            [extCategoryDic setObject:TXT forKey:@"type"];
            DbKeyValue * keyValue = [DbKeyValue new];
            keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
            keyValue.value = argument.string;
            keyValue.createTime =[DbKeyValue getCurrentTime];
            keyValue.type = VT_TEXT;
            //keyValue.extCategory = @"{}";
            //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
            NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
            [propertyDic setValue:@"" forKey:@"markcolor"];
            [propertyDic setValue:@"" forKey:@"markstr"];
            keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
            keyValue.search = keyValue.value;
            //[weakSelf.dataSource addRecord:keyValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.dataSource addRecord:keyValue];
                // UI更新代码
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
}

// 匹配查找
-(void)startSearchApi{
    __weak typeof(self) weakSelf = self;
    [_webServer addHandlerForMethod:@"GET" path:@"/search" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        NSLog(@"%@",[request.query objectForKey:@"searchWord"]);
        NSString* searchWord = [request.query objectForKey:@"searchWord"];
        
        NSArray * obj = [weakSelf.dataSource getSearchWith:searchWord];
        GCDWebServerDataResponse* response = [GCDWebServerDataResponse responseWithJSONObject:obj];

        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        [response setValue:@"Content-Type" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        //设置options的实效性（我设置了12个小时=43200秒）
        [response setValue:@"43200" forAdditionalHeader:@"Access-Control-max-age"];
        [response setStatusCode:200];
        
        return response;
    }];
}

-(NSString*)getAddr{
    return [_webServer.serverURL absoluteString];
}

-(void)saveFileItem:(NSString*)fileName{
    
    
    if (!fileName || [fileName length]<1) {
        return;
    }
    NSLog(@"开始记录文件到数据库");
    NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
    [extCategoryDic setObject:IMG forKey:@"type"];
    
    DbKeyValue * keyValue = [DbKeyValue new];
    keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
    keyValue.value = fileName;
    keyValue.createTime =[DbKeyValue getCurrentTime];
    keyValue.type = VT_IMG;
    //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
    NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
    [propertyDic setValue:@"" forKey:@"markcolor"];
    [propertyDic setValue:@"" forKey:@"markstr"];
    keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
    keyValue.search = keyValue.value;
    [self.dataSource addRecord:keyValue];
    //[weakSelf.dataSource addRecord:keyValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
}

#pragma mark upload file delegate

/**
 *  This method is called whenever a file has been downloaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDownloadFileAtPath:(NSString*)path{
    NSLog(@"********************* didDownloadFileAtPath %@ %@",path,[path lastPathComponent]);
    
}

/**
 *  This method is called whenever a file has been uploaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path{
    NSLog(@"********************* didUploadFileAtPath %@ %@",path,[path lastPathComponent]);
    [self saveFileItem:[path lastPathComponent]];
    
}

/**
 *  This method is called whenever a file or directory has been moved.
 */
- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath{
    NSLog(@"********************* didMoveItemFromPath %@",fromPath);
}

/**
 *  This method is called whenever a file or directory has been deleted.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path{
    
    NSLog(@"********************* fromPath %@",path);
}

/**
 *  This method is called whenever a directory has been created.
 */
- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path{
    
    NSLog(@"********************* didCreateDirectoryAtPath %@",path);
}

- (void)webServerDidStart:(GCDWebServer*)server{
    NSLog(@"---***%@",[self getAddr]);
    //vc.title = [self getAddr];
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        [[NSNotificationCenter defaultCenter] postNotificationName:@"serverRunning" object:nil];
    });
}

@end
