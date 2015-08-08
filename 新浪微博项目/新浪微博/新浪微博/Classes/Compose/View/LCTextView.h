//
//  LCTextView.h
//  新浪微博
//
//  Created by lichao on 15/8/8.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTextView : UITextView

@property (nonatomic,weak)UILabel *placeholderLabel;


//给文本框添加一个placehoder的属性
@property (nonatomic,copy)NSString *placehoder;

@end
