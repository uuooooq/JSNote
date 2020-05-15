//
//  ViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/23.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "ViewController.h"
#import "BaseRecordCell.h"
#import "DataSource.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "ZDWUtility.h"
#import "ImageRecordCell.h"
#import "SearchViewController.h"
#import "InputViewController.h"

@interface ViewController ()<TZImagePickerControllerDelegate>
{
    UIView *bottomView;
    
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dataSource = [DataSource sharedDataSource];
//    [self.dataSource loadRecord];
    [self initView];
    [self receiveNotiAction];
    //[self initHttpServer];
    
    
}






-(void)initView{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goToSearchAction)];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goToSearchAction)];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(goToSearchAction)];
    self.navigationItem.rightBarButtonItems = @[searchItem,settingItem];
    
}

#pragma mark action method

-(void)goSettingAction{
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

-(void)goToSearchAction{
    
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

-(void)addAction{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选择类型"
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self addPhotoAction];
    }];
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"文字" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self addTextAction];
    }];
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"故事线" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction2];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)addTextAction{
    
    [self presentViewController:[InputViewController new] animated:YES completion:^{
        
    }];
    
}

-(void)addPhotoAction{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
        for (int i=0; i < [photos count]; i++) {
            PHAsset * currentAsset = [assets objectAtIndex:i];
            UIImage * tmpImg = [photos objectAtIndex:i];
            NSString *currentImgName = [currentAsset valueForKey:@"filename"] ;
            NSData *imagedata=UIImagePNGRepresentation(tmpImg);
            NSString *newImageName=[self getImagePath:currentImgName];
            BOOL result =  [imagedata writeToFile:newImageName options:NSAtomicWrite error:nil];//[imagedata writeToFile:rootDir atomically:YES];
            NSLog(@"=============== %lu  %@",(unsigned long)[photos count],newImageName);
            if (result == YES) {
                NSLog(@"保存成功");
                
                NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
                [extCategoryDic setObject:@"img" forKey:@"type"];
                
                DbKeyValue * keyValue = [DbKeyValue new];
                keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
                keyValue.value = currentImgName;
                keyValue.createTime =[DbKeyValue getCurrentTime];
                keyValue.type = VT_IMG;
                keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
                [self.dataSource addRecord:keyValue];
                //[weakSelf.dataSource addRecord:keyValue];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
            }
        }
        

    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (NSString*)getImagePath:(NSString *)name {

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);

    NSString *docPath = [path objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *finalPath = [docPath stringByAppendingPathComponent:name];

    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    return finalPath;

}




@end
