# 1Fi Marketplace

A new "1Fi Marketplace" section built into the existing Shop page of the 1Fi app, as part of the SDE Intern assignment.

## Tech stack
- React Native (Expo, managed workflow)
- React Navigation (bottom tabs + native stack)

Chosen to match 1Fi's existing native Android app and to keep setup/run time minimal for review.

## Design consistency
Colors, typography, and component styles (`theme/colors.js`, `theme/typography.js`) were extracted directly from the real 1Fi app's Shop and Limit pages: purple (`#6C3FD1`) primary accent, pill-shaped buttons and tabs, white rounded cards on a light grey background, and the same bottom navigation pattern (Home / Shop / EMI Dues / Limit / Profile).

The Shop page's existing "Top Brands" / "Nearby Stores" segmented pill switcher was extended with a third tab, **1Fi Marketplace**, using the same `SegmentedTabs` component so the interaction pattern stays identical to the existing app.

## Folder structure
- `theme/` — design tokens (colors, typography, spacing)
- `data/` — mock product & EMI plan data (never imported directly by UI)
- `api/` — mock API layer, simulates network delay, exposes `fetchProducts`, `fetchProductById`, `fetchEMIPlans`. Swappable for a real backend without touching any screen.
- `components/` — reusable UI: ProductCard, VariantSelector, EMIPlanCard, PrimaryButton, SegmentedTabs, LoadingState, ErrorState
- `screens/` — ShopScreen (tab switcher) + `screens/marketplace/` (MarketplaceSection, ProductDetailScreen, OrderSummaryScreen) + PlaceholderScreen (for out-of-scope tabs)
- `navigation/` — RootTabNavigator (bottom tabs) + ShopStackNavigator (Shop -> ProductDetail -> OrderSummary)

## Marketplace flow
1. **Shop tab → 1Fi Marketplace** — searchable product grid, loaded via the mock API with loading/error/empty states.
2. **Tap a product → Product Detail** — image, price, description, variant selector (chips), and a list of no-cost EMI plans (3/6/12/18/24 months) to choose from.
3. **Proceed with plan (CTA)** — navigates to an **Order Summary** screen showing the selected product, variant, and EMI plan, confirming the flow end-to-end.

## Data & API handling
No product/EMI data is hardcoded inside components. `data/products.js` and `data/emiPlans.js` hold the mock dataset and EMI generation logic; `api/marketplaceApi.js` wraps them in `async` functions with an artificial network delay (`setTimeout`), so the app behaves as if talking to a real backend.

## State management
Local component state (`useState`/`useEffect`/`useMemo`) is used throughout — no global state library was needed given the scope. Each screen owns its own loading/error/data state with a retry-friendly `load()` callback.

## Running the project
npm install
npx expo start

Then scan the QR code with the Expo Go app.

## Notes
- "Top Brands" and "Nearby Stores" tabs are intentionally left as lightweight placeholders per the assignment's scope.
- Product images are placeholder images (picsum.photos).
