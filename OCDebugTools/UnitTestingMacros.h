//
//  UnitTestingMacros.h
//  OCDebugTools
//
//  Created by aliuekurone on 1/1/14.
//  Copyright (c) 2014 aliueKurone. All rights reserved.
//

#ifndef kz_UnitTestingMacros_h
#define kz_UnitTestingMacros_h

#define UTAssertInstantiation(obj) STAssertNotNil(obj, @"Cannot create instance of %@", [obj class]);

#endif
