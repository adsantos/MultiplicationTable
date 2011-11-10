//
//  MultiplicationTableAppDelegate.h
//  MultiplicationTable
//
//  Created by Carlos Vilhena on 30/10/2011.
//  Copyright 2011 Digital Science. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiplicationTableAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *username;

@end
