//
//  Note.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/1/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "Note.h"


@implementation Note


+(id)noteWithContext: (NSManagedObjectContext *)context
              inBook:(Notebook *) notebook{
    
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:context];
    note.notebook = notebook;
    note.creationDate = [NSDate date];
    return note;
}
@end
