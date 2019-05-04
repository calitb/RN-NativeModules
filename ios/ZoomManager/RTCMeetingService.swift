//
//  RTCMeetingServiceDelegate.swift
//  RNZoomDemo
//
//  Created by Carlos Thurber on 1/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import MobileRTC

@objc
extension RCTZoomManager : MobileRTCMeetingServiceDelegate {

  @objc func joinMeeting(_
    options:[String:Any],
    resolver:@escaping RCTPromiseResolveBlock,
    rejecter:@escaping RCTPromiseRejectBlock
  ) {

    guard let mobileRTC = MobileRTC.shared(),
      let meetingService = mobileRTC.getMeetingService(),
      let meetingSettings = mobileRTC.getMeetingSettings()
    else { return }

    self.promiseResolver = resolver
    self.promiseRejecter = rejecter

    meetingSettings.meetingTitleHidden = true
    meetingSettings.meetingShareHidden = true
    meetingSettings.meetingParticipantHidden = true
    meetingSettings.meetingMoreHidden = true
    meetingSettings.setAutoConnectInternetAudio(true)

    meetingService.delegate = self
    let paramsDict : [AnyHashable : Any] = [
      kMeetingParam_Username:options["userName"] ?? "",
      kMeetingParam_MeetingNumber:options["meetingNumber"] ?? "",
      kMeetingParam_MeetingPassword:options["pwd"] ?? ""
    ]

    let ret = meetingService.joinMeeting(with: paramsDict)
    NSLog("onJoinaMeeting ret: \(ret)")
  }

  func onMeetingError(_
    error: MobileRTCMeetError,
    message: String!
  ) {
    NSLog("onMeetingError: \(error), message: \(message ?? "")")

    guard let promiseResolver = self.promiseResolver,
          let promiseRejecter = self.promiseRejecter
    else { return }

    if error == MobileRTCMeetError_Success {
      promiseResolver(nil)
    }
    else {
      let errorCode = Int(error.rawValue)
      promiseRejecter("\(errorCode)", message, nil)
    }

    self.promiseResolver = nil
    self.promiseRejecter = nil
  }

}
