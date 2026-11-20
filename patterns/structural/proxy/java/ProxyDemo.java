// Proxy: implements the same interface as the real object and controls
// access to it — here, a "virtual proxy" that delays creating the
// expensive real object until it's actually needed.
interface Image {
    void display();
}

class RealImage implements Image { // expensive to create — simulates loading from disk
    private final String filename;

    RealImage(String filename) {
        this.filename = filename;
        loadFromDisk();
    }

    private void loadFromDisk() { System.out.println("Loading " + filename + " from disk..."); }

    public void display() { System.out.println("Displaying " + filename); }
}

// The proxy: same interface as RealImage, but only creates the real
// object the first time display() is actually called.
class ImageProxy implements Image {
    private final String filename;
    private RealImage realImage;

    ImageProxy(String filename) { this.filename = filename; }

    public void display() {
        if (realImage == null) {
            realImage = new RealImage(filename); // created lazily, on first use
        }
        realImage.display();
    }
}

public class ProxyDemo {
    public static void main(String[] args) {
        Image image = new ImageProxy("photo.png");

        System.out.println("Image proxy created, nothing loaded yet");
        image.display(); // loads from disk here
        image.display(); // reuses the already-loaded RealImage
    }
}
