//
//  _Notebook.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 12/2/12.
//  Copyright (c) 2012 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class _Note;

@interface _Notebook : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSSet *notes;
@end

@interface _Notebook (CoreDataGeneratedAccessors)

- (void)addNotesObject:(_Note *)value;
- (void)removeNotesObject:(_Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
