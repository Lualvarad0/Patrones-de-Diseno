// Composite: files (leaves) and folders (containers) implement the same
// interface, so the client can call getSize() on either one without
// asking "is this a leaf or a folder?" first.
#include <iostream>
#include <memory>
#include <string>
#include <vector>

class FileSystemItem {
public:
    virtual int getSize() const = 0;
    virtual void print(const std::string& indent) const = 0;
    virtual ~FileSystemItem() = default;
};

class FileItem : public FileSystemItem {
public:
    FileItem(std::string name, int size) : name(std::move(name)), size(size) {}

    int getSize() const override { return size; }
    void print(const std::string& indent) const override {
        std::cout << indent << name << " (" << size << "KB)" << std::endl;
    }

private:
    std::string name;
    int size;
};

class Folder : public FileSystemItem {
public:
    explicit Folder(std::string name) : name(std::move(name)) {}

    void add(std::unique_ptr<FileSystemItem> item) {
        children.push_back(std::move(item));
    }

    // Delegates to each child and sums the results — doesn't matter if a
    // child is a FileItem or another Folder, the recursion just happens.
    int getSize() const override {
        int total = 0;
        for (const auto& child : children) total += child->getSize();
        return total;
    }

    void print(const std::string& indent) const override {
        std::cout << indent << name << "/ (" << getSize() << "KB)" << std::endl;
        for (const auto& child : children) child->print(indent + "  ");
    }

private:
    std::string name;
    std::vector<std::unique_ptr<FileSystemItem>> children;
};

int main() {
    Folder root("project");
    root.add(std::make_unique<FileItem>("README.md", 2));

    auto src = std::make_unique<Folder>("src");
    src->add(std::make_unique<FileItem>("main.cpp", 5));
    src->add(std::make_unique<FileItem>("utils.cpp", 3));
    root.add(std::move(src));

    root.print(""); // the client only ever calls print()/getSize(), leaf or folder

    return 0;
}
