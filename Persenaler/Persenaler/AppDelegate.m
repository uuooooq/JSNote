//
//  AppDelegate.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/23.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HttpServerHandler.h"

@interface AppDelegate (){
    ViewController * vc;
    HttpServerHandler *httpServerHandler;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)createAppWindow{
    if (@available(iOS 13.0, *)) {
        
    }else{
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        vc = [ViewController new];
        vc.title = @"Personal";
        httpServerHandler = [HttpServerHandler new];
        [httpServerHandler startServer];
        vc.serverHeadler = httpServerHandler;
        //NSLog(@"%@",[httpServerHandler getAddr]);
        //vc.title = [httpServerHandler getAddr];
        //[self setDir];
        UINavigationController *rootNavgationController = [[UINavigationController alloc] initWithRootViewController:vc];
        rootNavgationController.navigationBar.prefersLargeTitles = YES;
        self.window.rootViewController = rootNavgationController;
        //rootNavgationController.title = [httpServerHandler getAddr];
        [self.window makeKeyAndVisible];
    }
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
