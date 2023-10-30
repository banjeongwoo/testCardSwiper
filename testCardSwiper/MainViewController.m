//
//  MainViewController.m
//  testCardSwiper
//
//  Created by Sungkil Moon on 2023/10/30.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    
    UIViewController *vc = [storyboard instantiateInitialViewController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [navigationController.navigationBar setHidden:YES];
    
    [self.view addSubview:navigationController.view];
    
    [navigationController didMoveToParentViewController:self];
    
    _navigationController = navigationController;
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
 
    UIViewController *vcMain = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    NSMutableArray* viewControllers = [NSMutableArray array];

    [viewControllers addObject:vcMain];

    [self.navigationController setViewControllers:[NSArray arrayWithArray:viewControllers] animated:NO];
}

- (void)viewDidLayoutSubviews {
    _navigationController.view.frame = self.view.bounds;
    [_navigationController.view setNeedsLayout];
}


@end
