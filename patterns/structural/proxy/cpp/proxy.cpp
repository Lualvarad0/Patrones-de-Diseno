// Proxy: implements the same interface as the real object and controls
// access to it — here, a "virtual proxy" that delays creating the
// expensive real object until it's actually needed.
#include <iostream>
#include <memory>
#include <string>

class Image {
public:
    virtual void display() = 0;
    virtual ~Image() = default;
};

class RealImage : public Image { // expensive to create — simulates loading from disk
public:
    explicit RealImage(std::string filename) : filename(std::move(filename)) {
        loadFromDisk();
    }

    void display() override {
        std::cout << "Displaying " << filename << std::endl;
    }

private:
    void loadFromDisk() const {
        std::cout << "Loading " << filename << " from disk..." << std::endl;
    }

    std::string filename;
};

// The proxy: same interface as RealImage, but only creates the real
// object the first time display() is actually called.
class ImageProxy : public Image {
public:
    explicit ImageProxy(std::string filename) : filename(std::move(filename)) {}

    void display() override {
        if (!realImage) {
            realImage = std::make_unique<RealImage>(filename); // created lazily, on first use
        }
        realImage->display();
    }

private:
    std::string filename;
    std::unique_ptr<RealImage> realImage;
};

int main() {
    std::unique_ptr<Image> image = std::make_unique<ImageProxy>("photo.png");

    std::cout << "Image proxy created, nothing loaded yet" << std::endl;
    image->display(); // loads from disk here
    image->display(); // reuses the already-loaded RealImage

    return 0;
}
