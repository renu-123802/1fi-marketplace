// Mock product dataset. In production this would come from a real backend.
// Kept separate from UI components so it can later be swapped for a real API call.

export const PRODUCTS = [
  {
    id: 'p1',
    name: 'iPhone 15',
    brand: 'Apple Premium Reseller',
    category: 'Electronics',
    basePrice: 79900,
    image: 'https://picsum.photos/seed/iphone15/600/600',
    description:
      'Apple iPhone 15 with A16 Bionic chip, 48MP main camera, and USB-C. Available with no-cost EMI backed by your mutual fund portfolio.',
    variants: [
      { id: 'v1', label: '128GB · Black', priceDelta: 0 },
      { id: 'v2', label: '256GB · Black', priceDelta: 10000 },
      { id: 'v3', label: '128GB · Blue', priceDelta: 0 },
    ],
  },
  {
    id: 'p2',
    name: 'MacBook Air M2',
    brand: 'Apple Premium Reseller',
    category: 'Electronics',
    basePrice: 114900,
    image: 'https://picsum.photos/seed/macbookair/600/600',
    description:
      '13-inch MacBook Air with M2 chip, all-day battery life, and a fanless design. Backed by your mutual funds, no credit score required.',
    variants: [
      { id: 'v1', label: '8GB/256GB · Midnight', priceDelta: 0 },
      { id: 'v2', label: '16GB/512GB · Starlight', priceDelta: 25000 },
    ],
  },
  {
    id: 'p3',
    name: 'Solitaire Diamond Ring',
    brand: 'CaratLane',
    category: 'Jewellery',
    basePrice: 45000,
    image: 'https://picsum.photos/seed/caratlane/600/600',
    description:
      'Handcrafted solitaire ring in 18k gold with a certified diamond. Pay in easy no-cost EMIs.',
    variants: [
      { id: 'v1', label: 'Size 6', priceDelta: 0 },
      { id: 'v2', label: 'Size 7', priceDelta: 0 },
    ],
  },
  {
    id: 'p4',
    name: 'Domestic Flight Voucher',
    brand: 'Air India',
    category: 'Travel',
    basePrice: 12000,
    image: 'https://picsum.photos/seed/airindia/600/600',
    description:
      'Flexible domestic flight voucher valid on all Air India routes for 12 months. No-cost EMI up to 18 months.',
    variants: [{ id: 'v1', label: 'Economy', priceDelta: 0 }],
  },
  {
    id: 'p5',
    name: 'Kerala Backwaters Stay',
    brand: 'CGH Earth',
    category: 'Travel',
    basePrice: 32000,
    image: 'https://picsum.photos/seed/cghearth/600/600',
    description:
      '3 nights / 4 days stay at a CGH Earth backwater resort, breakfast included. No-cost EMI up to 24 months.',
    variants: [
      { id: 'v1', label: 'Standard Room', priceDelta: 0 },
      { id: 'v2', label: 'Lake View Room', priceDelta: 6000 },
    ],
  },
  {
    id: 'p6',
    name: 'Royal Enfield Classic 350',
    brand: 'RE Store',
    category: 'Automobile',
    basePrice: 210000,
    image: 'https://picsum.photos/seed/royalenfield/600/600',
    description:
      'Royal Enfield Classic 350 with signature thump. Own it today, pay later backed by your investments.',
    variants: [
      { id: 'v1', label: 'Stealth Black', priceDelta: 0 },
      { id: 'v2', label: 'Chrome Red', priceDelta: 8000 },
    ],
  },
];

export default PRODUCTS;
