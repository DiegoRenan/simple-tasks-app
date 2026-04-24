# Writing Minitest Tests with Expectation Style

We are using Minitest and following expectation-style syntax based on the [Ruby Style Guide](https://minitest.rubystyle.guide/#expectations).

Our focus is:

- readability
- explicit behavior verification
- maintainable tests
- Rails-native testing patterns
- high signal, low noise test suites

Expectation style should improve clarity, not add cleverness.

Prefer tests that explain behavior clearly and fail meaningfully.

---

## Expectations vs Assertions

### PREFER expectation style when readability improves

Prefer:

```ruby
user.name.must_equal "Fulano"
order.total.must_be :>, 0
response.status.must_equal 200
```

Expectation style reads more naturally from left to right. It should improve understanding immediately.

### DO NOT mix styles randomly

Avoid inconsistent tests like:

```ruby
assert_equal 200, response.status
user.name.must_equal "Admin"
assert user.valid?
```

Choose a consistent style within the file.

- Prefer expectation style when using spec-style Minitest.
- Prefer assertions when working with Rails default test classes where assertions are clearer.

Consistency matters more than ideology.

---

## Test Structure

### PREFER small, focused tests

Each test should validate one behavior.

Prefer:

```ruby
it "calculates total price" do
  cart.total.must_equal 150
end
```

Over:

```ruby
it "works correctly" do
  cart.total.must_equal 150
  cart.items.count.must_equal 3
  cart.valid?.must_equal true
end
```

One reason to fail. One behavior to verify.

### PREFER descriptive test names

Use names that explain behavior.

Prefer:

```ruby
it "rejects expired coupons"
```

Over:

```ruby
it "coupon test"
```

Tests are documentation. Write for future developers.

---

## Truthiness and Presence

### PREFER semantic expectations

Prefer:

```ruby
user.admin?.must_equal true
session.must_be :present?
record.must_be_nil
```

Over:

```ruby
refute_nil session
assert_nil record
```

Prefer intention-revealing expectations. Avoid vague truthiness when exact behavior matters.

### AVOID weak assertions

Avoid:

```ruby
user.must_be :valid?
```

When stronger validation is possible.

Prefer:

```ruby
user.errors[:email].must_include "can't be blank"
```

Test business behavior, not generic framework behavior.

---

## Collections

### PREFER direct expectation methods

Prefer:

```ruby
users.count.must_equal 3
users.must_include admin
users.wont_include guest
```

Over:

```ruby
assert_equal 3, users.count
assert_includes users, admin
refute_includes users, guest
```

Use expectations that express the intent clearly.

---

## Exceptions

### PREFER explicit exception expectations

Prefer:

```ruby
proc {
  service.call
}.must_raise PaymentError
```

Over vague rescue testing.

The failure should explain what was expected.

---

## Numeric Comparisons

### PREFER must_be for comparisons

Prefer:

```ruby
invoice.total.must_be :>, 0
score.must_be :<=, 100
```

Over:

```ruby
assert_operator invoice.total, :>, 0
assert_operator score, :<=, 100
```

This improves readability significantly.

---

## Nil and Empty Checks

### PREFER exact expectations

Prefer:

```ruby
result.must_be_nil
items.must_be :empty?
token.wont_be_nil
```

Over:

```ruby
assert_nil result
assert items.empty?
refute_nil token
```

Be explicit.

---

## Spec Style

### PREFER describe + it with expectations

Expectation style works best with:

```ruby
describe Invoice do
  it "calculates total" do
    invoice.total.must_equal 100
  end
end
```

This is preferred over forcing expectations into classic TestCase structure.

Use expectation style naturally, not mechanically.

---

## Rails Guidance

### PREFER assertions for Rails-specific helpers when clearer

Some Rails helpers are clearer with assertions:

```ruby
assert_response :success
assert_redirected_to root_path
assert_difference "User.count", 1 do
  post users_path, params: params
end
```

Do not force expectation style where Rails assertions are superior.

Use the clearest tool. Not everything should be converted.

---

## Avoid Style Abuse

### DO NOT chain expectations excessively

Avoid:

```ruby
user.orders.first.total.must_equal 100
```

Prefer:

```ruby
order = user.orders.first
order.total.must_equal 100
```

Readable tests > compact tests.

### DO NOT test implementation details

Avoid expectations like:

```ruby
service.instance_variable_get(:@state).must_equal :done
```

Prefer public behavior verification.

Test outcomes. Not internals.

---

## General Principles

- prefer clarity over clever syntax
- prefer behavior over implementation
- prefer consistency over personal preference
- prefer strong expectations over weak truthiness
- prefer failure messages that teach immediately
- prefer maintainable tests over short tests

Expectation style is not about writing less.

It is about writing tests that read like specifications.

The best expectation-style test should feel obvious.
