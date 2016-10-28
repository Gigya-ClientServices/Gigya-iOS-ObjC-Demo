//
//  PublishActionController.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "AppDelegate.h"
#import "PublishActionController.h"
#import <GigyaSDK/Gigya.h>

@interface PublishActionController ()

@property (weak, nonatomic) IBOutlet UITextView *shareText;

@end

@implementation PublishActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)publishButtonAction:(id)sender {
    
    if (![Gigya isSessionValid]) {
        AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [ag alertForView:self title:@"Alert" message:@"You must be logged in to do that!" button:@"OK"];
    } else {
        [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
            if ([[session lastLoginProvider] isEqual: @"facebook"]){
                [Gigya requestNewFacebookPublishPermissions:@"publish_actions" viewController:self responseHandler:^(BOOL granted, NSError * _Nullable error, NSArray * _Nullable declinedPermissions) {
                    if (!granted) {
                        // Handle error
                        AppDelegate *ag = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [ag alertForView:self title:@"Gigya Publish User Action" message:error.description button:@"OK"];
                        return;
                    }
                }];
            }
        }];
        
        NSMutableDictionary *userAction = [NSMutableDictionary dictionary];
        [userAction setObject:@"Gigya iOS SDK Demos" forKey:@"title"];
        [userAction setObject:self.shareText.text forKey:@"description"];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userAction
                                                           options:0
                                                             error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        GSRequest *request = [GSRequest requestForMethod:@"socialize.publishUserAction"];
        [request.parameters setObject:jsonString forKey:@"userAction"];
        [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
            if (!error) {
                NSLog(@"Success");
                // Success! Use the response object.
            }
            else {
                NSLog(@"error");
                // Check the error code according to the GSErrorCode enum, and handle it.
            }
        }];
    }
}

@end
