// Proxy: implements the same interface as the real object and controls
// access to it — here, a "virtual proxy" that delays creating the
// expensive real object until it's actually needed.
class RealImage {
  // expensive to create — simulates loading from disk
  constructor(filename) {
    this.filename = filename;
    this.#loadFromDisk();
  }

  #loadFromDisk() {
    console.log(`Loading ${this.filename} from disk...`);
  }

  display() {
    console.log(`Displaying ${this.filename}`);
  }
}

// The proxy: same interface as RealImage, but only creates the real
// object the first time display() is actually called.
class ImageProxy {
  #filename;
  #realImage = null;

  constructor(filename) {
    this.#filename = filename;
  }

  display() {
    if (!this.#realImage) {
      this.#realImage = new RealImage(this.#filename); // created lazily, on first use
    }
    this.#realImage.display();
  }
}

// --- demo ---
const image = new ImageProxy("photo.png");

console.log("Image proxy created, nothing loaded yet");
image.display(); // loads from disk here
image.display(); // reuses the already-loaded RealImage
