import { AppRegistry } from 'react-native';
//import App from './App';
import { StackNavigator,TabNavigator,TabBarBottom } from 'react-navigation';
//import HomeScreen from './home';
//import ProfileScreen from './profile';
//import Ionicons from 'react-native-vector-icons/Ionicons';
import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Button,
  Image
} from 'react-native';
//import Icon from 'react-native-vector-icons/Ionicons';
//const myIcon = (<Icon name="albums" size={30} color="#900" />)

// const App = TabNavigator(
//   {
//     Home: { screen: HomeScreen },
//     Profile: { screen: ProfileScreen },
//   }
// );

// AppRegistry.registerComponent('JSNote', () => App);

//import { TabNavigator, StackNavigator } from 'react-navigation';

class DetailsScreen extends React.Component {
  render() {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>Details!</Text>
      </View>
    );
  }
}

class HomeScreen extends React.Component {
  render() {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        { /* other code from before here */ }
        <Button
          title="Go to Details"
          onPress={() => this.props.navigation.navigate('Details')}
        />
      </View>
    );
  }
}

class SettingsScreen extends React.Component {
  render() {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        { /* other code from before here */ }
        <Button
          title="Go to Details"
          onPress={() => this.props.navigation.navigate('Details')}
        />
      </View>
    );
  }
}

const HomeStack = StackNavigator({
  Home: { screen: HomeScreen },
  Details: { screen: DetailsScreen },
});

const SettingsStack = StackNavigator({
  Settings: { screen: SettingsScreen },
  Details: { screen: DetailsScreen },
});

const App = TabNavigator(
  {
    Home: { 
      screen: HomeStack,
      navigationOptions:({navigation}) => ({
        tabBarLabel:"苹果",
        tabBarIcon: ({ focused, tintColor }) => (
          // <Image
          //     source={focused ? require('./res/imgs/home.png') : require('./res/imgs/home.png') }
          //     style={{ width: 25, height: 25 }}
          // />
          <View style={{width:25, height:25, backgroundColor:"red"}} />
)
      })
     },
    Settings: { screen: SettingsStack },
  },
  {
    tabBarOptions: {
      activeTintColor: 'rgb(255, 255, 255)',
      inactiveTintColor: 'rgba(255, 255, 255, 0.5)',
      showIcon: true,
      style: {
        backgroundColor: 'rgb(65, 62, 60)',
        height: 57
      },
    },
    tabBarComponent: TabBarBottom,
    tabBarPosition: 'bottom',
    swipeEnabled: false,
    animationEnabled: true,
   
    
    
}
);

AppRegistry.registerComponent('JSNote', () => App);