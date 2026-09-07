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
