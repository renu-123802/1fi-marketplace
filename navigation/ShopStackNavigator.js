import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import ShopScreen from '../screens/ShopScreen';
import ProductDetailScreen from '../screens/marketplace/ProductDetailScreen';
import OrderSummaryScreen from '../screens/marketplace/OrderSummaryScreen';
import { colors } from '../theme/colors';

const Stack = createNativeStackNavigator();

export default function ShopStackNavigator() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: { backgroundColor: colors.surface },
        headerTintColor: colors.textPrimary,
        headerShadowVisible: false,
      }}
    >
      <Stack.Screen
        name="ShopHome"
        component={ShopScreen}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="ProductDetail"
        component={ProductDetailScreen}
        options={{ title: 'Product Details' }}
      />
      <Stack.Screen
        name="OrderSummary"
        component={OrderSummaryScreen}
        options={{ title: 'Order Summary', headerBackVisible: false }}
      />
    </Stack.Navigator>
  );
}
