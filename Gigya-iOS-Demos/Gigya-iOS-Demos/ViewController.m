//
//  ViewController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "ViewController.h"
#import <GigyaSDK/Gigya.h>

@interface ViewController ()

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

- (IBAction)logoutButtonAction:(id)sender {
    [Gigya logoutWithCompletionHandler:^(GSResponse *response, NSError *error) {
        if (error) {
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Gigya Logout"
                                         message:[@"There was a problem logging out. Gigya returned error code " stringByAppendingFormat:@"%d",response.errorCode]
                                         delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            [alert show];
        }
    }];

}

- (IBAction)nativeLoginButtonAction:(id)sender {
    if (![Gigya session]){
        [Gigya showLoginProvidersDialogOver:self
                                  providers:@[@"facebook", @"twitter", @"googleplus"]
                                 parameters:nil
                          completionHandler:^(GSUser *user, NSError *error) {
                              if (error && error.code != 200001) {
                                  UIAlertView *alert;
                                  // Handle error
                                  alert = [[UIAlertView alloc] initWithTitle:@"Gigya Native Mobile Login"
                                                                     message:[@"There was a problem logging in with Gigya. Gigya returned error code " stringByAppendingFormat:@"%ld", (long)error.code]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil
                                           ];
                                  [alert show];
                              }
                          }
         ];
    } else {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                           message:@"You are already logged in!"
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)mobileSessionCheckButtonAction:(id)sender {
    // If there is no Gigya session
    if (![Gigya session]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Gigya Session Test"
                                     message:@"You are not logged in"
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        [alert show];
    } else {
        GSRequest *request = [GSRequest requestForMethod:@"accounts.getAccountInfo"];
        [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
            if (!error) {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Gigya Session Test"
                                                   message:[@"User is logged in\n" stringByAppendingFormat: @"%@ %@ (%@)", response[@"profile"][@"firstName"], response[@"profile"][@"lastName"], response[@"profile"][@"email"]]
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                [alert show];
            }
            else {
                NSLog(@"Got error on getUserInfo: %@", error);
            }
        }];
    }
}

@end
