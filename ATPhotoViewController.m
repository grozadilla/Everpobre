//
//  ATPhotoViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "ATPhotoViewController.h"

@interface ATPhotoViewController ()

@end

@implementation ATPhotoViewController

-(id) initWithModel:(Note *) model{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        self.model = model;
    }

    
return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // modelo -> vista
    self.photoView.image = self.model.photo;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // vista -> modelo
    self.model.photo = self.photoView.image;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender {
    
    // Creamos un Picker
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // Lo configuramos
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    picker.delegate = self;
    
    // Los mostramos modalmente
    [self presentViewController:picker
                       animated:YES
                     completion:nil];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
 
    UIImage *photo = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // Lo guardo en el modelo, que es lo corresto de verdad
    // verdadera.
    // Para sincronizar modelo con vista, ya está
    // viewWillAppear
    
    self.model.photo = photo;
    
    // quito de enmedio al picker
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)deletePicture:(id)sender {
    
    // quitarla del modelo
    self.model.photo = nil;
    
    // quitarla de la vista
    CGRect oldBounds = self.photoView.bounds;
    
    [UIView animateWithDuration:0.8
                          delay:0
                        options:0
                     animations:^{
                         self.photoView.bounds = CGRectZero;
                         self.photoView.alpha = 0;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_PI);
                         
                     } completion:^(BOOL finished) {
                         self.photoView.image = nil;
                         self.photoView.bounds = oldBounds;
                         self.photoView.alpha = 1;
                         self.photoView.transform = CGAffineTransformIdentity;
                     }];
    
    
    
    
}

- (IBAction)dismiss:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
    
}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController
     willShowViewController:(UIViewController *)viewController
                   animated:(BOOL)animated{
    
    navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

@end
