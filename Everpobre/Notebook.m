//
//  Notebook.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "Notebook.h"

@implementation Notebook

+(id) notebookWithContext:(NSManagedObjectContext *) context{
    
    Notebook *book = [NSEntityDescription insertNewObjectForEntityForName:@"Notebook"
                 inManagedObjectContext:context];
    
    book.creationDate = [NSDate date];
    return book;
}

@end
