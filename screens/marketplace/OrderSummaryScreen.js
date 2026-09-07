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
