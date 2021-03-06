//
//  CoreDataAppDelegate.h
//  CoreData
//
//  Created by Tony Cerrato on 3/13/14.
//  Copyright (c) 2014 Tony Cerrato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(NSArray*)getAllPhoneBookRecords;  // tony added as a way to get all records from core data

@end
