import { Alert, NativeModules } from 'react-native';
import config from '../config';

const initialize = async () => {
  try {
    await NativeModules.ZoomManager.initialize(
      config['ZOOM_SDK_KEY'],
      config['ZOOM_SDK_SECRET']
    );
    Alert.alert('Zoom SDK Initialized');
  } catch (error) {
    Alert.alert('Failed Initialization', error.message);
  }
};

const joinMeeting = async (meetingNumber, userName, pwd) => {
  try {
    await NativeModules.ZoomManager.joinMeeting({
      meetingNumber,
      userName,
      pwd
    });
  } catch (error) {
    Alert.alert('Failed joining to room', error.message);
  }
};

module.exports = {
  initialize,
  joinMeeting
};
