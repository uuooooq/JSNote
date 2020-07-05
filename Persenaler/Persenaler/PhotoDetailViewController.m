//
//  PhotoDetailViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/7/2.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "ZDWUtility.h"
#import "ZDWPhotoView.h"

@interface PhotoDetailViewController ()<ZDWPhotoViewDelegate>

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString* filePath = [ZDWUtility getImagePath:self.imgKeyValue.value];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    ZDWPhotoView* photoView = [[ZDWPhotoView alloc] initWithFrame:self.navigationController.view.bounds];
    [photoView setImage:image];
    photoView.photoDelegate = self;
    [self.view addSubview:photoView];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}


// ZDWPhotoViewDelegate <NSObject>
#pragma mark ZDWPhotoViewDelegate
-(void)photoViewTapAction{
    
//    if (self.navigationController.navigationBar.hidden) {
//        <#statements#>
//    }
    
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
