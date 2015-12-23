//
//  MainTabBarController.m
//  SlideLikeQQ
//
//  Created by LingLi on 15/12/23.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "MainTabBarController.h"
#import "MyAppEngine.h"
#import "ContactsController.h"
#import "FundamentalViewController.h"

@interface MainTabBarController ()
{

    MyAppEngine    *appEngine;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {

    [super viewDidLoad];
    appEngine = [MyAppEngine sharedInstance];
    self.view.backgroundColor = [UIColor whiteColor];
     [[UITabBarItem appearance]setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    switch (item.tag) {
        case 0:
        {
            [appEngine.contactsVC.view removeFromSuperview];
        
        }
            
            break;
        case 1:
        {
        
            [appEngine.rootViewController.mainTabBarController.view addSubview:appEngine.contactsVC.view];
            [appEngine.rootViewController.mainTabBarController.view bringSubviewToFront:appEngine.rootViewController.mainTabBarController.tabBar];
            
        }
            
            break;
        case 2:
        {
            NSLog(@"Just like case 1 ↑");
        }
            break;
            
        default:
            break;
    }

}

@end
