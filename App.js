import React from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import ZoomScreen from "./components/ZoomScreen"

export default class App extends React.PureComponent {
  render() {
    return (
      <SafeAreaView style={styles.container}>
        <ZoomScreen />
      </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});
