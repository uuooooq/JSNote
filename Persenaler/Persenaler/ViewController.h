//
//  ViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/23.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
#import "HttpServerHandler.h"
#import "NewFunctionView.h"

@interface ViewController : BaseListViewController{
    
    
}

@property(nonatomic,strong) HttpServerHandler *serverHeadler;
@property(nonatomic,strong) NewFunctionView *newFunctionView;


@end

