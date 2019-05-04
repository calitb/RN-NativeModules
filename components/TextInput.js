import React from 'react';
import {
  Text,
  TextInput,
  View,
  TouchableWithoutFeedback,
  Platform,
  StyleSheet
} from 'react-native';

export default class LabeledTextInputView extends React.PureComponent {
  state = {
    text: this.props.value
  };

  onChangeText = (text: string) => {
    this.setState({ text }, () => {
      this.props.onChangeText({ name: this.props.name, value: text });
    });
  };

  onPress = () => {
    if (this.input) {
      this.input.focus();
    }
  };

  render() {
    return (
      <View pointerEvents="auto" style={{ marginTop: 10 }}>
        <TouchableWithoutFeedback onPress={this.onPress}>
          <View style={styles.container}>
            <Text style={styles.header}>{this.props.titleText}</Text>
            <TextInput
              ref={input => {
                this.input = input;
              }}
              style={styles.input}
              placeholder={this.props.placeholder}
              placeholderTextColor="#8E8E93"
              value={this.state.text}
              onChangeText={this.onChangeText}
              secureTextEntry={this.props.secureTextEntry}
              keyboardType={this.props.keyboardType}
              autoFocus={this.props.autoFocus}
            />
          </View>
        </TouchableWithoutFeedback>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#e9e6eb',
    borderTopLeftRadius: 0,
    borderBottomLeftRadius: 0,
    borderTopRightRadius: 8,
    borderBottomRightRadius: 8,
    paddingTop: 8,
    paddingLeft: 24,
    paddingRight: 24,
    height: 64
  },
  header: {
    fontSize: 14,
    lineHeight: 24,
    color: '#8E8E93',
    marginBottom: 4
  },
  input: {
    marginLeft: Platform.OS === 'android' ? -4 : 0,
    marginTop: Platform.OS === 'android' ? -12 : 0,
    fontSize: 16,
    color: '#59595C'
  }
});
