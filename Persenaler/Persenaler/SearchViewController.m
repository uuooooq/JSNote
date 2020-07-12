//
//  SearchViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/12.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "SearchViewController.h"
#import "DataSource.h"
#import "ItemDetailViewController.h"
#import "TestViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface SearchViewController ()<UITextFieldDelegate>{
    UITextField *searchTF;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [DataSource sharedDataSource];
    self.view.backgroundColor = [UIColor whiteColor];
    
    searchTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width - 100, 30)];
    searchTF.placeholder = @"请输入搜索关键字";
    searchTF.backgroundColor = [UIColor whiteColor];
    searchTF.layer.cornerRadius = 5;
    searchTF.clipsToBounds = YES;
    searchTF.delegate = self;
    searchTF.keyboardType = UIKeyboardTypeWebSearch;
    self.navigationItem.titleView = searchTF;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    
    
}

-(void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([searchTF.text length]>0) {
        
    }
    else{
        [searchTF becomeFirstResponder];
        [self searchAction:@""];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [searchTF resignFirstResponder];
}

#pragma mark action

-(void)searchAction:(NSString*)searchStr{
    
    if ([searchStr isEqualToString:@""]) {
        [self.currentDataArr removeAllObjects];
    }
    else{
        [self.currentDataArr removeAllObjects];
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:[self.dataSource getSearchKeyValueWith:searchStr]];
        [self.currentDataArr addObjectsFromArray:tmpArr];
        
    }

    [self.shuKucollectionView reloadData];
    //[self.shuKucollectionView.mj_footer setState:MJRefreshStateNoMoreData];
    //[self.footer setTitle:@"已无更多数据" forState:MJRefreshStateIdle];
    //self.shuKucollectionView.mj_footer.hidden = YES;
    [self noMoreData];
}

#pragma mark UITextFielddelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"====== %@",[textField.text stringByReplacingCharactersInRange:range withString:string]);
    [self searchAction:searchStr];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"========== %@",textField.text);
    [searchTF resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didSelectionCell:(NSIndexPath*)indexPath{
    
    ItemDetailViewController *itemDetailVC = [ItemDetailViewController new];
    itemDetailVC.fromKeyValue = [self.currentDataArr objectAtIndex:indexPath.row];
    //itemDetailVC.title = @"详情";
    //itemDetailVC.navigationController.navigationBar.prefersLargeTitles = YES;
    itemDetailVC.title = itemDetailVC.fromKeyValue.value;
    itemDetailVC.isDetailPage = YES;
    [self.navigationController pushViewController:itemDetailVC animated:YES];
    
//    TestViewController *testVc = [TestViewController new];
//    [self.navigationController pushViewController:testVc animated:YES];
}

@end
