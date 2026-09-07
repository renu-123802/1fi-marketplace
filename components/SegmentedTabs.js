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
