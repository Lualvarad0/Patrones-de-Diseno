// Proxy: implements the same trait as the real object and controls
// access to it — here, a "virtual proxy" that delays creating the
// expensive real object until it's actually needed.
trait Image {
    fn display(&mut self);
}

struct RealImage { // expensive to create — simulates loading from disk
    filename: String,
}

impl RealImage {
    fn new(filename: &str) -> Self {
        println!("Loading {filename} from disk...");
        RealImage { filename: filename.to_string() }
    }
}

impl Image for RealImage {
    fn display(&mut self) {
        println!("Displaying {}", self.filename);
    }
}

// The proxy: same trait as RealImage, but only creates the real object
// the first time display() is actually called.
struct ImageProxy {
    filename: String,
    real_image: Option<RealImage>,
}

impl ImageProxy {
    fn new(filename: &str) -> Self {
        ImageProxy { filename: filename.to_string(), real_image: None }
    }
}

impl Image for ImageProxy {
    fn display(&mut self) {
        if self.real_image.is_none() {
            self.real_image = Some(RealImage::new(&self.filename)); // created lazily, on first use
        }
        self.real_image.as_mut().unwrap().display();
    }
}

fn main() {
    let mut image = ImageProxy::new("photo.png");

    println!("Image proxy created, nothing loaded yet");
    image.display(); // loads from disk here
    image.display(); // reuses the already-loaded RealImage
}
