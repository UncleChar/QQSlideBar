//
//  HomeViewController.m
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "HomeViewController.h"
#import "OtherViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    NSLog(@"vv+%@",self.navigationController);
    [self configSegumentController];
//    [self jumpToOtherController];
}

- (void)configSegumentController {
    
    NSArray *buttonNames = [NSArray arrayWithObjects:@"消息", @"电话", nil];
    
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:buttonNames];
    [segmentedControl setFrame:CGRectMake(self.view.frame.size.width/2 - 100, 26, 200, 30)];
    segmentedControl.selectedSegmentIndex=0;
    
//    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
}

- (void)jumpToOtherController {


    OtherViewController *other = [[OtherViewController alloc]init];
    other.nameOfController = _titleOfController;
    [self.navigationController pushViewController:other animated:nil];
    
}




@end
