//
//  ATNotebookViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface ATNotebookViewController : CoreDataTableViewController

@property (strong,nonatomic) NSManagedObjectContext *context;

-(id) initWithContext: (NSManagedObjectContext *) context;


@end
