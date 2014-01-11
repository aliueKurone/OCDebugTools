//
//  PerformanceTool.m
//  OCDebugTools
//
//  Created by aliueKurone on 7/16/13.
//  Copyright (c) 2013 aliueKurone.com. All rights reserved.
//

#import "PerformanceTool.h"
#import <mach/mach_time.h>
#import "LoggingMacros.h"


int64_t PTGetTimeToRun(void(^process)(void))
{
#if DEBUG
    int64_t start = mach_absolute_time();
    
    mach_timebase_info_data_t info;
    if (KERN_SUCCESS == mach_timebase_info (&info) ) {
        DebugLog(@"scale factor : %u / %u", info.numer, info.denom);
    }
    else {
        NSLog(@"mach_timebase_info failed");
        return NSUIntegerMax;
    }
    
    process();
    
    int64_t end = mach_absolute_time ();
    int64_t elapsed = end - start;
    
    int64_t nanos = elapsed * info.numer / info.denom;
    
    return (nanos / NSEC_PER_MSEC);
#else
    process();
    return NSUIntegerMax;
#endif
}


void PTPrintTimeToRun(const char *label, void(^process)(void))
{
#if DEBUG
    NSLog(@"Start measuring time of \"%s\" process", label);
    int64_t millis = PTGetTimeToRun(process);
    if (NSUIntegerMax != millis)
        NSLog(@"finished \"%s\",elapsed time was %lld milliseconds\n",label, millis);
    else
        NSLog(@"faild to measure time in \"%s\" process", label);
#else
    process();
#endif
}


void PTPrintTimeToRunWithRepeat(NSInteger repeatCount, void(^process)(void))
{
#if DEBUG
    @autoreleasepool {
        NSMutableArray *times = [NSMutableArray arrayWithCapacity:repeatCount];
        while (repeatCount--) {
            int64_t time = PTGetTimeToRun(process);
            if (NSUIntegerMax != time)
                [times addObject:@(time)];
        }
        
        NSNumber *max = [times valueForKeyPath:@"@max.self"];
        NSNumber *min = [times valueForKeyPath:@"@min.self"];
        NSNumber *avg = [times valueForKeyPath:@"@avg.self"];
        NSLog(@"process performed at %ld count. max:%@msec, min:%@msec, avg:%.1fmsec", [times count], max, min, [avg doubleValue]);
    }
#else
    process();
#endif
}


#if TARGET_OS_MAC && !TARGET_IPHONE_SIMULATOR

void PTWriteLeaksToFileAtPath(NSString *path)
{
#if DEBUG
    NSFileHandle *output = [NSFileHandle fileHandleForWritingAtPath:path];
    
    if(output == nil)
        output = [NSFileHandle fileHandleWithStandardError];
    assert(output);
    
    NSTask *leaksTask = [NSTask new];
    [leaksTask setLaunchPath:@"/usr/bin/leaks"];
    [leaksTask setArguments:@[[NSString stringWithFormat:@"%u", getpid()]]];
    
    [leaksTask setStandardOutput:output];
    [leaksTask setStandardError:output];
    
    NSLog( @"Writing leaks to %@", ( path != nil ? path : @"stderr" ) );
    [leaksTask launch];
    [leaksTask waitUntilExit];
#endif
}


void PTPrintMemoryLeaks(void)
{
#if DEBUG
    PTWriteLeaksToFileAtPath(nil);
#endif
}

#endif