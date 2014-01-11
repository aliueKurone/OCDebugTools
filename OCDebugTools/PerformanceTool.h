//
//  PerformanceTool.h
//  OCDebugTools
//
//  Created by aliueKurone on 7/16/13.
//  Copyright (c) 2013 aliueKurone.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 引数のブロック内の処理にかかったCPU時間を計測する。(msec単位)
// なんらかの理由で計測に失敗した場合，NSUIntegerMaxを返却する。
int64_t PTGetTimeToRun(void(^process)(void));

void PTPrintTimeToRun(const char *label, void(^process)(void));
void PTPrintTimeToRunWithRepeat(NSInteger repeatCount, void(^process)(void));

#if TARGET_OS_MAC && !TARGET_IPHONE_SIMULATOR
void PTWriteLeaksToFileAtPath(NSString *path);
void PTPrintMemoryLeaks(void);
#endif