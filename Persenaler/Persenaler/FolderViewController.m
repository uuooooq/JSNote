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
    
    
    /*
     情况很多，分类别描述
     1. item to Folder
        1) 要判断当前选择的folder和item所属的folder是否是同一个folder，是同一个弹框提醒，不是同一个进行下一步
        2）要判断当前的位置是否是根目录下，如果是和移动到普通目录下逻辑有区别，如果是移动到普通目录下，进行下一步
        3）判断当前要移动的item是否是根目录下的，如果是，按从根目录下的item移动到普通目录下的逻辑执行，如果不是
            则按普通目录下的item移动到普通目录下的逻辑执行
     */
    if (self.fromKeyValue.type == VT_ROOT || self.fromKeyValue.type == VT_SUB_ROOT) {
        if (!(self.moveKeyValue.type != VT_ROOT && self.moveKeyValue.type != VT_SUB_ROOT)) {
            
                
                
        }
    }
        
}

@end
