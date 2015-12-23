//
//  HomeViewController.h
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) NSString  *titleOfController;
- (void)jumpToOtherController;
@end
