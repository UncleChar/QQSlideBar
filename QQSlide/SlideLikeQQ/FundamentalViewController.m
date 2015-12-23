//
//  FundamentalViewController.m
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//https://lvwenhan.com/ios/446.html

#import "FundamentalViewController.h"
#import "HomeViewController.h"
#import "LeftViewController.h"
#import "MainTabBarController.h"
#import "MyAppEngine.h"
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface FundamentalViewController ()
{

//    HomeViewController   *homeVC;
    LeftViewController   *leftVC;
//    MainTabBarController *mainTBC;
    UIImageView          *backgroundIV;
    UIView               *blackCover;
    CGFloat   distance;
    CGFloat   fullDistance;
    CGFloat   proportion;
    UITapGestureRecognizer *tapOnFundamentalVC;
    UIView    *mainView;
    CGPoint   centerOfLeftViewAtBeginning;
    CGFloat   proportionOfLeftView;
    CGFloat   distanceOfLeftView;
    UIView    *tabBarView;
    UINavigationController *homeNavController;
    UITapGestureRecognizer *tapGesture;
}
@end

@implementation FundamentalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    MyAppEngine *baseApp = [MyAppEngine sharedInstance];
    
    /*
     右侧主视图左边界距离屏幕左边界的距离占屏幕宽度的比例为：78%
     右侧主视图的高度占屏幕高度的比例为：77%
     */
    distance     = 0;
    fullDistance = 0.78;
    proportion = 0.77;  //这些数据是别人给的缩小的比例
    proportionOfLeftView = 1;
    distanceOfLeftView = 50;
    //-----------------------------------------------注意添加覆盖的顺序
    backgroundIV = [[UIImageView alloc]init];
    backgroundIV.image = [UIImage imageNamed:@"back"];
    backgroundIV.frame = [UIScreen mainScreen].bounds;
   [self.view addSubview:backgroundIV];

    
    // 适配 4.7 和 5.5 寸屏幕的缩放操作，有偶发性小 bug
    if (kScreenWidth > 320) {
        
        proportionOfLeftView = kScreenWidth / 320;
        distanceOfLeftView += (kScreenWidth - 320)*fullDistance / 2;
        
    }
    

    

    
    leftVC = [[LeftViewController alloc]init];
    leftVC.view.center = CGPointMake((leftVC.view.center.x - 50), leftVC.view.center.y);
    leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);

    //动画初始参数
    centerOfLeftViewAtBeginning = leftVC.view.center;
    //把侧滑菜单加入跟控制器
    [self.view addSubview:leftVC.view];
    
    blackCover = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, 0)];
    blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackCover];
 
    //初始化主页
    _homeViewController = baseApp.homeViewController;
    _homeViewController.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureOnHomeVC:)];
    [_homeViewController.view addGestureRecognizer:_homeViewController.panGesture];
    [self.view addSubview:_homeViewController.view];//相当于在这个控制器上增加一个控制器

    
    mainView = [[UIView alloc]initWithFrame:self.view.frame];
    _mainTabBarController = [MyAppEngine sharedInstance].rootViewController.mainTabBarController;
    tabBarView = _mainTabBarController.view;
    [mainView addSubview:tabBarView];
    homeNavController = _homeViewController.navigationController;
    [tabBarView addSubview:homeNavController.view];
    [tabBarView addSubview:_homeViewController.view];

    
    [tabBarView bringSubviewToFront:_mainTabBarController.tabBar];
    [self.view addSubview:mainView];
    

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftControllerAppear)];
    leftItem.image = [UIImage imageNamed:@"qq@3x"];
    _homeViewController.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    [mainView addGestureRecognizer:_homeViewController.panGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeControllerAppear)];
    [self.view addGestureRecognizer:tapGesture];


}

#pragma mark 手势方法
- (void)gestureOnHomeVC:(UIPanGestureRecognizer *)recognizer {

    CGFloat distanceX    = [recognizer translationInView:self.view].x;
    CGFloat realDistance = distance + distanceX; //实时距离
    CGFloat realProportion = realDistance /(kScreenWidth * fullDistance);

        //结束时，自动激活停靠动作
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            
            if (realDistance > kScreenWidth * (proportion / 3)) {
                
                [self leftControllerAppear];
            
                
            }else if (realDistance < kScreenWidth * -(proportion / 3)){
                
                //这个页面未做
                [self rightControllerAppear];
                
            }else {
                
                [self homeControllerAppear];
            }
            
            return; //这是需要return，因为停止状态了;
        }
        
        //下面是计算缩放比例
        CGFloat scal = recognizer.view.frame.origin.x > 0 ? -1 : 1;
        scal *= realDistance / kScreenWidth;
        scal *= 1 - proportion;
        scal /= fullDistance + proportion / 2 - 0.5;
        scal += 1;
        
        if (scal <= proportion) { //若比例已经达到最小，则不在继续动画
            
            return;
        }
        // 执行视差特效
        blackCover.alpha = (scal - proportion) / (1 - proportion);
        
        
        //分别执行平移和缩放动画
        recognizer.view.center = CGPointMake(self.view.center.x + realDistance, self.view.center.y);
        recognizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scal, scal);
        
        CGFloat pro = 0.8 + (proportionOfLeftView - 0.8) * realProportion;
        leftVC.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView * realProportion,
                                         centerOfLeftViewAtBeginning.y - (proportionOfLeftView - 1) * leftVC.view.frame.size.height * realProportion / 2);
        leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);

   
}

//左边的控制器
- (void)leftControllerAppear{

    [mainView addGestureRecognizer:tapGesture];
    distance = self.view.center.x * (fullDistance + proportion / 2);
    [self doAnimationWithScale:proportion withType:@"left"];
}

- (void)homeControllerAppear{
    
    [mainView removeGestureRecognizer:tapGesture];
    distance = 0;
    [self doAnimationWithScale:1 withType:@"home"];
    
}

- (void)rightControllerAppear{
    
    [mainView addGestureRecognizer:tapGesture];
    distance = self.view.center.x * -(fullDistance + proportion / 2);
    [self doAnimationWithScale:proportion withType:@"right"];
}

//处理动画啊
- (void)doAnimationWithScale:(CGFloat)scale withType:(NSString *)type {

    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        mainView.center = CGPointMake(self.view.center.x + distance, self.view.center.y);
        mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);

        if ([type isEqualToString:@"left"]) {
            
            leftVC.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView, leftVC.view.center.y);
            leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportionOfLeftView, proportionOfLeftView);
        }
            
            blackCover.alpha = [type isEqualToString:@"home"]? 1 : 0;

        
        // 为了演示效果，在右侧菜单划出时隐藏漏出的左侧菜单，并无实际意义
        leftVC.view.alpha = [type isEqualToString:@"right"] ? 0 : 1;
        
//        homeVC.view.center = CGPointMake(self.view.center.x + distance, self.view.center.y);
//        homeVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
       
       
    }];
    
}











@end
