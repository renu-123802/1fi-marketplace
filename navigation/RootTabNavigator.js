import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';
import ShopStackNavigator from './ShopStackNavigator';
import PlaceholderScreen from '../screens/PlaceholderScreen';
import { colors } from '../theme/colors';

const Tab = createBottomTabNavigator();

const ICONS = {
  Home: 'home-outline',
  Shop: 'storefront-outline',
  'EMI Dues': 'receipt-outline',
  Limit: 'trending-up-outline',
  Profile: 'person-outline',
};

export default function RootTabNavigator() {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.inactiveTab,
        tabBarIcon: ({ color, size }) => (
          <Ionicons name={ICONS[route.name]} size={size} color={color} />
        ),
        tabBarStyle: {
          borderTopWidth: 0,
          elevation: 8,
          height: 64,
          paddingBottom: 8,
          paddingTop: 6,
        },
        tabBarLabelStyle: { fontSize: 11, fontWeight: '600' },
      })}
    >
      <Tab.Screen name="Home" component={PlaceholderScreen} initialParams={{ label: 'Home' }} />
      <Tab.Screen name="Shop" component={ShopStackNavigator} />
      <Tab.Screen name="EMI Dues" component={PlaceholderScreen} initialParams={{ label: 'EMI Dues' }} />
      <Tab.Screen name="Limit" component={PlaceholderScreen} initialParams={{ label: 'Limit' }} />
      <Tab.Screen name="Profile" component={PlaceholderScreen} initialParams={{ label: 'Profile' }} />
    </Tab.Navigator>
  );
}
