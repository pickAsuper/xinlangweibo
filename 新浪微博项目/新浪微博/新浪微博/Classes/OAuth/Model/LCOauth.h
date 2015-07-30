//
//  LCOauth.h
//  新浪微博
//
//  Created by lichao on 15/7/30.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCOauth : NSObject<NSCoding>
/*
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid
 {
 "access_token": "ACCESS_TOKEN",
 "expires_in": 1234,
 "remind_in":"798114",
 "uid":"12341234"
  
 把返回的数据进行归档 保存起来 需要遵守协议 <NSCoding> 在类方法里面去实现
 
 }
 */
@property (nonatomic ,copy)NSString *access_token;
@property (nonatomic ,assign)NSInteger expires_in;
@property (nonatomic ,copy)NSString *remind_in;
@property (nonatomic ,copy)NSString *uid;



@end
