//
//  AppDelegate.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GigyaSDK/Gigya.h>


@interface AppDelegate () <GSAccountsDelegate>

@end

@implementation AppDelegate

static NSString * const kClientId = @"224059159380-llqo0j946bbl3s4rqu35kkolpmhpl07h.apps.googleusercontent.com";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Gigya initWithAPIKey:@"3_hoQxVv5W44L7c5fhBbaDFi9gOaaa2ZpbrBXlmlJoWISEk4D5J47X2iRnWwKnWyMW" application:application launchOptions:launchOptions];
    
    [Gigya setAccountsDelegate:self];
    
    return YES;
}

- (void)accountDidLogin:(GSAccount *)account {
    
}

- (void)accountDidLogout {
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Gigya Logout"
                                       message:@"You have successfully logged out of Gigya."
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    // Logs 'install' and 'app activate' App Events.
    [Gigya handleDidBecomeActive];
    //[FBAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [Gigya handleOpenURL:url application:application sourceApplication:sourceApplication annotation:annotation];
}

@end
