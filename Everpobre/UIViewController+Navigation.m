//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/1/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UIViewController *) wrappedInNavigation{
    
    // Creo un navigation
    UINavigationController *navVC = [[UINavigationController alloc] init];
    [navVC pushViewController:self
                     animated:NO];
    
    return navVC;
}


@end
