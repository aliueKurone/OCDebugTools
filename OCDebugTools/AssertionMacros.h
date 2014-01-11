//
//  AssertionMacros.h
//  OCDebugTools
//
//  Created by aliuekurone on 1/4/14.
//  Copyright (c) 2014 aliueKurone. All rights reserved.
//

#ifndef libkz_AssertionMacros_h
#define libkz_AssertionMacros_h

#define AssertOverride [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];

#define KZAssertMainThread() NSAssert([NSThread isMainThread], @"This process expect in main thread")

#endif
