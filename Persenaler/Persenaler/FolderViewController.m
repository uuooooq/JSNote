//
//  FolderViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/27.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "FolderViewController.h"

@interface FolderViewController ()

@end

@implementation FolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNextPage];
    // Do any additional setup after loading the view.
    //UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    UIBarButtonItem *choiceItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(choiceAction)];
    self.navigationItem.rightBarButtonItem = choiceItem;
}

-(void)loadNextPage{
    
    NSArray *arr;
    if (self.fromKeyValue) {
        arr = [self.dataSource getSubRecordsFolderWith:self.fromKeyValue.key pageNumWith:self.currentPageContentNum pageWith:self.loadPageTime];
    }
    else{
        arr = [self.dataSource getKeyValuesFolderPageNumWith:self.currentPageContentNum pageWith:self.loadPageTime];
    }
    
    //NSArray* arr = [self.dataSource getSubRecordsWith:self.fromKeyValue.key pageNumWith:self.currentPageContentNum pageWith:self.loadPageTime];
    if (arr && [arr count]>0) {
        [self.currentDataArr addObjectsFromArray:arr];
        self.currentPageNum = self.currentPageNum + 1;
        [self.shuKucollectionView reloadData];
        
        DbKeyValue *lastValue = [self.currentDataArr lastObject];
        self.loadPageTime = lastValue.createTime;
    }
    else{
        //[self.shuKucollectionView.mj_footer setState:MJRefreshStateNoMoreData];
    }
    if ([arr count]<self.currentPageContentNum) {
        [self noMoreData];
    }

}
                                   

-(void)didSelectionCell:(NSIndexPath*)indexPath{
    
    DbKeyValue * tmpKeyValue  = [self.currentDataArr objectAtIndex:indexPath.row];
       if (tmpKeyValue.type == VT_ROOT || tmpKeyValue.type == VT_SUB_ROOT) {
           FolderViewController *itemDetailVC = [FolderViewController new];
           itemDetailVC.fromKeyValue = [self.currentDataArr objectAtIndex:indexPath.row];
           itemDetailVC.moveKeyValue = self.moveKeyValue;
           //itemDetailVC.title = @"详情";
           itemDetailVC.navigationController.navigationBar.prefersLargeTitles = YES;
           itemDetailVC.title = itemDetailVC.fromKeyValue.value;
           //itemDetailVC.navigationController.navigationBar.largeTitleTextAttributes =
           [self.navigationController.navigationBar setLargeTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0f],NSFontAttributeName,nil]];
           [self.navigationController pushViewController:itemDetailVC animated:YES];
       }
    
}
-(void)choiceAction{
    
    //  目录 移动到 文件夹
    {
        //根目录 移动到 子目录
        if (self.moveKeyValue.type == VT_ROOT &&
            (self.fromKeyValue.type == VT_SUB_ROOT || self.fromKeyValue.type == VT_ROOT )) {
            
            self.moveKeyValue.type = VT_SUB_ROOT;
            [[DataSource sharedDataSource] updateKeyValue:self.moveKeyValue];
            
            SubRecord * subRecord = [SubRecord new];
            subRecord.createTime = self.moveKeyValue.createTime;
            subRecord.rootKey = self.fromKeyValue.key;
            subRecord.subKey = self.moveKeyValue.key;
            
            [[DataSource sharedDataSource] addSubRecord:subRecord];
            //            [[NSNotificationCenter defaultCenter]
            //             postNotificationName:@"refetchData" object:nil];
            //            [self.navigationController dismissViewControllerAnimated:YES
            //                                                          completion:^{
            //
            //            }];
        }
        
        // 子目录 移动到 根目录
        if ((self.moveKeyValue.type == VT_SUB_ROOT || self.moveKeyValue.type == VT_ROOT ) && !self.fromKeyValue) {
            
            NSArray *arr = [[DataSource sharedDataSource]
                            getSubRecordWithSubKey:self.moveKeyValue.key];
            if (arr && [arr count]>0) { //删除目录索引
                SubRecord *subRecord = [arr objectAtIndex:0];
                [[DataSource sharedDataSource] deleteSubRecord:subRecord];
            }
            self.moveKeyValue.type = VT_ROOT;
            [[DataSource sharedDataSource] updateKeyValue:self.moveKeyValue];
            
        }
        
        // 子目录 移动到 不同的子目录
        if ((self.moveKeyValue.type == VT_SUB_ROOT || self.moveKeyValue.type == VT_ROOT )&&
            (self.fromKeyValue.type == VT_SUB_ROOT || self.fromKeyValue.type == VT_ROOT) &&
            (self.moveKeyValue.key != self.fromKeyValue.key)) {
            
            NSArray *arr = [[DataSource sharedDataSource]
                            getSubRecordWithSubKey:self.moveKeyValue.key];
            if (arr && [arr count]>0) { //删除目录索引
                SubRecord *subRecord = [arr objectAtIndex:0];
                subRecord.rootKey = self.fromKeyValue.key;
                [[DataSource sharedDataSource] updateSubRecord:subRecord];
            }
            else{
                SubRecord * subRecord = [SubRecord new];
                subRecord.createTime = self.moveKeyValue.createTime;
                subRecord.rootKey = self.fromKeyValue.key;
                subRecord.subKey = self.moveKeyValue.key;
                
                [[DataSource sharedDataSource] addSubRecord:subRecord];
            }
        }
    }
    
    // 文件 移动到 文件夹
    {
        //根文件 移动到 子目录
        if ((self.moveKeyValue.type == VT_IMG ||
             self.moveKeyValue.type == VT_TEXT) &&
            (self.fromKeyValue.type == VT_ROOT ||
             self.fromKeyValue.type == VT_SUB_ROOT)) {
            
            self.moveKeyValue.type = self.moveKeyValue.type + 19;
            [[DataSource sharedDataSource] updateKeyValue:self.moveKeyValue];
            
            SubRecord * subRecord = [SubRecord new];
            subRecord.createTime = self.moveKeyValue.createTime;
            subRecord.rootKey = self.fromKeyValue.key;
            subRecord.subKey = self.moveKeyValue.key;
            
            [[DataSource sharedDataSource] addSubRecord:subRecord];
            //            [[NSNotificationCenter defaultCenter]
            //             postNotificationName:@"refetchData" object:nil];
            //            [self.navigationController dismissViewControllerAnimated:YES
            //                                                          completion:^{
            //
            //            }];
        }
        
        //子文件 移动到 根目录
        if ((self.moveKeyValue.type == VT_SUB_IMG ||
             self.moveKeyValue.type == VT_SUB_TEXT) &&
            !self.fromKeyValue) {
            
            NSArray *arr = [[DataSource sharedDataSource]
                            getSubRecordWithSubKey:self.moveKeyValue.key];
            if (arr && [arr count]>0) { //删除目录索引
                SubRecord *subRecord = [arr objectAtIndex:0];
                [[DataSource sharedDataSource] deleteSubRecord:subRecord];
            }
            self.moveKeyValue.type = self.moveKeyValue.type - 19;
            [[DataSource sharedDataSource] updateKeyValue:self.moveKeyValue];
            
        }
        
        // 子文件 移动到 不同的子目录
        if ((self.moveKeyValue.type == VT_SUB_IMG ||
             self.moveKeyValue.type == VT_SUB_TEXT) &&
            (self.fromKeyValue.type == VT_ROOT ||
             self.fromKeyValue.type == VT_SUB_ROOT)) {
            
            NSArray *arr = [[DataSource sharedDataSource]
                            getSubRecordWithSubKey:self.moveKeyValue.key];
            if (arr && [arr count]>0) { //删除目录索引
                SubRecord *subRecord = [arr objectAtIndex:0];
                subRecord.rootKey = self.fromKeyValue.key;
                [[DataSource sharedDataSource] updateSubRecord:subRecord];
            }
            else{
                SubRecord * subRecord = [SubRecord new];
                subRecord.createTime = self.moveKeyValue.createTime;
                subRecord.rootKey = self.fromKeyValue.key;
                subRecord.subKey = self.moveKeyValue.key;
                
                [[DataSource sharedDataSource] addSubRecord:subRecord];
            }
        }
        
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refetchData" object:nil];
    [self.navigationController dismissViewControllerAnimated:YES
                                                  completion:^{
        
    }];
    
}

@end
