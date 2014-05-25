//
//  ATNotebookViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "ATNotebookViewController.h"
#import "Notebook.h"
#import "ATNotesViewController.h"

@interface ATNotebookViewController ()

@end

@implementation ATNotebookViewController

-(id) initWithContext: (NSManagedObjectContext *) context{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        self.context = context;
        self.title = @"Everpobre";
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Búsqueda y ordenación de los notebooks
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Notebook"];
    
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
    [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    // Fetched Results Controller
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = results;
    
    
    // Crear un botón para añadir nuevas libretas
    UIBarButtonItem *newBook = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNotebook:)];
    
    // Lo añado a la barra
    self.navigationItem.rightBarButtonItem = newBook;
    
}

-(void)addNotebook:(id) sender{
    
    // Creamos un nuevo notebook
    Notebook *book = [Notebook notebookWithContext:self.context];
    NSLog(@"Nueva libreta: %@", book);
    
    // y CoreDataTableViewVC se encarga de refrescarse sola
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguo la libreta
    Notebook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Creo una celda
    static NSString *CellIdentifier = @"NotebookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    // Sincronizo libreta y celda
    cell.textLabel.text = book.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [formatter stringFromDate:book.creationDate];
    
    // Devuelvo la celda
    return cell;
}


#pragma mark - UITableView Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener la libreta
    Notebook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Creamos Controlador de Notas
    ATNotesViewController *notesVC = [[ATNotesViewController alloc]
                                      initWithNotebook:book
                                      inContext:self.context];
    
    // Hacemos el push
    [self.navigationController pushViewController:notesVC
                                         animated:YES];
    
}











@end
