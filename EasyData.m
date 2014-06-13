//
//  EasyData.m
//  EasyData
//
//  Created by Benjamin Martin on 5/24/14.
//  Copyright (c) 2014 Benjamin Martin. All rights reserved.
//

#import "EasyData.h"
#import "AppDelegate.h"

typedef enum {insert, retrieve} type;

@implementation EasyData

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Insertion

- (void)insertObjectOfType:(id)className withValues:(NSDictionary*)values {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([className class]) inManagedObjectContext:context];
    
    for (NSString *key in [values allKeys]) {
        [entity setValue:[values objectForKey:key] forKey:key];
    }
    [self saveContext];
}

#pragma mark - Retrieval

- (id)retrieveObjectOfType:(id)className withAttribute:(NSString*)attribute equalTo:(id)value {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([className class])];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ == %@", attribute, value];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    return [[context executeFetchRequest:request error:&error] objectAtIndex:0];
}

#pragma mark - Updating

- (id)updateObjectOfType:(id)className withAttribute:(NSString*)attribute equalTo:(id)value withNewValues:(NSDictionary*)values {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([className class])];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ == %@", attribute, value];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    id object = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    
    for (NSString* key in [values allKeys]) {
        object[key] = [values objectForKey:key];
    }
    
    [self saveContext];
    return object;
}

#pragma mark - Deletion (singular)

- (id)deleteObjectOfType:(id)className withAttribute:(NSString*)attribute equalTo:(id)value {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([className class])];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ == %@", attribute, value];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    id object = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    
    [context deleteObject:object];
    [self saveContext];
    
    return object;
    
    [self deleteAllObjectsOfType:self];
}

#pragma mark - Deletion (plural)

- (void)deleteAllObjectsOfType:(id)className {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([className class])];
    
    NSError *error;
    for (id object in [context executeFetchRequest:request error:&error]) {
        [context deleteObject:object];
    }
    [self saveContext];
}

#pragma mark - Core Data boilerplate

- (BOOL)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            return NO;
        }
    }
    return YES;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
