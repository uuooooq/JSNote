import { AppRegistry } from 'react-native';
//import App from './App';
import { StackNavigator } from 'react-navigation';
import HomeScreen from './home';
import ProfileScreen from './profile';

const App = StackNavigator({
    Home: { screen: HomeScreen },
    Profile: { screen: ProfileScreen },
  });

AppRegistry.registerComponent('JSNote', () => App);
