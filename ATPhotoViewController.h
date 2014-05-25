//
//  ATPhotoViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface ATPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong,nonatomic) Note *model;

-(id) initWithModel:(Note *) model;
- (IBAction)dismiss:(id)sender;

- (IBAction)takePicture:(id)sender;
- (IBAction)deletePicture:(id)sender;

@end
