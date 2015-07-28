//
//  LCSearchView.m
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCSearchView.h"

@interface LCSearchView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchFiled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizon;


@end

@implementation LCSearchView
+(instancetype)searchWithView{
   
    return [[[NSBundle mainBundle]loadNibNamed:@"LCSearchView" owner:nil options:nil]lastObject];

}

//XIB加载完成 >>连线完成就就调用这个方法 >>在这里面布局子控件
-(void)awakeFromNib{
    
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    
    //设置照片的显示模式
    imageView.contentMode =UIViewContentModeCenter;

    //设置文本框属性左边视图
    self.searchFiled.leftView =imageView;
    //设置为总是显示 >>默认是不显示的
    self.searchFiled.leftViewMode =UITextFieldViewModeAlways;
    self.searchFiled.delegate =self;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.horizon.constant = self.searchFiled.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsDisplay];
    }];
    
}

@end
