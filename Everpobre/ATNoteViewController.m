//
//  ATNoteViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "ATNoteViewController.h"
#import "ATPhotoViewController.h"

@interface ATNoteViewController ()

-(IBAction)hideKeyboard:(id)sender;

@end

@implementation ATNoteViewController

-(id) initWithModel:(Note *)model{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        self.model = model;
        self.title = model.title;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Sincronizamos la vista con el modelo
    self.textView.text = self.model.text;
    self.titleView.text = self.model.title;
    
    // Añadimos bordes y cantos redondeados al
    // textView
    self.textView.layer.borderColor = [[UIColor colorWithWhite:0.5 alpha:0.5] CGColor];
    self.textView.layer.borderWidth = 1.5;
    self.textView.layer.cornerRadius = 8.0;
    
    // Alta en notificaciones del teclado
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(keyboardWillAppear:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(keyboardWillDisappear:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
    
    
    
}

-(void)keyboardWillAppear:(NSNotification *) notification{
    
    NSLog(@"Hola teclado: %@", notification);
    // Sacar el frame final del teclado de la notification
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Calculamos la nueva altura
    CGFloat newHeight = self.textView.frame.size.height - keyboardRect.size.height + self.textView.frame.origin.y - 10;
    
    // Creamos un nuevo frame
    CGRect newRect = CGRectMake(self.textView.frame.origin.x,
                                self.textView.frame.origin.y,
                                self.textView.frame.size.width,
                                newHeight);
    
    // Tiempo que va a durar la animación del teclado
    NSTimeInterval seconds = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    
    [UIView animateWithDuration:seconds
                     animations:^{
                         
                         // Cambiamos el frame de textView
                         self.textView.frame = newRect;
                          
                     }];
    
}

-(void)keyboardWillDisappear:(NSNotification *) notification{
    NSLog(@"Adiós teclado: %@", notification);
    
    // Tiempo que va a durar la animación del teclado
    NSTimeInterval seconds = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    // El frame original era...
    CGRect oldFrame = CGRectMake(self.textView.frame.origin.x,
                                 self.textView.frame.origin.y,
                                 self.textView.frame.size.width,
                                 300);
    
    // Dejamos la altura de la textView en su valor original
    [UIView animateWithDuration:seconds
                     animations:^{
                         self.textView.frame = oldFrame;
                     }];
    
}



-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizamos el modelo con la vista
    self.model.title = self.titleView.text;
    self.model.text = self.textView.text;
    
    // De baja de las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
-(IBAction)hideKeyboard:(id)sender{
    
    // Quitar el foco a tó quisqui
    [self.view endEditing:YES];
    
    
}
- (IBAction)viewPhoto:(id)sender {
    
    // Creamos el PhotoVC
    ATPhotoViewController *photoVC = [[ATPhotoViewController alloc] initWithModel:self.model];
    
    // Lo configuramos
    photoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Lo mostramos modalmente
    [self presentViewController:photoVC
                       animated:YES
                     completion:nil];
    
    
}
@end
