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
