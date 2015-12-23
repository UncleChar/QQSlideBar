//
//  MyAppEngine.h
//  SlideLikeQQ
//
//  Created by LingLi on 15/12/23.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FundamentalViewController;
@class ContactsController;
@class HomeViewController;
@class UINavigationController;

@interface MyAppEngine : NSObject

@property (nonatomic, strong) FundamentalViewController *rootViewController;
@property (nonatomic, strong) ContactsController        *contactsVC;
@property (nonatomic, strong) HomeViewController        *homeViewController;
@property (nonatomic, strong) UINavigationController    *homeNav;
+ (instancetype)sharedInstance;
@end
