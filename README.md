# Acme Widget Co - Basket Proof of Concept

This is a proof of concept for Acme Widget Co's new sales system, implemented in Ruby. It demonstrates clean code, extensibility, and separation of concerns.

## Features
- Product catalogue with code, name, and price
- Delivery charge rules based on basket value
- Extensible offer system (strategy pattern)
- Basket interface: `add(product_code)` and `total`
- Unit tests for example baskets

## Structure
- `lib/` - Core classes
  - `product_catalogue.rb` - Product lookup
  - `delivery_rule.rb` - Delivery cost logic
  - `offer.rb` - Offer interface
  - `offers/buy_one_get_one_half_price.rb` - Red widget offer
  - `basket.rb` - Main basket logic
- `spec/` - RSpec tests

## Usage
1. **Install Ruby** (2.6+ recommended)
2. **Install RSpec** (for tests):
   ```
   gem install rspec
   ```
3. **Run tests:**
   ```
   rspec spec/basket_spec.rb
   rspec spec/
   ```

## Assumptions
- Product codes are unique.
- Delivery rules are provided as an array of `{ threshold, cost }` hashes, sorted by threshold.
- Offers are injected as objects responding to `apply(items, catalogue)`.
- Only the specified offer (buy one red widget, get the second half price) is implemented, but the system is extensible.
- All prices and totals are rounded to two decimal places.

## Example Baskets
| Products                  | Total   |
|---------------------------|---------|
| B01, G01                  | $37.85  |
| R01, R01                  | $54.37  |
| R01, G01                  | $60.85  |
| B01, B01, R01, R01, R01   | $98.27  |

## Extending
- Add new offers by subclassing `Offer` and injecting into the basket.
- Add new products or delivery rules by updating the respective data.

## Comments & Commits
- The code is commented for clarity.
- Please use conventional, meaningful commit messages.
