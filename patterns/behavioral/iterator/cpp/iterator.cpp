// Iterator: exposes a way to walk through a collection's elements one by
// one (hasNext/next) without exposing whether it's backed by a vector,
// a linked list, or anything else. C++ containers already have this via
// their own iterators (begin()/end()) — this example builds the
// mechanism by hand to show what's actually happening underneath.
#include <iostream>
#include <string>
#include <vector>

class BookIterator {
public:
    explicit BookIterator(const std::vector<std::string>& books) : books(books), position(0) {}

    bool hasNext() const { return position < books.size(); }

    const std::string& next() { return books[position++]; }

private:
    const std::vector<std::string>& books;
    size_t position;
};

class BookCollection {
public:
    void add(const std::string& title) { books.push_back(title); }

    BookIterator createIterator() const { return BookIterator(books); }

private:
    std::vector<std::string> books;
};

int main() {
    BookCollection collection;
    collection.add("Clean Code");
    collection.add("The Pragmatic Programmer");
    collection.add("Design Patterns");

    BookIterator iterator = collection.createIterator();
    while (iterator.hasNext()) {
        std::cout << iterator.next() << std::endl;
    }

    return 0;
}
