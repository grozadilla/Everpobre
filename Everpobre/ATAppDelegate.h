//
//  ATAppDelegate.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/1/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
