import React from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import EnhancedWebView from './NativeWebView';

const App = () => {
  return (
    <SafeAreaView style={styles.container}>
      <EnhancedWebView url="https://reactnative.dev" />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;
