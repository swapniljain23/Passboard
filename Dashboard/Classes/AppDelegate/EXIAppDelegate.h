//
//  EXIAppDelegate.h
//  Dashboard
//
//  Created by Swapnil Jain on 7/30/13.
//

#import <UIKit/UIKit.h>
#import "EXILoginViewController.h"

@interface EXIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
