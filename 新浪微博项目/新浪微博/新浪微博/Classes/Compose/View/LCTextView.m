//
//  LCTextView.m
//  新浪微博
//
//  Created by lichao on 15/8/8.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCTextView.h"
@interface LCTextView()<UITextViewDelegate>  //继承UIText需要遵守它的协议才行

@end

@implementation LCTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font =[UIFont systemFontOfSize:14];
        UILabel *placehoderLabel = [[UILabel alloc]init];
        
        placehoderLabel.numberOfLines =0;
        placehoderLabel.textColor =[UIColor grayColor];
        
        [self addSubview:placehoderLabel];
        
        self.placeholderLabel = placehoderLabel;
        //需哟重写font的set方法来一起(占位文字和输入文字)改变字体大小
        self.placeholderLabel.font =self.font;
        
        //不要用代理就>>自己成为自己的代理是件很危险的事
        //这里需要用到通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        
        
    }
    return self;
}
//布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.x =6;
    self.placeholderLabel.y =7;
    
    //文本最大宽度
    CGSize constrainedSize =CGSizeMake(self.width-self.placeholderLabel.x*2, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholderLabel.text sizeWithFont:self.placeholderLabel.font constrainedToSize:constrainedSize];
    
    
    
}

//设置占位文字
-(void)setPlacehoder:(NSString *)placehoder{
    _placehoder =placehoder;
    self.placeholderLabel.text = placehoder;

}
//设置文字大小
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font =font;
}

-(void)textViewDidChange:(UITextView *)textView{
    //隐藏占位文字
    self.placeholderLabel.hidden =self.text.length;
    
}


@end
