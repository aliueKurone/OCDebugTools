//
//  LoggingMacros.h
//  OCDebugTools
//
//  Created by aliueKurone on 12/6/13.
//  Copyright (c) 2013 aliueKurone. All rights reserved.
//

#pragma once
#import <Foundation/Foundation.h>

#if DEBUG
#define DebugLog(FORMAT, ...) NSLog(@"%@:%d, %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define DebugLog(...) do {}while(0)
#endif

#define LoggingMethod() DebugLog(@"method %s is called", __PRETTY_FUNCTION__)
#define LoggingScalar(na) DebugLog(@"<scalar variable info> variable name: %s. value:%@.", #na, @(na))
#define LoggingObject(obj) DebugLog(@"<object info> object name: %s. value:%@. class:%@.", #obj, obj, NSStringFromClass([obj class]))

#define LoggingError(obj) DebugLog(@"<Error message> %@", [obj localizedDescription]);
#define LoggingException(ex) DebugLog(@"Exception Name: %@ Reason: %@", [ex name], [ex reason]);

#define Deprecated __attribute__((deprecated("This method is deprecated")))
