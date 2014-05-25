//
//  ATNotesViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/1/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "ATNotesViewController.h"
#import "Note.h"
#import "ATNoteViewController.h"

@interface ATNotesViewController ()

@end

@implementation ATNotesViewController



-(id) initWithNotebook:(Notebook *)notebook
             inContext: (NSManagedObjectContext *)context{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        self.context = context;
        self.notebook = notebook;
        self.title = notebook.title;
    }
    
    return self;
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    // Crear la búsqueda (fetchRequest)
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
    [NSSortDescriptor sortDescriptorWithKey:@"creationDate"
                                  ascending:NO]];
    
    request.predicate = [NSPredicate predicateWithFormat:@"notebook = %@", self.notebook];
    
    
    // Crear el fetched results
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:self.context
                                           sectionNameKeyPath:nil cacheName:nil];
    
    
    // lo asigamos a nuestra propiedad
    // y a partir de aquí, ya se encarga el CoreDataTable VC
    self.fetchedResultsController = fetched;
    
    
    // Creamos un  botón
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addNote:)];
    
    // Lo encasquetamos a la barra
    self.navigationItem.rightBarButtonItem = add;
}

-(void) addNote: (id) sender{
    
    Note *newNote = [Note noteWithContext:self.context
                                   inBook:self.notebook];
    NSLog(@"Creada esta nota: %@", newNote);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  TableView Data Source

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"NoteCell";
    
    // Obtengo la Nota (el modelo)
    Note *note = [self.fetchedResultsController
                  objectAtIndexPath:indexPath];
    
    
    // Pillo la vista
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        // La tengo que crear yo a pelo
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
              reuseIdentifier:cellIdentifier];
    }
    
    // Sincronizamos el modelo (la nota) con la vista (la celda)
    cell.textLabel.text = note.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [formatter stringFromDate:note.creationDate];
    cell.imageView.image = note.photo;
    
    return cell;
    
}

#pragma mark - Table View delegate
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Descubrir de qué nota se trata
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear un VC de la nota
    ATNoteViewController *noteVC = [[ATNoteViewController alloc] initWithModel:note];
    
    // Hacer el push
    [self.navigationController pushViewController:noteVC
                                         animated:YES];
    
    
    
}
























@end
