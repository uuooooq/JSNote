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
#import "DataSource.h"
#import "FolderViewController.h"
#import "AddPhotoTextViewController.h"

@interface PhotoDetailViewController ()<ZDWPhotoViewDelegate>

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString* filePath = [ZDWUtility getImagePath:self.imgKeyValue.value];
    UIImage *image = [UIImage imageWithData:[NSData
                                             dataWithContentsOfFile:filePath]];
    ZDWPhotoView* photoView = [[ZDWPhotoView alloc]
                               initWithFrame:self.navigationController.view.bounds];
    [photoView setImage:image];
    photoView.photoDelegate = self;
    [self.view addSubview:photoView];
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"更多"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(moreAction)];
    
    self.navigationItem.rightBarButtonItem = moreItem;//@[saveItem,moreItem];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)moreAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
      
      UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          //[self deleteAction:keyValue withIndexPath:indexPath];
          [[DataSource sharedDataSource] deleteKeyValue:self.imgKeyValue];
          [[NSNotificationCenter defaultCenter]
           postNotificationName:@"refetchData" object:nil];
          [alert dismissViewControllerAnimated:YES completion:^{
              [self.navigationController popViewControllerAnimated:YES];
          } ];
      }];

      UIAlertAction *moveAction = [UIAlertAction actionWithTitle:@"移动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          DbKeyValue *moveItem = self.imgKeyValue;//[self.currentDataArr objectAtIndex:indexPath.row];
          FolderViewController *folderVc = [FolderViewController new];
          folderVc.moveKeyValue = moveItem;
          //folderVc.fromKeyValue = self.fromKeyValue;

          UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:folderVc];
          [self presentViewController:navVC animated:YES completion:^{

          }];
      }];
      
      UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          //[self deleteAction:keyValue withIndexPath:indexPath];
          [self savePhotoAction:self.imgKeyValue];
      }];
      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
      }];
      
      [alert addAction:selectAction];
      //if (keyValue.type == VT_SUB_IMG || keyValue.type == VT_SUB_TEXT) {
        [alert addAction:moveAction];
      //}
          [alert addAction:saveAction];
          UIAlertAction *markAction = [UIAlertAction actionWithTitle:@"文字备注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              [self showPhotoTextEditView];
          }];
          [alert addAction:markAction];
      
      [alert addAction:cancelAction];
      [self presentViewController:alert animated:YES completion:nil];
}

-(void)savePhotoAction:(DbKeyValue*)keyvalue{
    
    NSString* filePath = [ZDWUtility getImagePath:keyvalue.value];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error.description, contextInfo);
    
    if (!error) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"已经保存到相册中" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    
}

-(void)showPhotoTextEditView{
    AddPhotoTextViewController *addPhotoVc = [AddPhotoTextViewController new];
    addPhotoVc.editKeyValue = self.imgKeyValue;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:addPhotoVc];
    popupController.containerView.layer.cornerRadius = 4;
    [popupController presentInViewController:self];
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
