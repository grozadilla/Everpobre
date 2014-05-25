//
//  ATCoreDataStack.h
//  Everpobre
//
//  Created by user22769 on 25/05/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

//importar entidades

@interface ATCoreDataStack : NSObject

//definicion minima - metodos generales
//Punto de entrada al singleton. Único punto de acceso

+(ATCoreDataStack *)sharedManager;

@property (strong,nonatomic) NSManagedObjectContext *context;

@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;

@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end
