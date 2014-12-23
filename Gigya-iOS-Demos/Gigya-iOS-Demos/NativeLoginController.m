//
//  NativeLoginController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "NativeLoginController.h"
#import <GigyaSDK/Gigya.h>

@interface NativeLoginController ()

@end

@implementation NativeLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [Gigya showLoginProvidersDialogOver:self
                              providers:@[@"facebook", @"twitter", @"googleplus"]
                             parameters:nil
                      completionHandler:^(GSUser *user, NSError *error) {
                          UIAlertView *alert;
                          if (!error) {
                              // Login was successful
                              [self.navigationController popToRootViewControllerAnimated:TRUE];
                              [self.navigationController popToRootViewControllerAnimated:TRUE];
                          }
                          else {
                              // Handle error
                              alert = [[UIAlertView alloc] initWithTitle:@"Gigya Native Mobile Login"
                                                                 message:[@"There was a problem logging in with Gigya. Gigya returned error code " stringByAppendingFormat:@"%ld", (long)error.code]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                          }
                      }];
}	

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
