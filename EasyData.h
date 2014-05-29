//
//  EasyData.h
//  EasyData
//
//  Created by Benjamin Martin on 5/24/14.
//  Copyright (c) 2014 Benjamin Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EasyData : NSObject <NSFetchedResultsControllerDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

// Insert an object into Core Data for a given class name and data object.
- (void)insertObjectOfType:(id)className withValues:(NSDictionary*)values;

// Retrieve a Core Data object for a given class name and search parameters.
- (id)retrieveObjectOfType:(id)className withAttribute:(id)attribute equalTo:(id)value;

// Update a Core Data object for a given class name and search parameters with newly specified values. Returns the object. Only modifies the object's keys that are passed to the method, not all of the object's keys.
- (id)updateObjectOfType:(id)className withAttribute:(id)attribute equalTo:(id)value withNewValues:(NSDictionary*)values;

// Delete a Core Data object for a given class name and search parameters. Returns the deleted object.
- (id)deleteObjectOfType:(id)className withAttribute:(id)attribute equalTo:(id)value;

// Delete all Core Data entries for a given class.
- (void)deleteAllObjectsOfType:(id)className;

@end
