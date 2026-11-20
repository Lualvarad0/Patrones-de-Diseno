// Strategy: extracts an algorithm (here, "how to pay") into its own
// interchangeable class, so the context using it doesn't need a big
// if/else to pick behavior.
#include <iostream>
#include <memory>

class PaymentStrategy {
public:
    virtual void pay(double amount) const = 0;
    virtual ~PaymentStrategy() = default;
};

class CreditCardPayment : public PaymentStrategy {
public:
    void pay(double amount) const override {
        std::cout << "Paid $" << amount << " with credit card" << std::endl;
    }
};

class PayPalPayment : public PaymentStrategy {
public:
    void pay(double amount) const override {
        std::cout << "Paid $" << amount << " with PayPal" << std::endl;
    }
};

// The "context": holds a strategy and delegates to it, without knowing
// which concrete strategy it is.
class ShoppingCart {
public:
    explicit ShoppingCart(std::unique_ptr<PaymentStrategy> strategy)
        : paymentStrategy(std::move(strategy)) {}

    void setPaymentStrategy(std::unique_ptr<PaymentStrategy> strategy) {
        paymentStrategy = std::move(strategy);
    }

    void checkout(double amount) const {
        paymentStrategy->pay(amount);
    }

private:
    std::unique_ptr<PaymentStrategy> paymentStrategy;
};

int main() {
    ShoppingCart cart(std::make_unique<CreditCardPayment>());
    cart.checkout(50.0);

    cart.setPaymentStrategy(std::make_unique<PayPalPayment>()); // swap at runtime
    cart.checkout(30.0);

    return 0;
}
