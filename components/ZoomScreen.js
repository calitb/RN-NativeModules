import React from 'react';
import { View, StyleSheet, Button } from 'react-native';
import LabeledTextInputView from './TextInput';

import ZoomModule from '../lib/ZoomModule';

export default class ZoomScreen extends React.PureComponent {
  state = {
    meetingRoom: '',
    userName: '',
    pwd: ''
  };

  componentDidMount() {
    ZoomModule.initialize();
  }

  onChange = (target: DOMEventTarget<string>) => {
    this.setState({ [target.name]: target.value });
  };

  joinRoom = () => {
    ZoomModule.joinMeeting(
      this.state.meetingRoom,
      this.state.userName,
      this.state.pwd
    );
  };

  render() {
    return (
      <View style={styles.inputsView}>
        <View>
          <LabeledTextInputView
            onChangeText={this.onChange}
            titleText="Meeting Number"
            value={this.state.meetingRoom}
            keyboardType="numeric"
            name="meetingRoom"
          />
          <LabeledTextInputView
            onChangeText={this.onChange}
            titleText="Password"
            value={this.state.pwd}
            name="pwd"
            secureTextEntry={true}
          />
          <LabeledTextInputView
            onChangeText={this.onChange}
            titleText="Display Name"
            value={this.state.userName}
            name="userName"
          />
        </View>
        <View style={styles.buttonView}>
          <Button title="Join Room" onPress={this.joinRoom} />
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  inputsView: {
    padding: 10
  },
  buttonView: {
    marginTop: 10
  }
});
