//
//  AppDelegate.m
//  ExpenseReport
//
//  Created by Group10 on 11/18/15.
//  Copyright © 2015 UHD. All rights reserved.
//

#import "AppDelegate.h"
#import "MainScreenViewController.h"
#import "ExpensesCollection.h"
#import "IncomeCollection.h"

@interface AppDelegate ()

@end

NSString *const DefaultIncomeSourcePrefsKey = @"DefaultIncomeSource";
NSString *const DefaultIncomeAmountPrefsKey = @"DefaultIncomeAmount";
NSString *const DefaulExpenseTypePrefsKey = @"DefaultExpenseType";
NSString *const DefaultExpenseAmountPrefsKey = @"DefaultExpenseAmount";

@implementation AppDelegate

+(void)initialize {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *factorySettings = @{ DefaultIncomeSourcePrefsKey: @"Apple",
                                       DefaultIncomeAmountPrefsKey: @100,
                                       DefaulExpenseTypePrefsKey: @"Movie",
                                       DefaultExpenseAmountPrefsKey: @10};
    
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Create a MonthsViewController
    MainScreenViewController *msvc = [[ MainScreenViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:msvc];
    
    // Place MonthsViewController's table view in the window hierarchy
    self.window.rootViewController = navController;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[ExpensesCollection sharedCollection] saveChanges];
    if (success)
    {
        NSLog(@" Saved all of the expenses");
    }
    else
    {
        NSLog(@" Could not save any of the expenses");
    }
    success = [[IncomeCollection sharedCollection] saveChanges];
    if (success)
    {
        NSLog(@" Saved all of the income items");
    }
    else
    {
        NSLog(@" Could not save any of the income items");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
