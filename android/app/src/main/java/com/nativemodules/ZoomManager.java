package com.nativemodules;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import us.zoom.sdk.JoinMeetingOptions;
import us.zoom.sdk.JoinMeetingParams;
import us.zoom.sdk.MeetingService;
import us.zoom.sdk.MeetingServiceListener;
import us.zoom.sdk.MeetingStatus;
import us.zoom.sdk.ZoomError;
import us.zoom.sdk.ZoomSDK;
import us.zoom.sdk.ZoomSDKInitializeListener;
import us.zoom.sdk.MeetingViewsOptions;

public class ZoomManager extends ReactContextBaseJavaModule implements ZoomSDKInitializeListener, MeetingServiceListener {

    private Promise mPromise;
    private final JoinMeetingOptions joinMeetingOptions;

    public ZoomManager(ReactApplicationContext reactContext) {
        super(reactContext);

        joinMeetingOptions = new JoinMeetingOptions();
        joinMeetingOptions.no_disconnect_audio = true;
        joinMeetingOptions.meeting_views_options = this.joinMeetingOptions.meeting_views_options
                | MeetingViewsOptions.NO_TEXT_MEETING_ID
                | MeetingViewsOptions.NO_TEXT_PASSWORD
                | MeetingViewsOptions.NO_BUTTON_SHARE
                | MeetingViewsOptions.NO_BUTTON_PARTICIPANTS
                | MeetingViewsOptions.NO_BUTTON_MORE;
    }

    @Override
    public String getName() {
        return "RCTZoomManager";
    }

    // Initialize the SDK

    @ReactMethod
    public void initialize(final String sdkKey, final String sdkSecret, final Promise promise) {
        this.getCurrentActivity().runOnUiThread(new Runnable() {
            public void run() {
                initSDK(sdkKey, sdkSecret, "zoom.us", promise);
            }
        });
    }

    private void initSDK(String sdkKey, String sdkSecret, String sdkDomain, Promise promise) {
        mPromise = promise;

        ZoomSDK zoomSDK = ZoomSDK.getInstance();
        zoomSDK.initialize(this.getCurrentActivity(), sdkKey, sdkSecret, sdkDomain, this);
    }

    // ZoomSDKInitializeListener

    @Override
    public void onZoomSDKInitializeResult(int errorCode, int internalErrorCode) {
        if (errorCode == ZoomError.ZOOM_ERROR_SUCCESS) {
            mPromise.resolve("Success!");
            mPromise = null;

        } else {
            mPromise.reject(""+errorCode, "Failed to initialize");
            mPromise = null;
        }
    }

    // Join Meeting

    @ReactMethod
    public void joinMeeting(ReadableMap options, Promise promise) {
        mPromise = promise;

        JoinMeetingParams meetingParams = new JoinMeetingParams();
        meetingParams.meetingNo = options.getString("meetingNumber");
        meetingParams.displayName = options.getString("userName");
        meetingParams.password = options.getString("pwd");

        ZoomSDK zoomSDK = ZoomSDK.getInstance();
        MeetingService meetingService = zoomSDK.getMeetingService();
        meetingService.addListener(this);
        meetingService.joinMeetingWithParams(this.getCurrentActivity(), meetingParams, this.joinMeetingOptions);
    }

    // MeetingServiceListener

    @Override
    public void onMeetingStatusChanged(MeetingStatus meetingStatus, int errorCode, int internalErrorCode) {

        if (mPromise == null) {
            return;
        }

        if (meetingStatus == MeetingStatus.MEETING_STATUS_INMEETING) {
            mPromise.resolve("Success!");
            mPromise = null;
        }
        else if (meetingStatus == MeetingStatus.MEETING_STATUS_FAILED) {
            mPromise.reject(""+errorCode, "Meeting Failed");
            mPromise = null;
        }
    }

}
