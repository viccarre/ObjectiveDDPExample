//
//  CreateAccountViewController.h
//  Demo2ObjectiveDDP
//
//  Created by Victor Carreño on 7/16/14.
//  Copyright (c) 2014 Victor Carreño. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateAccountViewController.h"

@class MeteorClient;

@interface CreateAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) MeteorClient *meteor;

- (IBAction)createAccount:(id)sender;

@end
