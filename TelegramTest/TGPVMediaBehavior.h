//
//  TGPVMediaBehavior.h
//  Telegram
//
//  Created by keepcoder on 11.11.14.
//  Copyright (c) 2014 keepcoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGPVBehavior.h"
@interface TGPVMediaBehavior : NSObject<TGPVBehavior>

@property (nonatomic,strong) TL_conversation *conversation;


@end
