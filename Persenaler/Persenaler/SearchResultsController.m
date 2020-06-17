//
//  SearchResultsController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/29.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "SearchResultsController.h"
#import "ItemDetailViewController.h"

@interface SearchResultsController ()

@end

@implementation SearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"搜索关键字：%@", searchController.searchBar.text);
    //searchController.searchResultsController.view.hidden = NO;
    
    [self searchAction:searchController.searchBar.text];
    //谓词搜索
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
//    self.searchData = [self.originalData filteredArrayUsingPredicate:preicate];
//
//    [self.tableView reloadData];
}

-(void)didSelectionCell:(NSIndexPath*)indexPath{
    
    ItemDetailViewController *itemDetailVC = [ItemDetailViewController new];
    itemDetailVC.fromKeyValue = [self.currentDataArr objectAtIndex:indexPath.row];
        itemDetailVC.title = @"详情";
    itemDetailVC.isDetailPage = YES;
    [self.presentingViewController.navigationController pushViewController:itemDetailVC animated:YES];
    
//    TestViewController *testVc = [TestViewController new];
//    [self.navigationController pushViewController:testVc animated:YES];
}

@end
