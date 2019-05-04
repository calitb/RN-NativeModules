//
//  RTCAuthDelegate.swift
//  RNZoomDemo
//
//  Created by Carlos Thurber on 1/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import MobileRTC

@objc
extension RCTZoomManager : MobileRTCAuthDelegate {

  @objc func initialize(_
    key:String, secret:String,
    resolver:@escaping RCTPromiseResolveBlock,
    rejecter:@escaping RCTPromiseRejectBlock
  ) {

    guard let mobileRTC = MobileRTC.shared(),
      let authService = mobileRTC.getAuthService()
    else { return }

    self.promiseResolver = resolver
    self.promiseRejecter = rejecter

    mobileRTC.setMobileRTCDomain("zoom.us")
    authService.delegate = self
    authService.clientKey = key
    authService.clientSecret = secret
    authService.sdkAuth()
  }

  func onMobileRTCAuthReturn(_
    returnValue: MobileRTCAuthError
  ) {

    guard let promiseResolver = self.promiseResolver,
          let promiseRejecter = self.promiseRejecter
    else { return }

    if returnValue == MobileRTCAuthError_Success {
      promiseResolver(nil)
    }
    else {
      let errorCode = Int(returnValue.rawValue)
      promiseRejecter("\(errorCode)", "Failed to initialize", nil)
    }

    self.promiseResolver = nil
    self.promiseRejecter = nil
  }
  
}
