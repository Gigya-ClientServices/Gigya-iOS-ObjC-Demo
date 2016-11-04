//
//  ViewController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GigyaSDK/Gigya.h>

@interface ViewController ()
@property GSAccount *user;
@end

@implementation ViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (IBAction)logoutButtonAction:(id)sender {
    [Gigya logoutWithCompletionHandler:^(GSResponse *response, NSError *error) {
        self.user = nil;
        if (error) {
            AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [ag alertForView:self title:@"Gigya Logout" message:[@"There was a problem logging out. Gigya returned error code " stringByAppendingFormat:@"%d",response.errorCode] button:@"OK"];
        }
    }];

}

- (IBAction)nativeLoginButtonAction:(id)sender {

    if (![Gigya isSessionValid]){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        //[params setObject:[NSNumber numberWithInt:FBSDKLoginBehaviorNative] forKey:@"facebookLoginBehavior"];
        [Gigya showLoginProvidersDialogOver:self
                                  providers:@[@"facebook", @"twitter", @"googleplus", @"linkedin"]
                                 parameters:params
                          completionHandler:^(GSUser *user, NSError *error) {
                              if (error && error.code != 200001) {
                                  // Handle error
                                  AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                  [ag alertForView:self title:@"Gigya Native Mobile Login" message:[@"There was a problem logging in with Gigya. Gigya returned error code " stringByAppendingFormat:@"%ld", (long)error.code] button:@"OK"];
                              }
                              else {
                                  // Anything?
                              }
                          }
         ];
    } else {
        if (!self.user) {
            // Make Request to get User if it's empty.
            // Step 1 - Create the request and set the parameters
            GSRequest *request = [GSRequest requestForMethod:@"accounts.getAccountInfo"];
            [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
                if (!error) {
                    self.user = (GSAccount *)response;
                }
                else {
                    NSLog(@"Got error on getAccountInfo: %@", error);
                }
            }];
        }
        AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [ag alertForView:self title:@"Alert" message:@"You are already logged in" button:@"OK"];
        
    }
}

- (IBAction)mobileSessionCheckButtonAction:(id)sender {
    __block NSString *msg;
    __block bool isSent = false;
    __block AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    // If there is no Gigya session
    if (![Gigya isSessionValid]) {
        msg = @"You are not logged in.";

    } else {
        isSent = true;
        GSRequest *request = [GSRequest requestForMethod:@"accounts.getAccountInfo"];
        [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
            if (!error) {
                self.user = (GSAccount *)response;
                msg = [@"User is logged in\n" stringByAppendingFormat: @"%@ %@ (%@)", response[@"profile"][@"firstName"], response[@"profile"][@"lastName"], response[@"profile"][@"email"]];

                [ag alertForView:self title:@"Alert" message:msg button:@"OK"];
            }
            else {
                NSLog(@"Got error on getAccountInfo: %@", error);
            }
        }];
    }

    if (!isSent) {
        [ag alertForView:self title:@"Alert" message:msg button:@"OK"];
    }
    
}


- (IBAction)showScreenSet:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"DefaultMobile-RegistrationLogin" forKey:@"screenSet"];
    [Gigya showPluginDialogOver:self plugin:@"accounts.screenSet" parameters:params completionHandler:^(BOOL closedByUser, NSError *error) {
            if (!error) {
            // Login was successful
            }
            else {
                // Handle error
                AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [ag alertForView:self title:@"Error with login" message:error.localizedDescription button:@"OK"];
            }
        }
        delegate:self
    ];
}

- (void)pluginView:(GSPluginView *)pluginView finishedLoadingPluginWithEvent:(NSDictionary *)event {
    NSLog(@"Finished Loading Plugin with event: %@", event);
}

- (void)pluginView:(GSPluginView *)pluginView firedEvent:(NSDictionary *)event {
    NSLog(@"Finished Loading Plugin with event: %@", event);
}

- (void)pluginView:(GSPluginView *)pluginView didFailWithError:(NSError *)error {
    NSLog(@"Plugin View failed with error: %@", error);
}

- (void)accountDidLogin:(GSAccount *)account {
    self.user = account;
    AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [ag alertForView:self title:@"Gigya Session Test" message:@"Gigya Session Test" button:@"OK"];
}

- (void)accountDidLogout {
    self.user = nil;
}


@end
