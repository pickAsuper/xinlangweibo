//
//  SunView.m
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "SunView.h"
#import "Sun2View.h"

@implementation SunView

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title =@"SunView";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(sun1Click) titel:@"首页"];

}
-(void)sun1Click{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    Sun2View *sunview =[[Sun2View alloc]init];
    [self.navigationController pushViewController:sunview animated:YES];
    
}

@end
