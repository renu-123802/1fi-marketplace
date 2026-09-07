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
