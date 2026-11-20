// Factory Method: the creator declares a method that subclasses override
// to decide which concrete product to instantiate.
#include <iostream>
#include <memory>
#include <string>

class Document {
public:
    virtual std::string render() const = 0;
    virtual ~Document() = default;
};

class PdfDocument : public Document {
public:
    std::string render() const override { return "PDF document rendered"; }
};

class WordDocument : public Document {
public:
    std::string render() const override { return "Word document rendered"; }
};

// The "Creator": declares the factory method as pure virtual and uses it
// internally without knowing which concrete Document it will get.
class DocumentCreator {
public:
    virtual std::unique_ptr<Document> createDocument() const = 0; // factory method

    std::string open() const {
        auto document = createDocument();
        return document->render();
    }

    virtual ~DocumentCreator() = default;
};

class PdfCreator : public DocumentCreator {
public:
    std::unique_ptr<Document> createDocument() const override {
        return std::make_unique<PdfDocument>();
    }
};

class WordCreator : public DocumentCreator {
public:
    std::unique_ptr<Document> createDocument() const override {
        return std::make_unique<WordDocument>();
    }
};

int main() {
    std::unique_ptr<DocumentCreator> creator = std::make_unique<PdfCreator>();
    std::cout << creator->open() << std::endl;

    creator = std::make_unique<WordCreator>();
    std::cout << creator->open() << std::endl;

    return 0;
}
