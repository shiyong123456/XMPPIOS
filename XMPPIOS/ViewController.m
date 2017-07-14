//
//  ViewController.m
//  XMPPIOS
//
//  Created by Mac Pro on 13-8-21.
//  Copyright (c) 2013年 Dawn_wdf. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
//#import "FriendsListViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - my methods
- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(BOOL)allInformationReady{
    if (self.hostTextField.text && self.portTextField.text && self.myNameTextField.text && self.passwordTextField.text) {
        [[[self appDelegate] xmppStream] setHostName:self.hostTextField.text];
        [[[self appDelegate] xmppStream] setHostPort:self.portTextField.text.integerValue];
        [[NSUserDefaults standardUserDefaults]setObject:self.hostTextField.text forKey:kHost];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@@%@/XMPPIOS",self.myNameTextField.text,self.hostTextField.text] forKey:kMyJID];
        [[NSUserDefaults standardUserDefaults]setObject:self.passwordTextField.text forKey:kPS];
        return YES;
    }
    [[self appDelegate] showAlertView:@"信息不完整"];
    return NO;
}
- (void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender
{
    if (![[[self appDelegate] xmppStream] isConnected]) {
        [[self appDelegate] showAlertView:@"not connected yet!!"];
    }
//    if ([segue.destinationViewController isKindOfClass:[FriendsListViewController class]]) {
//        FriendsListViewController *friends = segue.destinationViewController;
//        friends.xmppStream = self.xmppStream;
//    }
}
#pragma mark - IBAction
- (IBAction)connectToOpenfire:(id)sender {
    if (![self allInformationReady]) {
        return;
    }
//    [[self appDelegate]setIsRegistration:NO];
    [[self appDelegate]myConnect];
}

- (IBAction)registrationInBand:(id)sender {
    if (![self allInformationReady]) {
        return;
    }
    if ([[[self appDelegate] xmppStream] isConnected] && [[[self appDelegate]xmppStream] supportsInBandRegistration]) {
        NSError *error ;
        [[self appDelegate].xmppStream setMyJID:[XMPPJID jidWithUser:self.myNameTextField.text domain:self.hostTextField.text resource:@"XMPPIOS"]];
//        [[self appDelegate]setIsRegistration:YES];
        if (![[self appDelegate].xmppStream registerWithPassword:self.passwordTextField.text error:&error]) {
            [[self appDelegate] showAlertView:[NSString stringWithFormat:@"%@",error.description]];
        }
    }
}
@end
