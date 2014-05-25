//
//  ATNotesViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/1/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Notebook.h"

@interface ATNotesViewController : CoreDataTableViewController

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) Notebook *notebook;

-(id) initWithNotebook:(Notebook *)notebook
             inContext: (NSManagedObjectContext *)context;

@end
