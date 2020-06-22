//
//  NewFolderViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/22.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "NewFolderViewController.h"
#import "ZDWUtility.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface NewFolderViewController ()

@end

@implementation NewFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [DataSource sharedDataSource];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 200)];
    //_textView.backgroundColor = [UIColor lightGrayColor];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textView.layer.cornerRadius = 5;
    
    [self.view addSubview:_textView];
    
    //IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //manager.toolbarDoneBarButtonItemText = @"保存";
    [_textView addDoneOnKeyboardWithTarget:self action:@selector(saveAction)];
    //manager.toolbarDoneBarButtonItemImage = [UIImage imageNamed:@"save"];
    [_textView.keyboardToolbar.doneBarButton setTitle:@"保存"];
    // Do any additional setup after loading the view.
}

-(void)saveAction{
    
    if ([self.textView.text length] < 1) {
        return;
    }
    
    if(self.fromKeyValue){
        
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = self.textView.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_SUB_ROOT_TEXT;
        [self.dataSource addRecord:keyValue];
        
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }
    else{
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = self.textView.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_ROOT_TEXT;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        [self.dataSource addRecord:keyValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }

}

@end
