//
//  _Note.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class _Notebook;

@interface _Note : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) _Notebook *notebook;

@end
