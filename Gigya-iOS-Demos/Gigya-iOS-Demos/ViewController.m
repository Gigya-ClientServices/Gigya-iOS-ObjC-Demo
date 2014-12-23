//
//  ViewController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon on 12/22/14.
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
        UIAlertView *alert;
        if (!error) {
            alert = [[UIAlertView alloc] initWithTitle:@"Gigya Logout"
                                                            message:@"You have successfully logged out of Gigya."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        } else {
            alert = [[UIAlertView alloc] initWithTitle:@"Gigya Logout"
                                               message:[@"There was a problem logging out. Gigya returned error code " stringByAppendingFormat:@"%d",response.errorCode]
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        }
        [alert show];
    }];

}

@end
