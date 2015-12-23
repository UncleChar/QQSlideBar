//
//  OtherViewController.m
//  SlideLikeQQ
//
//  Created by LingLi on 15/12/23.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "OtherViewController.h"
#import "MyAppEngine.h"
#import "FundamentalViewController.h"
#import "MainTabBarController.h"
@implementation OtherViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = _nameOfController;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"く返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    NSLog(@"fffff %@",self.navigationController);
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel  *label = [[UILabel alloc]init];
    label.text = self.nameOfController;
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textColor = [UIColor colorWithRed:252/255.0 green:166.0/255.0 blue:41.0/255.0 alpha:1];
    label.textAlignment = 1;
    label.frame = CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 40, 200, 80);
    [self.view addSubview:label];
    

    UIPanGestureRecognizer  *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];

    
}
- (void)pan:(UIPanGestureRecognizer *)recognizer {

    CGFloat panX    = [recognizer translationInView:self.view].x;
//    NSLog(@"distaanceX %f",panX);
    
    if (panX > 50) {
        
        [self goBack];
    }
}


- (void)goBack {

    [self.navigationController popViewControllerAnimated:YES];
    [MyAppEngine sharedInstance].rootViewController.mainTabBarController.tabBar.hidden = NO;
}

@end
