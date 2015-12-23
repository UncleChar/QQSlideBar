//
//  FundamentalViewController.h
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBarController;
@class HomeViewController;

@interface FundamentalViewController : UIViewController

@property (nonatomic, strong) MainTabBarController *mainTabBarController;
@property (nonatomic, strong) HomeViewController   *homeViewController;
- (void)homeControllerAppear;

@end
