//
//  LCStatusToolBar.m
//  新浪微博
//
//  Created by lichao on 15/8/3.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

/*
 
 1. 在这个view里面添加 按钮 和 imageView (用来分割按钮的线)
 2.  这个view是cell下面的转发 评论 赞
 >>在initWithFrame 里面初始化 按钮 和 imageView
 >> 在layoutSubView 里面设置 他们的位置
 
 
 */

#import "LCStatusToolBar.h"

@interface LCStatusToolBar ()

//装按钮的数组
@property (nonatomic ,strong)NSMutableArray *arrayBtn;

//装imageView得数组
@property (nonatomic ,strong)NSMutableArray *arrayImageView;

@end


@implementation LCStatusToolBar

-(NSMutableArray *)arrayImageView{
    if (!_arrayImageView) {
        
        _arrayImageView =[NSMutableArray array];
    }

    return _arrayImageView;
}


-(NSMutableArray *)arrayBtn{
    if (!_arrayBtn) {
        _arrayBtn =[NSMutableArray array];
    }

    return _arrayBtn;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addButtonWithTitel:@"转发" btnImageName:@"timeline_icon_retweet"];

        [self addButtonWithTitel:@"评论" btnImageName:@"timeline_icon_comment"];

        [self addButtonWithTitel:@"转发" btnImageName:@"timeline_icon_unlike"];

        [self addChildImageView];
        [self addChildImageView];
        
        
    }
    return self;
}

//添加在view上的imageView >> 用来分割 按钮的中间线
-(void)addChildImageView{
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [self addSubview:imageView];
    [self.arrayImageView addObject:imageView];
    
    
}


//在view上添加的按钮 >>需要传文字和 图片进去
-(void)addButtonWithTitel:(NSString *)titel btnImageName:(NSString *)imageName{
    UIButton *btn =[[UIButton alloc]init];
     //设置按钮文字
    [btn setTitle:titel forState:UIControlStateNormal];
    [btn setTintColor:[UIColor grayColor]];
    [btn.titleLabel setFont:SYS_FONT(15)];
    //设置按钮图片
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    
       //添加到view上
    [self addSubview:btn];
    [self.arrayBtn addObject:btn];
    
}
//计算子控件btn高度 (这是个view btn在view里面创建的 需要在这里 layoutSubviews 计算按钮的位置)
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //计算出按钮在View上的位置
    NSInteger count = self.arrayBtn.count;
   
   
    CGFloat btnW = self.width /count;
    CGFloat btnH = self.height;
    
    
    for (int i = 0 ; i <count ; i++) {
       UIView *chlidView  = self.subviews[i];
        chlidView.x = i * btnW;
        chlidView.width  =btnW;
        chlidView.height =btnH;
    }

     //计算出imageView在View上的位置
    for (int j = 0 ; j < self.arrayImageView.count; j++) {
       UIImageView *chlidImage = self.arrayImageView[j];
        chlidImage.x = btnW *(j+1) -chlidImage.width * 0.5;
        
    }

   
   
    
    
    
    

}


@end
