//
//  LoginViewController.m
//  Demo2ObjectiveDDP
//
//  Created by Victor Carreño on 7/10/14.
//  Copyright (c) 2014 Victor Carreño. All rights reserved.
//

#import "LoginViewController.h"
#import <ObjectiveDDP/MeteorClient.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.meteor addObserver:self
                  forKeyPath:@"websocketReady"
                     options:NSKeyValueObservingOptionNew
                     context:nil];
}

-(void)viewDidLoad{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    CreateAccountViewController *createAccountViewController = [sb instantiateViewControllerWithIdentifier:@"CreateAccountViewController"];
    
    createAccountViewController.meteor = self.meteor;
    
    NSLog(@"Meteor Log");
    
}

#pragma mark <NSKeyValueObserving>

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"websocketReady"] && self.meteor.websocketReady) {
        self.connectionStatusText.text = @"Connected to Todo Server";
        //UIImage *image = [UIImage imageNamed: @"green_light.png"];
        //[self.connectionStatusLight setImage:image];
    }
}

#pragma mark UI Actions

- (IBAction)didTapLoginButton:(id)sender {
    if (!self.meteor.websocketReady) {
        UIAlertView *notConnectedAlert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                                    message:@"Can't find the Todo server, try again"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
        [notConnectedAlert show];
        return;
    }
    
    [self.meteor logonWithEmail:self.email.text password:self.password.text responseCallback:^(NSDictionary *response, NSError *error) {
        if (error) {
            [self handleFailedAuth:error];
            return;
        }
        [self handleSuccessfulAuth];
    }];
}

#pragma mark - Internal

- (void)handleSuccessfulAuth {

    NSLog(@"Handle Succes");
   
}

- (void)handleFailedAuth:(NSError *)error {
    
     [[[UIAlertView alloc] initWithTitle:@"Meteor Todos" message:[error description] delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil] show];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"createAccountSegue"]){
        
        CreateAccountViewController *createUserViewController = [segue destinationViewController];
        createUserViewController.meteor = self.meteor;
        
    }
    
}

@end
