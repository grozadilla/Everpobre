//
//  ATCoreDataStack.m
//  Everpobre
//
//  Created by user22769 on 25/05/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "ATCoreDataStack.h"

/*incluir en l .h*/

/*
 +(ATCoreDataStack *)sharedManager;
 
 @property (strong,nonatomic) NSManagedObjectContext *context;
 
 @property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;
 
 @property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
*/


@implementation ATCoreDataStack

static ATCoreDataStack *coreDataHelper;

+ (ATCoreDataStack *) sharedManager{
    if (!coreDataHelper) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            coreDataHelper = [[ATCoreDataStack alloc]init];
        });
        
    }
    
    return coreDataHelper;
}

#pragma mark - Coredata Stack

//Metodo para obtener el path del document -- recordad que aqui tenemos el fichero con los datos y modelo persisitido.
-(NSURL *) documentsDirectory{
    return [[[ NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

- (NSString*)productName{
    NSDictionary * dic = [[NSBundle mainBundle]infoDictionary];
    return [dic objectForKey:@"CFBundleDisplayName"];
    
}

#pragma mark - data stack (persistent, context, etc)

-(NSManagedObjectContext *)ctx{
    if (_context == nil) {
        NSPersistentStoreCoordinator * coordinador = [self persistentStoreCoordinator];
        if (coordinador != nil) {
            _context = [NSManagedObjectContext new];
            [_context setPersistentStoreCoordinator:coordinador];
        }
    
    
    }
    return _context;
}


-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if(_persistentStoreCoordinator ==nil){
        NSString * productName = [self productName]; //usa constante o define
        NSURL *storeUrl = [[self documentsDirectory]URLByAppendingPathComponent:productName];
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
        
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption: @YES};
        
        BOOL success = !![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
        
        NSAssert(success, @"%@, %@", error, [error userInfo]);
    }
    return _persistentStoreCoordinator;
}

-(NSManagedObjectModel * )managedObjectModel{
    if(_managedObjectModel == nil){
        NSString * productame = [self productName];
        NSURL * modelURL = [[NSBundle mainBundle]URLForResource:productame withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}


-(void)saveContext{
    NSError *error;
    if (_context) {
        if ([_context hasChanges]&& ![_context save:&error]) {
            NSAssert(false, @"Error en la operacion de guardado en el contexto %@ %@", error, [error userInfo]);
        }
    }
}












@end
