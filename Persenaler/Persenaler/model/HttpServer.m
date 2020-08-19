//
//  HttpServer.m
//  Persenaler
//
//  Created by zhudongwei on 2020/8/19.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "HttpServer.h"

#import "DataSource.h"
#import "ZDWUtility.h"

@interface HttpServer (){
    
}

@property(nonatomic,strong) DataSource *dataSource;

@end

@implementation HttpServer

-(void)startServer{
    

    
    NSString *path = [ZDWUtility getDefaultDocument];
    
    self.webServer = [[GCDWebUploader alloc] initWithUploadDirectory:path];
    self.webServer.delegate = self;
    
    // 启动服务器在8080端口
    [_webServer startWithPort:8080 bonjourName:nil];
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
}

-(void)startIndexServices{
        
    NSString *rootDir = [[NSBundle mainBundle] pathForResource:@"website" ofType:nil];
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:rootDir indexFilename:@"index.html" cacheAge:3600 allowRangeRequests:YES];
}

//创建文件夹

//删除文件夹

//重命名文件夹

//移动文件夹

//创建记录

//删除记录

//修改记录

//移动记录

//获取列表

//搜索

//标记图片

//获取serverip地址
-(NSString*)getAddr{
    return [_webServer.serverURL absoluteString];
}

@end
