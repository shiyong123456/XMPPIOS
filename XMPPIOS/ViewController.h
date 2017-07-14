//
//  ViewController.h
//  XMPPIOS
//
//  Created by Mac Pro on 13-8-21.
//  Copyright (c) 2013年 Dawn_wdf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *hostTextField;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UITextField *myNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)connectToOpenfire:(id)sender;
- (IBAction)registrationInBand:(id)sender;
@end
