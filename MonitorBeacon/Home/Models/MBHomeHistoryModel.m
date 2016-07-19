//
//  MBHomeHistoryModel.m
//  MonitorBeacon
//
//  Created by schiller on 16/7/19.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "MBHomeHistoryModel.h"

static const NSUInteger maxIntervalCount = 10;
static NSString *const kHistoryIdentifier = @"kHistoryIdentifier";

@interface MBHomeHistoryModel ()
@property (nonatomic, strong) NSMutableArray<MBHomeBeaconModel *> *beaconHistoryArray;
@end

@implementation MBHomeHistoryModel

+ (MBHomeHistoryModel *)shareHistory
{
    static dispatch_once_t onceToken;
    static MBHomeHistoryModel *_shareObject = nil;
    dispatch_once(&onceToken, ^{
        _shareObject = [[super allocWithZone:NULL] init];
    });
    
    return _shareObject;
}

+ (id) allocWithZone:(struct _NSZone *)zone{
    return [self shareHistory];
}

+ (id) copyWithZone:(struct _NSZone *)zone{
    return [self shareHistory];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self readFromCache];
    }
    return self;
}

- (void)addHistoryInterval:(MBHomeBeaconModel *)model
{
    NSInteger index = [self uniqueCompare:model];
    if (index == 0) {
        return;
    }
    if (index != NSNotFound) {
        [self.beaconHistoryArray removeObjectAtIndex:index];
    }else if (self.beaconHistoryArray.count > maxIntervalCount) {
        [self.beaconHistoryArray removeLastObject];
    }
    MBHomeBeaconModel *cacheModel = [MBHomeBeaconModel new];
    cacheModel.uuid = model.uuid;
    cacheModel.major = model.major;
    cacheModel.minor = model.minor;
    [self.beaconHistoryArray insertObject:cacheModel atIndex:0];
    [self writeToFile];
}

- (NSInteger)uniqueCompare:(MBHomeBeaconModel *)model
{
    __block NSInteger index = NSNotFound;
    [self.beaconHistory enumerateObjectsUsingBlock:^(MBHomeBeaconModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.uuid isEqualToString:model.uuid] && [obj.major isEqualToString:model.major] && [obj.minor isEqualToString:model.minor]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

- (NSArray *)beaconHistory
{
    return [NSArray arrayWithArray:self.beaconHistoryArray];
}

- (void)clearHistory
{
    NSString *filePath = [[MBHomeHistoryModel applicationCachesDirectory] stringByAppendingPathComponent:kHistoryIdentifier];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

- (void)writeToFile
{
    NSString *filePath = [[MBHomeHistoryModel applicationCachesDirectory] stringByAppendingPathComponent:kHistoryIdentifier];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.beaconHistoryArray];
    [data writeToFile:filePath atomically:YES];
}

- (void)readFromCache
{
    NSString *filePath = [[MBHomeHistoryModel applicationCachesDirectory] stringByAppendingPathComponent:kHistoryIdentifier];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath isDirectory:nil]) {
        self.beaconHistoryArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }else {
        self.beaconHistoryArray = [NSMutableArray array];
    }
}

+ (NSString *)applicationCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

@end
