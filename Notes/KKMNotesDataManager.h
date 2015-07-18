//
//  KKMNotesDataManager.h
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KKMNote;

typedef void (^KKMNotesHandler)(NSArray *results);
typedef void (^KKMNoteHandler)(KKMNote *note);

@interface KKMNotesDataManager : NSObject

- (void)fetchNotesWithHandler:(KKMNotesHandler) handler;

- (void)fetchNoteForNoteID:(NSString *)noteID handler:(KKMNoteHandler) handler;

- (void)upsertNote:(KKMNote *)note;

@end
