import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Button
} from 'react-native';

export default class ProfileScreen extends React.Component {
    static navigationOptions = {
      title: 'Profile Detail',
    };
    render() {
      const { navigate } = this.props.navigation;
      return (
        <Button
          title="Go to Jane's profile"
          onPress={() =>
            navigate('Profile', { name: 'Jane' })
          }
        />
      );
    }
  }