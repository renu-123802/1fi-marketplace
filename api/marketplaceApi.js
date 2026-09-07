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
