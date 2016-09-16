//
//  JRSimplePopoverController.m
//
//  Copyright 2016 Go Travel Un Limited
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "JRSimplePopoverController.h"
#import "JRSimplePopoverBackgroundView.h"
#import "UIImage+JRUIImage.h"
#import "JRColorScheme.h"

@implementation JRSimplePopoverController
{
    BOOL withNavigation;
    BOOL sizeAdapted;
}

- (JRSimplePopoverController*)initWithContentViewControllerWithNavigation:(UIViewController*) vc {
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [nc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    CGRect frame = vc.view.frame;
    nc.view.frame = frame;
    [nc.navigationBar setBackgroundImage:[UIImage imageWithColor:[JRColorScheme popoverBackgroundColor]] forBarMetrics:UIBarMetricsDefault];
    
    self = [super initWithContentViewController:nc];
    if (self) {
        withNavigation = YES;
        sizeAdapted = NO;
        self.popoverContentSize = nc.view.frame.size;
        [self setPopoverBackgroundViewClass:[JRSimplePopoverBackgroundView class]];
    }
    return self;
}

- (JRSimplePopoverController*)initWithContentViewController:(UIViewController*)vc {
    self = [super initWithContentViewController:vc];
    if (self) {
        withNavigation = NO;
        self.popoverContentSize = vc.view.frame.size;
        [self setPopoverBackgroundViewClass:[JRSimplePopoverBackgroundView class]];
    }
    return self;
}

- (void)setPopoverContentSize:(CGSize)size animated:(BOOL)animated manual:(BOOL)manual {
    if (manual) {
        sizeAdapted = NO;
    }
    [self setPopoverContentSize:size animated:animated];
}

- (void)setPopoverContentSize:(CGSize)size animated:(BOOL)animated {
    if (withNavigation && !sizeAdapted) {
        size.height += 37;
        sizeAdapted = YES;
    }
    [super setPopoverContentSize:size animated:animated];
}

@end
