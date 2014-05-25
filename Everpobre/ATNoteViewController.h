//
//  ATNoteViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface ATNoteViewController : UIViewController

@property (strong, nonatomic) Note *model;


@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)viewPhoto:(id)sender;


-(id) initWithModel:(Note *)model;

@end
