//
//  AppDelegate.m
//  NibLoadedViewSample
//
//  Created by Nicolas on 24/01/13.
//  Copyright (c) 2013 Nicolas Bouilleaud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ColorsViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [ColorsViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

/****************************************************************************/
#pragma mark main

int main(int argc, char *argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
