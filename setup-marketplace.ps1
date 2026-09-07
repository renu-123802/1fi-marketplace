# Auto-generated setup script for 1Fi Marketplace
# Run this INSIDE your Expo project folder (after npx create-expo-app)
Write-Host 'Creating folders...'
New-Item -ItemType Directory -Force -Path "api" | Out-Null
New-Item -ItemType Directory -Force -Path "components" | Out-Null
New-Item -ItemType Directory -Force -Path "data" | Out-Null
New-Item -ItemType Directory -Force -Path "navigation" | Out-Null
New-Item -ItemType Directory -Force -Path "screens" | Out-Null
New-Item -ItemType Directory -Force -Path "screens/marketplace" | Out-Null
New-Item -ItemType Directory -Force -Path "theme" | Out-Null
Write-Host 'Writing files...'
@'
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import RootTabNavigator from './navigation/RootTabNavigator';

export default function App() {
  return (
    <SafeAreaProvider>
      <StatusBar style="dark" />
      <NavigationContainer>
        <RootTabNavigator />
      </NavigationContainer>
    </SafeAreaProvider>
  );
}

'@ | Out-File -FilePath "App.js" -Encoding utf8 -NoNewline
@'
import { PRODUCTS } from '../data/products';
import { generateEMIPlans } from '../data/emiPlans';

// This module simulates a real backend API using Promises + setTimeout.
// Swapping this for a real fetch() call later requires no changes to any screen/component,
// since screens only depend on this module's exported function signatures.

const NETWORK_DELAY_MS = 700;

// Set to a value between 0 and 1 to simulate random failures during dev/testing, e.g. 0.15
const SIMULATED_FAILURE_RATE = 0;

function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function maybeFail() {
  if (Math.random() < SIMULATED_FAILURE_RATE) {
    throw new Error('Network request failed. Please try again.');
  }
}

export async function fetchProducts() {
  await delay(NETWORK_DELAY_MS);
  maybeFail();
  return PRODUCTS;
}

export async function fetchProductById(productId) {
  await delay(NETWORK_DELAY_MS);
  maybeFail();
  const product = PRODUCTS.find((p) => p.id === productId);
  if (!product) {
    throw new Error('Product not found.');
  }
  return product;
}

export async function fetchEMIPlans(productId, price) {
  await delay(NETWORK_DELAY_MS - 200);
  maybeFail();
  return generateEMIPlans(price);
}

export default {
  fetchProducts,
  fetchProductById,
  fetchEMIPlans,
};

'@ | Out-File -FilePath "api/marketplaceApi.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { TouchableOpacity, Text, StyleSheet, ActivityIndicator } from 'react-native';
import { colors } from '../theme/colors';
import { typography, radius, spacing } from '../theme/typography';

export default function PrimaryButton({ title, onPress, disabled, loading, style }) {
  return (
    <TouchableOpacity
      style={[styles.button, disabled && styles.buttonDisabled, style]}
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.85}
    >
      {loading ? (
        <ActivityIndicator color={colors.textOnPrimary} />
      ) : (
        <Text style={styles.label}>{title}</Text>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  button: {
    backgroundColor: colors.primary,
    paddingVertical: spacing.md,
    borderRadius: radius.pill,
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonDisabled: {
    opacity: 0.5,
  },
  label: {
    color: colors.textOnPrimary,
    ...typography.bodyBold,
    fontSize: 16,
  },
});

'@ | Out-File -FilePath "components/PrimaryButton.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ScrollView } from 'react-native';
import { colors } from '../theme/colors';
import { typography, radius, spacing } from '../theme/typography';

// Generic segmented control. Used on the Shop page for
// Top Brands / Nearby Stores / 1Fi Marketplace.
export default function SegmentedTabs({ tabs, activeTab, onChange }) {
  return (
    <ScrollView
      horizontal
      showsHorizontalScrollIndicator={false}
      contentContainerStyle={styles.wrapper}
    >
      {tabs.map((tab) => {
        const isActive = tab.key === activeTab;
        return (
          <TouchableOpacity
            key={tab.key}
            style={[styles.tab, isActive && styles.tabActive]}
            onPress={() => onChange(tab.key)}
            activeOpacity={0.8}
          >
            <Text style={[styles.tabLabel, isActive && styles.tabLabelActive]}>
              {tab.label}
            </Text>
            {isActive && <View style={styles.indicator} />}
          </TouchableOpacity>
        );
      })}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  wrapper: {
    backgroundColor: colors.primaryLight,
    borderRadius: radius.pill,
    padding: 4,
    marginHorizontal: spacing.md,
  },
  tab: {
    paddingVertical: 10,
    paddingHorizontal: spacing.md + 4,
    borderRadius: radius.pill,
    alignItems: 'center',
  },
  tabActive: {
    backgroundColor: colors.surface,
  },
  tabLabel: {
    ...typography.bodyBold,
    color: colors.textSecondary,
    fontSize: 14,
  },
  tabLabelActive: {
    color: colors.primary,
  },
  indicator: {
    marginTop: 3,
    width: 20,
    height: 2,
    borderRadius: 2,
    backgroundColor: colors.primary,
  },
});

'@ | Out-File -FilePath "components/SegmentedTabs.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, Image, TouchableOpacity, StyleSheet } from 'react-native';
import { colors } from '../theme/colors';
import { typography, radius, spacing } from '../theme/typography';

export default function ProductCard({ product, onPress }) {
  return (
    <TouchableOpacity style={styles.card} onPress={onPress} activeOpacity={0.85}>
      <Image source={{ uri: product.image }} style={styles.image} />
      <View style={styles.info}>
        <Text style={styles.brand} numberOfLines={1}>
          {product.brand}
        </Text>
        <Text style={styles.name} numberOfLines={2}>
          {product.name}
        </Text>
        <Text style={styles.price}>
          ₹{product.basePrice.toLocaleString('en-IN')}
        </Text>
        <View style={styles.badge}>
          <Text style={styles.badgeText}>NO-COST EMI</Text>
        </View>
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    flex: 1,
    backgroundColor: colors.surface,
    borderRadius: radius.md,
    margin: spacing.sm / 2,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: colors.border,
  },
  image: {
    width: '100%',
    aspectRatio: 1,
    backgroundColor: colors.surfaceMuted,
  },
  info: {
    padding: spacing.sm + 2,
  },
  brand: {
    ...typography.caption,
    color: colors.textSecondary,
    textTransform: 'uppercase',
  },
  name: {
    ...typography.bodyBold,
    color: colors.textPrimary,
    marginTop: 2,
    minHeight: 36,
  },
  price: {
    ...typography.price,
    fontSize: 15,
    color: colors.textPrimary,
    marginTop: 4,
  },
  badge: {
    marginTop: 6,
    alignSelf: 'flex-start',
    backgroundColor: colors.primaryLight,
    paddingHorizontal: 8,
    paddingVertical: 3,
    borderRadius: radius.pill,
  },
  badgeText: {
    fontSize: 10,
    fontWeight: '700',
    color: colors.primary,
    letterSpacing: 0.5,
  },
});

'@ | Out-File -FilePath "components/ProductCard.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ScrollView } from 'react-native';
import { colors } from '../theme/colors';
import { typography, radius, spacing } from '../theme/typography';

export default function VariantSelector({ variants, selectedId, onSelect }) {
  return (
    <View>
      <Text style={styles.sectionTitle}>Select variant</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        {variants.map((variant) => {
          const isSelected = variant.id === selectedId;
          return (
            <TouchableOpacity
              key={variant.id}
              style={[styles.chip, isSelected && styles.chipSelected]}
              onPress={() => onSelect(variant.id)}
              activeOpacity={0.8}
            >
              <Text style={[styles.chipText, isSelected && styles.chipTextSelected]}>
                {variant.label}
              </Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  sectionTitle: {
    ...typography.h3,
    color: colors.textPrimary,
    marginBottom: spacing.sm,
  },
  chip: {
    borderWidth: 1,
    borderColor: colors.border,
    borderRadius: radius.pill,
    paddingVertical: 8,
    paddingHorizontal: 14,
    marginRight: spacing.sm,
    backgroundColor: colors.surface,
  },
  chipSelected: {
    backgroundColor: colors.primary,
    borderColor: colors.primary,
  },
  chipText: {
    ...typography.body,
    color: colors.textPrimary,
    fontSize: 13,
  },
  chipTextSelected: {
    color: colors.textOnPrimary,
    fontWeight: '600',
  },
});

'@ | Out-File -FilePath "components/VariantSelector.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { colors } from '../theme/colors';
import { typography, radius, spacing } from '../theme/typography';

export default function EMIPlanCard({ plan, isSelected, onSelect }) {
  return (
    <TouchableOpacity
      style={[styles.card, isSelected && styles.cardSelected]}
      onPress={() => onSelect(plan.id)}
      activeOpacity={0.85}
    >
      <View style={styles.radioOuter}>
        {isSelected && <View style={styles.radioInner} />}
      </View>

      <View style={styles.details}>
        <Text style={styles.tenure}>{plan.tenureMonths} months</Text>
        <Text style={styles.subtext}>
          ₹{plan.monthlyAmount.toLocaleString('en-IN')}/month · 0% interest
        </Text>
      </View>

      {isSelected && (
        <Ionicons name="checkmark-circle" size={20} color={colors.primary} />
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderWidth: 1,
    borderColor: colors.border,
    borderRadius: radius.md,
    padding: spacing.md,
    marginBottom: spacing.sm,
  },
  cardSelected: {
    borderColor: colors.primary,
    backgroundColor: colors.primaryLight,
  },
  radioOuter: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 2,
    borderColor: colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: spacing.sm + 2,
  },
  radioInner: {
    width: 10,
    height: 10,
    borderRadius: 5,
    backgroundColor: colors.primary,
  },
  details: {
    flex: 1,
  },
  tenure: {
    ...typography.bodyBold,
    color: colors.textPrimary,
  },
  subtext: {
    ...typography.body,
    fontSize: 13,
    color: colors.textSecondary,
    marginTop: 2,
  },
});

'@ | Out-File -FilePath "components/EMIPlanCard.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, ActivityIndicator, StyleSheet } from 'react-native';
import { colors } from '../theme/colors';
import { typography, spacing } from '../theme/typography';

export function LoadingState({ label = 'Loading...' }) {
  return (
    <View style={styles.container}>
      <ActivityIndicator size="large" color={colors.primary} />
      <Text style={styles.label}>{label}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    paddingVertical: spacing.xl,
    alignItems: 'center',
    justifyContent: 'center',
  },
  label: {
    ...typography.body,
    color: colors.textSecondary,
    marginTop: spacing.sm,
  },
});

export default LoadingState;

'@ | Out-File -FilePath "components/LoadingState.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { colors } from '../theme/colors';
import { typography, spacing, radius } from '../theme/typography';

export function ErrorState({ message = 'Something went wrong.', onRetry }) {
  return (
    <View style={styles.container}>
      <Ionicons name="alert-circle-outline" size={40} color={colors.error} />
      <Text style={styles.message}>{message}</Text>
      {onRetry && (
        <TouchableOpacity style={styles.retryButton} onPress={onRetry}>
          <Text style={styles.retryText}>Try again</Text>
        </TouchableOpacity>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    paddingVertical: spacing.xl,
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: spacing.lg,
  },
  message: {
    ...typography.body,
    color: colors.textSecondary,
    textAlign: 'center',
    marginTop: spacing.sm,
    marginBottom: spacing.md,
  },
  retryButton: {
    backgroundColor: colors.errorBg,
    paddingVertical: spacing.sm,
    paddingHorizontal: spacing.lg,
    borderRadius: radius.pill,
  },
  retryText: {
    ...typography.bodyBold,
    color: colors.error,
    fontSize: 14,
  },
});

export default ErrorState;

'@ | Out-File -FilePath "components/ErrorState.js" -Encoding utf8 -NoNewline
@'
// Mock product dataset. In production this would come from a real backend.
// Kept separate from UI components so it can later be swapped for a real API call.

export const PRODUCTS = [
  {
    id: 'p1',
    name: 'iPhone 15',
    brand: 'Apple Premium Reseller',
    category: 'Electronics',
    basePrice: 79900,
    image: 'https://picsum.photos/seed/iphone15/600/600',
    description:
      'Apple iPhone 15 with A16 Bionic chip, 48MP main camera, and USB-C. Available with no-cost EMI backed by your mutual fund portfolio.',
    variants: [
      { id: 'v1', label: '128GB · Black', priceDelta: 0 },
      { id: 'v2', label: '256GB · Black', priceDelta: 10000 },
      { id: 'v3', label: '128GB · Blue', priceDelta: 0 },
    ],
  },
  {
    id: 'p2',
    name: 'MacBook Air M2',
    brand: 'Apple Premium Reseller',
    category: 'Electronics',
    basePrice: 114900,
    image: 'https://picsum.photos/seed/macbookair/600/600',
    description:
      '13-inch MacBook Air with M2 chip, all-day battery life, and a fanless design. Backed by your mutual funds, no credit score required.',
    variants: [
      { id: 'v1', label: '8GB/256GB · Midnight', priceDelta: 0 },
      { id: 'v2', label: '16GB/512GB · Starlight', priceDelta: 25000 },
    ],
  },
  {
    id: 'p3',
    name: 'Solitaire Diamond Ring',
    brand: 'CaratLane',
    category: 'Jewellery',
    basePrice: 45000,
    image: 'https://picsum.photos/seed/caratlane/600/600',
    description:
      'Handcrafted solitaire ring in 18k gold with a certified diamond. Pay in easy no-cost EMIs.',
    variants: [
      { id: 'v1', label: 'Size 6', priceDelta: 0 },
      { id: 'v2', label: 'Size 7', priceDelta: 0 },
    ],
  },
  {
    id: 'p4',
    name: 'Domestic Flight Voucher',
    brand: 'Air India',
    category: 'Travel',
    basePrice: 12000,
    image: 'https://picsum.photos/seed/airindia/600/600',
    description:
      'Flexible domestic flight voucher valid on all Air India routes for 12 months. No-cost EMI up to 18 months.',
    variants: [{ id: 'v1', label: 'Economy', priceDelta: 0 }],
  },
  {
    id: 'p5',
    name: 'Kerala Backwaters Stay',
    brand: 'CGH Earth',
    category: 'Travel',
    basePrice: 32000,
    image: 'https://picsum.photos/seed/cghearth/600/600',
    description:
      '3 nights / 4 days stay at a CGH Earth backwater resort, breakfast included. No-cost EMI up to 24 months.',
    variants: [
      { id: 'v1', label: 'Standard Room', priceDelta: 0 },
      { id: 'v2', label: 'Lake View Room', priceDelta: 6000 },
    ],
  },
  {
    id: 'p6',
    name: 'Royal Enfield Classic 350',
    brand: 'RE Store',
    category: 'Automobile',
    basePrice: 210000,
    image: 'https://picsum.photos/seed/royalenfield/600/600',
    description:
      'Royal Enfield Classic 350 with signature thump. Own it today, pay later backed by your investments.',
    variants: [
      { id: 'v1', label: 'Stealth Black', priceDelta: 0 },
      { id: 'v2', label: 'Chrome Red', priceDelta: 8000 },
    ],
  },
];

export default PRODUCTS;

'@ | Out-File -FilePath "data/products.js" -Encoding utf8 -NoNewline
@'
// Generates EMI plan options for a given price.
// All plans are "no-cost" (0% interest) to match 1Fi's "No-cost EMIs" positioning,
// mirroring the "No-cost EMIs upto X months" copy seen on the real Shop page.

const TENURE_OPTIONS_MONTHS = [3, 6, 12, 18, 24];

export function generateEMIPlans(price, maxTenureMonths = 24) {
  return TENURE_OPTIONS_MONTHS.filter((m) => m <= maxTenureMonths).map(
    (tenure) => {
      const monthlyAmount = Math.round(price / tenure);
      return {
        id: `emi-${tenure}`,
        tenureMonths: tenure,
        interestRate: 0,
        monthlyAmount,
        totalPayable: price,
        label: `${tenure} months`,
      };
    }
  );
}

export default generateEMIPlans;

'@ | Out-File -FilePath "data/emiPlans.js" -Encoding utf8 -NoNewline
@'
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

'@ | Out-File -FilePath "navigation/ShopStackNavigator.js" -Encoding utf8 -NoNewline
@'
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

'@ | Out-File -FilePath "navigation/RootTabNavigator.js" -Encoding utf8 -NoNewline
@'
import React, { useState } from 'react';
import { View, Text, StyleSheet, StatusBar } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { SafeAreaView } from 'react-native-safe-area-context';
import SegmentedTabs from '../components/SegmentedTabs';
import MarketplaceSection from './marketplace/MarketplaceSection';
import { colors } from '../theme/colors';
import { typography, spacing, radius } from '../theme/typography';

const TABS = [
  { key: 'topBrands', label: 'Top Brands' },
  { key: 'nearbyStores', label: 'Nearby Stores' },
  { key: 'marketplace', label: '1Fi Marketplace' },
];

export default function ShopScreen({ navigation }) {
  const [activeTab, setActiveTab] = useState('marketplace');

  return (
    <View style={styles.root}>
      <StatusBar barStyle="light-content" />
      <LinearGradient
        colors={[colors.gradientStart, colors.gradientEnd]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.header}
      >
        <SafeAreaView edges={['top']}>
          <View style={styles.badge}>
            <Text style={styles.badgeText}>✦ NO-COST EMIS</Text>
          </View>
          <Text style={styles.headline}>
            Shop today,{'\n'}
            <Text style={styles.headlineItalic}>Pay later</Text> using{'\n'}
            Mutual funds.
          </Text>
          <Text style={styles.subtext}>
            No credit score required. No interest.{'\n'}Backed by your investments.
          </Text>
        </SafeAreaView>
      </LinearGradient>

      <View style={styles.tabsWrapper}>
        <SegmentedTabs tabs={TABS} activeTab={activeTab} onChange={setActiveTab} />
      </View>

      <View style={styles.content}>
        {activeTab === 'topBrands' && <PlaceholderTab label="Top Brands" />}
        {activeTab === 'nearbyStores' && <PlaceholderTab label="Nearby Stores" />}
        {activeTab === 'marketplace' && (
          <MarketplaceSection navigation={navigation} />
        )}
      </View>
    </View>
  );
}

// Intentionally blank per assignment scope — Top Brands & Nearby Stores
// require no implementation, but the placeholder keeps navigation state consistent.
function PlaceholderTab({ label }) {
  return (
    <View style={styles.placeholder}>
      <Text style={styles.placeholderText}>{label} — coming soon</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.background },
  header: {
    paddingHorizontal: spacing.md,
    paddingBottom: spacing.xl + spacing.md,
    borderBottomLeftRadius: radius.lg,
    borderBottomRightRadius: radius.lg,
  },
  badge: {
    alignSelf: 'flex-start',
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.5)',
    borderRadius: radius.pill,
    paddingVertical: 4,
    paddingHorizontal: 10,
    marginTop: spacing.sm,
  },
  badgeText: {
    color: colors.textOnPrimary,
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 0.5,
  },
  headline: {
    ...typography.h1,
    color: colors.textOnPrimary,
    marginTop: spacing.md,
    lineHeight: 32,
  },
  headlineItalic: {
    fontStyle: 'italic',
  },
  subtext: {
    ...typography.body,
    color: 'rgba(255,255,255,0.85)',
    marginTop: spacing.sm,
    fontSize: 13,
  },
  tabsWrapper: {
    marginTop: -spacing.lg,
  },
  content: {
    flex: 1,
    marginTop: spacing.md,
  },
  placeholder: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  placeholderText: {
    ...typography.body,
    color: colors.textSecondary,
  },
});

'@ | Out-File -FilePath "screens/ShopScreen.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, StyleSheet, SafeAreaView } from 'react-native';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';

// Generic placeholder used for tabs outside this assignment's scope
// (Home, EMI Dues, Limit, Profile). Kept minimal but on-brand.
export default function PlaceholderScreen({ route }) {
  const label = route?.params?.label || route?.name || 'Screen';
  return (
    <SafeAreaView style={styles.root}>
      <View style={styles.center}>
        <Text style={styles.text}>{label} — coming soon</Text>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.background },
  center: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  text: { ...typography.body, color: colors.textSecondary },
});

'@ | Out-File -FilePath "screens/PlaceholderScreen.js" -Encoding utf8 -NoNewline
@'
import React, { useEffect, useState, useCallback, useMemo } from 'react';
import { View, Text, TextInput, FlatList, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import ProductCard from '../../components/ProductCard';
import LoadingState from '../../components/LoadingState';
import ErrorState from '../../components/ErrorState';
import { fetchProducts } from '../../api/marketplaceApi';
import { colors } from '../../theme/colors';
import { typography, spacing, radius } from '../../theme/typography';

export default function MarketplaceSection({ navigation }) {
  const [products, setProducts] = useState([]);
  const [status, setStatus] = useState('loading'); // 'loading' | 'success' | 'error'
  const [errorMessage, setErrorMessage] = useState('');
  const [query, setQuery] = useState('');

  const loadProducts = useCallback(() => {
    setStatus('loading');
    fetchProducts()
      .then((data) => {
        setProducts(data);
        setStatus('success');
      })
      .catch((err) => {
        setErrorMessage(err.message || 'Failed to load products.');
        setStatus('error');
      });
  }, []);

  useEffect(() => {
    loadProducts();
  }, [loadProducts]);

  const filteredProducts = useMemo(() => {
    if (!query.trim()) return products;
    const q = query.toLowerCase();
    return products.filter(
      (p) =>
        p.name.toLowerCase().includes(q) || p.brand.toLowerCase().includes(q)
    );
  }, [products, query]);

  return (
    <View style={styles.container}>
      <View style={styles.searchBar}>
        <Ionicons name="search" size={18} color={colors.textSecondary} />
        <TextInput
          value={query}
          onChangeText={setQuery}
          placeholder="Search products..."
          placeholderTextColor={colors.textSecondary}
          style={styles.searchInput}
        />
      </View>

      <Text style={styles.sectionTitle}>1Fi Marketplace</Text>

      {status === 'loading' && <LoadingState label="Fetching products..." />}

      {status === 'error' && (
        <ErrorState message={errorMessage} onRetry={loadProducts} />
      )}

      {status === 'success' && (
        <FlatList
          data={filteredProducts}
          keyExtractor={(item) => item.id}
          numColumns={2}
          contentContainerStyle={styles.listContent}
          renderItem={({ item }) => (
            <ProductCard
              product={item}
              onPress={() =>
                navigation.navigate('ProductDetail', { productId: item.id })
              }
            />
          )}
          ListEmptyComponent={
            <Text style={styles.emptyText}>No products match your search.</Text>
          }
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, paddingHorizontal: spacing.md },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.surface,
    borderRadius: radius.pill,
    borderWidth: 1,
    borderColor: colors.border,
    paddingHorizontal: spacing.md,
    paddingVertical: 10,
  },
  searchInput: {
    flex: 1,
    marginLeft: spacing.sm,
    ...typography.body,
    color: colors.textPrimary,
  },
  sectionTitle: {
    ...typography.h2,
    color: colors.textPrimary,
    marginTop: spacing.md,
    marginBottom: spacing.sm,
  },
  listContent: {
    paddingBottom: spacing.xl,
  },
  emptyText: {
    ...typography.body,
    color: colors.textSecondary,
    textAlign: 'center',
    marginTop: spacing.lg,
  },
});

'@ | Out-File -FilePath "screens/marketplace/MarketplaceSection.js" -Encoding utf8 -NoNewline
@'
import React, { useEffect, useState, useCallback, useMemo } from 'react';
import {
  View,
  Text,
  Image,
  ScrollView,
  StyleSheet,
  SafeAreaView,
} from 'react-native';
import LoadingState from '../../components/LoadingState';
import ErrorState from '../../components/ErrorState';
import VariantSelector from '../../components/VariantSelector';
import EMIPlanCard from '../../components/EMIPlanCard';
import PrimaryButton from '../../components/PrimaryButton';
import { fetchProductById, fetchEMIPlans } from '../../api/marketplaceApi';
import { colors } from '../../theme/colors';
import { typography, spacing, radius } from '../../theme/typography';

export default function ProductDetailScreen({ route, navigation }) {
  const { productId } = route.params;

  const [product, setProduct] = useState(null);
  const [emiPlans, setEmiPlans] = useState([]);
  const [status, setStatus] = useState('loading');
  const [errorMessage, setErrorMessage] = useState('');

  const [selectedVariantId, setSelectedVariantId] = useState(null);
  const [selectedPlanId, setSelectedPlanId] = useState(null);

  const load = useCallback(() => {
    setStatus('loading');
    fetchProductById(productId)
      .then((data) => {
        setProduct(data);
        setSelectedVariantId(data.variants[0]?.id ?? null);
        return fetchEMIPlans(productId, data.basePrice);
      })
      .then((plans) => {
        setEmiPlans(plans);
        setSelectedPlanId(plans[0]?.id ?? null);
        setStatus('success');
      })
      .catch((err) => {
        setErrorMessage(err.message || 'Failed to load product.');
        setStatus('error');
      });
  }, [productId]);

  useEffect(() => {
    load();
  }, [load]);

  const selectedVariant = useMemo(
    () => product?.variants.find((v) => v.id === selectedVariantId),
    [product, selectedVariantId]
  );

  const finalPrice = product
    ? product.basePrice + (selectedVariant?.priceDelta || 0)
    : 0;

  const selectedPlan = emiPlans.find((p) => p.id === selectedPlanId);

  const handleProceed = () => {
    navigation.navigate('OrderSummary', {
      product,
      variant: selectedVariant,
      plan: selectedPlan,
      finalPrice,
    });
  };

  if (status === 'loading') {
    return (
      <SafeAreaView style={styles.root}>
        <LoadingState label="Loading product details..." />
      </SafeAreaView>
    );
  }

  if (status === 'error') {
    return (
      <SafeAreaView style={styles.root}>
        <ErrorState message={errorMessage} onRetry={load} />
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.root}>
      <ScrollView contentContainerStyle={styles.scrollContent}>
        <Image source={{ uri: product.image }} style={styles.image} />

        <View style={styles.body}>
          <Text style={styles.brand}>{product.brand}</Text>
          <Text style={styles.name}>{product.name}</Text>
          <Text style={styles.price}>
            ₹{finalPrice.toLocaleString('en-IN')}
          </Text>

          <Text style={styles.description}>{product.description}</Text>

          <View style={styles.section}>
            <VariantSelector
              variants={product.variants}
              selectedId={selectedVariantId}
              onSelect={setSelectedVariantId}
            />
          </View>

          <View style={styles.section}>
            <Text style={styles.sectionTitle}>Choose your EMI plan</Text>
            {emiPlans.map((plan) => (
              <EMIPlanCard
                key={plan.id}
                plan={plan}
                isSelected={plan.id === selectedPlanId}
                onSelect={setSelectedPlanId}
              />
            ))}
          </View>
        </View>
      </ScrollView>

      <View style={styles.footer}>
        <PrimaryButton
          title={
            selectedPlan
              ? `Proceed with ${selectedPlan.tenureMonths}-month plan`
              : 'Select a plan to continue'
          }
          onPress={handleProceed}
          disabled={!selectedPlan}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.background },
  scrollContent: { paddingBottom: spacing.xl },
  image: {
    width: '100%',
    aspectRatio: 1,
    backgroundColor: colors.surfaceMuted,
  },
  body: { padding: spacing.md },
  brand: {
    ...typography.caption,
    color: colors.textSecondary,
    textTransform: 'uppercase',
  },
  name: {
    ...typography.h1,
    fontSize: 22,
    color: colors.textPrimary,
    marginTop: 4,
  },
  price: {
    ...typography.price,
    fontSize: 20,
    color: colors.primary,
    marginTop: spacing.xs,
  },
  description: {
    ...typography.body,
    color: colors.textSecondary,
    marginTop: spacing.sm,
    lineHeight: 20,
  },
  section: {
    marginTop: spacing.lg,
  },
  sectionTitle: {
    ...typography.h3,
    color: colors.textPrimary,
    marginBottom: spacing.sm,
  },
  footer: {
    padding: spacing.md,
    borderTopWidth: 1,
    borderTopColor: colors.border,
    backgroundColor: colors.surface,
  },
});

'@ | Out-File -FilePath "screens/marketplace/ProductDetailScreen.js" -Encoding utf8 -NoNewline
@'
import React from 'react';
import { View, Text, Image, StyleSheet, SafeAreaView } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import PrimaryButton from '../../components/PrimaryButton';
import { colors } from '../../theme/colors';
import { typography, spacing, radius } from '../../theme/typography';

export default function OrderSummaryScreen({ route, navigation }) {
  const { product, variant, plan, finalPrice } = route.params;

  return (
    <SafeAreaView style={styles.root}>
      <View style={styles.content}>
        <View style={styles.successIcon}>
          <Ionicons name="checkmark-circle" size={56} color={colors.success} />
        </View>
        <Text style={styles.title}>Plan selected!</Text>
        <Text style={styles.subtitle}>
          Here's a summary of your purchase.
        </Text>

        <View style={styles.card}>
          <Image source={{ uri: product.image }} style={styles.image} />
          <View style={styles.info}>
            <Text style={styles.name}>{product.name}</Text>
            {variant && <Text style={styles.variant}>{variant.label}</Text>}
            <Text style={styles.price}>
              ₹{finalPrice.toLocaleString('en-IN')}
            </Text>
          </View>
        </View>

        <View style={styles.emiCard}>
          <Row label="EMI Tenure" value={`${plan.tenureMonths} months`} />
          <Row
            label="Monthly Amount"
            value={`₹${plan.monthlyAmount.toLocaleString('en-IN')}`}
          />
          <Row label="Interest" value="0% (No-cost EMI)" />
        </View>
      </View>

      <View style={styles.footer}>
        <PrimaryButton
          title="Back to Marketplace"
          onPress={() => navigation.popToTop()}
        />
      </View>
    </SafeAreaView>
  );
}

function Row({ label, value }) {
  return (
    <View style={styles.row}>
      <Text style={styles.rowLabel}>{label}</Text>
      <Text style={styles.rowValue}>{value}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.background },
  content: { flex: 1, padding: spacing.md },
  successIcon: { alignItems: 'center', marginTop: spacing.lg },
  title: {
    ...typography.h1,
    fontSize: 22,
    color: colors.textPrimary,
    textAlign: 'center',
    marginTop: spacing.sm,
  },
  subtitle: {
    ...typography.body,
    color: colors.textSecondary,
    textAlign: 'center',
    marginTop: 4,
    marginBottom: spacing.lg,
  },
  card: {
    flexDirection: 'row',
    backgroundColor: colors.surface,
    borderRadius: radius.md,
    borderWidth: 1,
    borderColor: colors.border,
    overflow: 'hidden',
  },
  image: { width: 90, height: 90, backgroundColor: colors.surfaceMuted },
  info: { flex: 1, padding: spacing.sm + 2, justifyContent: 'center' },
  name: { ...typography.bodyBold, color: colors.textPrimary },
  variant: {
    ...typography.body,
    fontSize: 13,
    color: colors.textSecondary,
    marginTop: 2,
  },
  price: {
    ...typography.price,
    fontSize: 16,
    color: colors.primary,
    marginTop: 4,
  },
  emiCard: {
    backgroundColor: colors.surface,
    borderRadius: radius.md,
    borderWidth: 1,
    borderColor: colors.border,
    padding: spacing.md,
    marginTop: spacing.md,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 6,
  },
  rowLabel: { ...typography.body, color: colors.textSecondary, fontSize: 14 },
  rowValue: { ...typography.bodyBold, color: colors.textPrimary, fontSize: 14 },
  footer: {
    padding: spacing.md,
    borderTopWidth: 1,
    borderTopColor: colors.border,
    backgroundColor: colors.surface,
  },
});

'@ | Out-File -FilePath "screens/marketplace/OrderSummaryScreen.js" -Encoding utf8 -NoNewline
@'
// Design tokens extracted from the existing 1Fi app (Limit & Shop pages)
export const colors = {
  primary: '#6C3FD1',       // main purple used on buttons, active tab, icons
  primaryDark: '#3F1F8C',   // deep violet used in header gradient
  primaryLight: '#EDE6FB',  // light purple used for unselected pill bg
  gradientStart: '#3B1E8C',
  gradientEnd: '#6C3FD1',

  background: '#F0F0F4',    // page background (light grey)
  surface: '#FFFFFF',       // card / pill background
  surfaceMuted: '#F5F4F8',

  textPrimary: '#1A1A2E',   // headings
  textSecondary: '#6B7280', // subtitle / grey text
  textOnPrimary: '#FFFFFF',

  border: '#E5E4EA',
  success: '#1FA97A',
  error: '#D5453D',
  errorBg: '#FBEAEA',

  inactiveTab: '#9B96A8',
};

export default colors;

'@ | Out-File -FilePath "theme/colors.js" -Encoding utf8 -NoNewline
@'
export const typography = {
  h1: { fontSize: 26, fontWeight: '700' },
  h2: { fontSize: 20, fontWeight: '700' },
  h3: { fontSize: 17, fontWeight: '600' },
  body: { fontSize: 15, fontWeight: '400' },
  bodyBold: { fontSize: 15, fontWeight: '600' },
  caption: { fontSize: 12, fontWeight: '500', letterSpacing: 0.5 },
  price: { fontSize: 18, fontWeight: '700' },
};

export const spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
};

export const radius = {
  sm: 8,
  md: 14,
  lg: 20,
  pill: 999,
};

export default { typography, spacing, radius };

'@ | Out-File -FilePath "theme/typography.js" -Encoding utf8 -NoNewline
Write-Host 'Done! All files created.'