//
//  AppDelegate.h
//  New_Relic_Challenge
//
//  Created by Enders, Eric on 10/6/17.
//  Copyright © 2017 Enders, Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

