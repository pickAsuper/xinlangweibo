//
//  UITextView+PlaceHolder.m
//  新浪微博
//
//  Created by lichao on 15/8/8.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

//只要包含这个分类就能让UITextView 有placeholder 的属性 (这个属性跟UILable的灰色占位文字一样)
#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>


@implementation UITextView (PlaceHolder)

-(void)setPlaceholder:(NSString *)placeholder{
    //动态给属性赋值
    objc_setAssociatedObject(self, @"placeholder", placeholder,OBJC_ASSOCIATION_COPY);
    
    UILabel *lable =[[UILabel alloc]init];
    lable.x = 6;
    lable.y = 8;
    lable.font = [UIFont systemFontOfSize:14];
    self.font =[UIFont systemFontOfSize:14];
    lable.text =placeholder;
    lable.size =[lable.text sizeWithFont:lable.font];
    [self addSubview:lable];
    
    
    
}
-(NSString *)placeholder{

    //取谁(第一个参数)身上的哪一个属性(通过key去取)
   return  objc_getAssociatedObject(self,@"placeholder" );
    

}

@end
