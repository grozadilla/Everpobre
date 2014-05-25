//
//  Note.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/1/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "_Note.h"
#import "Notebook.h"

@interface Note : _Note



+(id)noteWithContext: (NSManagedObjectContext *) context inBook:(Notebook *) notebook;

@end
