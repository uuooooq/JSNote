//
//  InputViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "InputViewController.h"
#import "ZDWUtility.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>


@interface InputViewController (){
    
    UIButton *saveBtn;
}

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DataSource sharedDataSource];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:_textView];
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = moreItem;
    
    if (self.editKeyValue) {
        self.textView.text = self.editKeyValue.value;
    }
}

-(void)saveAction{
    
    if ([self.textView.text length] < 1) {
        return;
    }
    
    if (self.editKeyValue) {
        self.editKeyValue.value = self.textView.text;
        [self.dataSource updateKeyValue:self.editKeyValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
        
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (self.fromKeyValue) {
        
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = self.textView.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_SUB_TEXT;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:@"" forKey:@"markstr"];
        keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
        keyValue.search = keyValue.value;
        [self.dataSource addRecord:keyValue];
        
        if (self.fromKeyValue.type == VT_TEXT) {
            self.fromKeyValue.type = VT_ROOT_TEXT;
            [self.dataSource updateKeyValue:self.fromKeyValue];
        }
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
    }
    else{
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = self.textView.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_TEXT;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:@"" forKey:@"markstr"];
        keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
        keyValue.search = keyValue.value;
        [self.dataSource addRecord:keyValue];
    }
    

    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
    
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
