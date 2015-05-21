#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MeteorClient.h"
#import "ObjectiveDDP.h"
#import <ObjectiveDDP/MeteorClient.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.meteorClient = [[MeteorClient alloc] init];
    
    //Subscribe to Mongo Collection
    //[self.meteorClient addSubscription:@"NAME_OF_COLLETION"];

    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    LoginViewController *loginController = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    loginController.meteor = self.meteorClient;
    ObjectiveDDP *ddp = [[ObjectiveDDP alloc] initWithURLString:@"wss://your-app.herokuapp.com/websocket" delegate:self.meteorClient];
    
    // local testing
    //ObjectiveDDP *ddp = [[ObjectiveDDP alloc] initWithURLString:@"ws://localhost:3000/websocket" delegate:self.meteorClient];
    
    self.meteorClient.ddp = ddp;
    [self.meteorClient.ddp connectWebSocket];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:loginController];
    self.navController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportConnection) name:MeteorClientDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportDisconnection) name:MeteorClientDidDisconnectNotification object:nil];
    
    return YES;
}

- (void)reportConnection {
    NSLog(@"================> connected to server!");
}

- (void)reportDisconnection {
    NSLog(@"================> disconnected from server!");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.meteorClient.ddp connectWebSocket];
}



@end
