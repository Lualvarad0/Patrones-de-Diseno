// Chain of Responsibility: each handler either resolves the request or
// passes it to the next handler in the chain — the caller only ever
// talks to the first handler and doesn't know how many others exist.
#include <iostream>
#include <memory>

class SupportHandler {
public:
    SupportHandler* setNext(std::unique_ptr<SupportHandler> nextHandler) {
        next = std::move(nextHandler);
        return next.get(); // lets callers chain setNext calls while building the chain
    }

    void handle(int severity) {
        if (canHandle(severity)) {
            resolve(severity);
        } else if (next) {
            next->handle(severity);
        } else {
            std::cout << "No handler could resolve severity " << severity << std::endl;
        }
    }

    virtual ~SupportHandler() = default;

protected:
    virtual bool canHandle(int severity) const = 0;
    virtual void resolve(int severity) const = 0;

private:
    std::unique_ptr<SupportHandler> next;
};

class Level1Support : public SupportHandler {
protected:
    bool canHandle(int severity) const override { return severity <= 1; }
    void resolve(int severity) const override { std::cout << "Level1 resolved severity " << severity << std::endl; }
};

class Level2Support : public SupportHandler {
protected:
    bool canHandle(int severity) const override { return severity <= 2; }
    void resolve(int severity) const override { std::cout << "Level2 resolved severity " << severity << std::endl; }
};

class Level3Support : public SupportHandler {
protected:
    bool canHandle(int severity) const override { return severity <= 3; }
    void resolve(int severity) const override { std::cout << "Level3 resolved severity " << severity << std::endl; }
};

int main() {
    auto level1 = std::make_unique<Level1Support>();
    SupportHandler* level2 = level1->setNext(std::make_unique<Level2Support>());
    level2->setNext(std::make_unique<Level3Support>()); // chain: 1 -> 2 -> 3

    level1->handle(1); // resolved at level 1
    level1->handle(2); // escalates to level 2
    level1->handle(3); // escalates to level 3
    level1->handle(5); // nobody can handle it

    return 0;
}
