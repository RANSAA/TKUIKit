//
//  TKPoint.h
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

#ifndef sphereTagCloud_TKPoint_h
#define sphereTagCloud_TKPoint_h

struct TKPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

typedef struct TKPoint TKPoint;


TKPoint TKPointMake(CGFloat x, CGFloat y, CGFloat z) {
    TKPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}

#endif
