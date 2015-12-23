//
//  MyAppEngine.m
//  SlideLikeQQ
//
//  Created by LingLi on 15/12/23.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "MyAppEngine.h"
#import "AppDelegate.h"
#import "FundamentalViewController.h"
#import "ContactsController.h"
#import "HomeViewController.h"
#import "MainTabBarController.h"
static MyAppEngine *sharedElement = nil;

@implementation MyAppEngine

+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [[self alloc]init];
        }
    }
    
    return sharedElement;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (sharedElement == nil) {
            sharedElement = [super allocWithZone:zone];
            return sharedElement;
        }
    }
    return nil;
}


- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}

- (id)init {
    
    if(self = [super init]) {
        
        self.rootViewController =(FundamentalViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
        self.rootViewController.mainTabBarController = [[MainTabBarController alloc]init];
        self.contactsVC = [[ContactsController alloc]init];
        
        self.homeViewController = [[HomeViewController alloc]init];
        self.homeNav = [[UINavigationController alloc]initWithRootViewController:self.homeViewController];
        NSLog(@"piu %@",self.homeViewController.navigationController);
         NSLog(@"piu %@",self.homeNav);
    }
    return self;
}

@end
