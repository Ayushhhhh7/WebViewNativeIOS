import React from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import NativeWebView from './NativeWebView';

const App = () => {
  return (
    <SafeAreaView style={styles.container}>
      <NativeWebView 
        style={styles.webview}
        url="https://www.google.com"
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  webview: {
    flex: 1,
  },
});

export default App;