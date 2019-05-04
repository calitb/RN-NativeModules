//
//  ZoomManager.swift
//  RNZoomDemo
//
//  Created by Carlos Thurber on 1/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

@objc (RCTZoomManager)
class RCTZoomManager: NSObject {

  @objc var methodQueue = DispatchQueue.main

  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }

  var promiseResolver : RCTPromiseResolveBlock?
  var promiseRejecter : RCTPromiseRejectBlock?

}
