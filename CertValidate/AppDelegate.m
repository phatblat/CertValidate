//
//  AppDelegate.m
//  CertValidate
//
//  Created by Ben Chatelain on 4/10/14.
//  Copyright (c) 2014 @phatblat. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - UIApplicationDelegate Protocol

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self checkForUnpatchedSystemVersion];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods

- (void)checkForUnpatchedSystemVersion
{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;

    NSLog(@"systemVersion: %@", systemVersion);

    NSInteger majorVersion = 0;
    NSInteger minorVersion = 0;
    NSInteger patchVersion = 0;

    NSArray *versions = [systemVersion componentsSeparatedByString:@"."];
    if ([versions count]) {
        majorVersion = [versions[0] integerValue];
        if ([versions count] >= 2) {
            minorVersion = [versions[1] integerValue];
            if ([versions count] >= 3) {
                patchVersion = [versions[2] integerValue];
            }
        }
    }

    // 7.1+ is patched
    if (majorVersion == 7 &&
        minorVersion >= 1) {
        return;
    }

    // 7.0.6 is patched
    if (majorVersion == 7 &&
        minorVersion == 0 &&
        patchVersion  < 6) {
        return;
    }

    // 6.1.6 is patched
    if (majorVersion == 6 &&
        minorVersion == 1 &&
        patchVersion >= 6) {
        return;
    }

    // Assume <5.x are not affected by #goto fail
    if (majorVersion <= 5) {
        return;
    }

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"System Vulnerable"
                                                        message:@"Your device is running a version of iOS known to be vulnerable to the SSL #gotofail flaw. Please upgrade ASAP"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
@end
