//
//  KKMNotesDataManager.m
//  Notes
//
//  Created by Mohan, Kishore Kumar on 7/17/15.
//  Copyright (c) 2015 kmohan. All rights reserved.
//

#import "KKMNotesDataManager.h"
#import "KKMNote.h"

@implementation KKMNotesDataManager

-(void)fetchNotesWithHandler:(KKMNotesHandler) handler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //background thread
        NSMutableArray *notesArray = [NSMutableArray new];
        NSString *directory = [self dataStorePath];
        NSArray *directoryFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:NULL];
        for (NSString *fileName in directoryFiles)
        {
            if ([fileName hasPrefix:@"Note"] == NO)
                continue;
            
            NSString *fileNameWithFullPath = [self dataStorePathForFileName:fileName];
            KKMNote *note = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithFullPath];
            [notesArray addObject:note];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //main thread
            handler(notesArray);
        });
    });
}

- (void)upsertNote:(KKMNote *)note handler:(KKMNoteSaveHandler) handler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        note.modifiedDate = [NSDate new];
        note.noteID = [NSString stringWithFormat:@"Note%f", [NSDate timeIntervalSinceReferenceDate] * 1000];
        
        NSString *path = [self dataStorePathForFileName:note.noteID];
        BOOL result = [NSKeyedArchiver archiveRootObject:note toFile:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(result);
        });
    });
}

- (void)deleteNote:(KKMNote *)note
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *path = [self dataStorePathForFileName:note.noteID];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    });
}

#pragma mark - Helper

- (NSString *)dataStorePath
{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = directories[0];
    return directory;
}

- (NSString *)dataStorePathForFileName:(NSString *)fileName
{
    NSString *directory = [self dataStorePath];
    NSString *result = [directory stringByAppendingPathComponent:fileName];
    return result;
}

@end
