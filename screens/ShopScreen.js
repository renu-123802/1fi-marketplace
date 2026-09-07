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
