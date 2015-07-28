//
//  Sun2View.m
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "Sun2View.h"

@implementation Sun2View
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Sun2View";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) titel:@"返回"];
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
