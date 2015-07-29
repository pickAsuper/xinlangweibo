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
@property (weak, nonatomic) IBOutlet UIButton *quertBtn;


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
    
    imageView.width =35;
    
    
    //设置文本框属性左边视图
    self.searchFiled.leftView =imageView;
    //设置为总是显示 >>默认是不显示的
    self.searchFiled.leftViewMode =UITextFieldViewModeAlways;
    self.searchFiled.delegate =self;
    
    
    
}
//textField的代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    让右边的自动布局等于取消按钮的宽度
    self.horizon.constant = self.quertBtn.width;
  
    //自动布局不能直接放动画里>>没有效果 >>需要掉重绘的方法
    //textField开始编辑的时候，会回调这个方法
    //更新约束，完新完约束，代表需要重新布局。如果想执行执行，就把重新布局的代码放在动画的block里面
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
}
//点击按钮事件 >>让textField长度恢复 并且取消第一响应者
- (IBAction)quertBtn:(UIButton *)sender {
    self.horizon.constant =0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    [self endEditing:YES];
}



@end
