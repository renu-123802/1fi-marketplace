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
