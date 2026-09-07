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
