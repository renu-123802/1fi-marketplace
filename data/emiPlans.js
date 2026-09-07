// Generates EMI plan options for a given price.
// All plans are "no-cost" (0% interest) to match 1Fi's "No-cost EMIs" positioning,
// mirroring the "No-cost EMIs upto X months" copy seen on the real Shop page.

const TENURE_OPTIONS_MONTHS = [3, 6, 12, 18, 24];

export function generateEMIPlans(price, maxTenureMonths = 24) {
  return TENURE_OPTIONS_MONTHS.filter((m) => m <= maxTenureMonths).map(
    (tenure) => {
      const monthlyAmount = Math.round(price / tenure);
      return {
        id: `emi-${tenure}`,
        tenureMonths: tenure,
        interestRate: 0,
        monthlyAmount,
        totalPayable: price,
        label: `${tenure} months`,
      };
    }
  );
}

export default generateEMIPlans;
