import React from 'react';
import { requireNativeComponent, findNodeHandle, NativeModules, View, Text, TouchableOpacity } from 'react-native';

const NativeWebView = requireNativeComponent('MyWebView');

class EnhancedWebView extends React.Component {
  webViewRef = React.createRef();

  goBack = () => {
    NativeModules.MyWebView.goBack(findNodeHandle(this.webViewRef.current));
  };

  goForward = () => {
    NativeModules.MyWebView.goForward(findNodeHandle(this.webViewRef.current));
  };

  render() {
    return (
      <View style={{ flex: 1 }}>
     
        <NativeWebView
          ref={this.webViewRef}
          {...this.props}
          style={{ flex: 1 }}
        />
           <View style={{ flexDirection: 'row', padding: 10, backgroundColor: '#fff' }}>
          <TouchableOpacity 
            style={{ padding: 8, marginRight: 10, backgroundColor: '#ddd',borderRadius:10 }}
            onPress={this.goBack}>
            <Text>{"< Back"}</Text>
          </TouchableOpacity>
          <TouchableOpacity 
            style={{ padding: 8, backgroundColor: '#ddd',borderRadius:10 }}
            onPress={this.goForward}>
            <Text>{"Forward >"}</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

export default EnhancedWebView;