//
//  ZoomManager.m
//  RNZoomDemo
//
//  Created by Carlos Thurber on 1/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RCTZoomManager, NSObject)

RCT_EXTERN_METHOD(
                  initialize:(NSString*)key
                  secret:(NSString*)secret
                  resolver:(RCTPromiseResolveBlock)resolver
                  rejecter:(RCTPromiseRejectBlock)rejecter
                  )

RCT_EXTERN_METHOD(
                  joinMeeting:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolver
                  rejecter:(RCTPromiseRejectBlock)rejecter
                  )

@end
