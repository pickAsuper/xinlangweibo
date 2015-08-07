//
//  LCComposeMenuButton.m
//  新浪微博
//
//  Created by lichao on 15/8/7.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposeMenuButton.h"
#import "POP.h"
@implementation LCComposeMenuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment =NSTextAlignmentCenter;
        self.titleLabel.font =SYS_FONT(14);
        self.imageView.contentMode =UIViewContentModeCenter;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    //跳调整按钮图片的位置
    self.imageView.x =0;
    self.imageView.y=0;
    self.imageView.width =80;
    self.imageView.height =80;
    
    //调整按钮文字位置
    self.titleLabel.x =0;
    self.titleLabel.y =self.imageView.height;
    self.titleLabel.width =self.imageView.height;
    self.titleLabel.height =self.height -self.imageView.height;
    



}
-(void)showWithType:(LCComposeMenuButtonType)type index:(NSInteger)index{
    POPSpringAnimation *anim =[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    anim.toValue =[NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY- 350)];
    
    //弹簧摩擦力
    anim.springBounciness = 9;
    //速度
    anim.springSpeed =12;
    [self pop_addAnimation:anim forKey:nil];


}


@end
