<?php
// Proxy: implements the same interface as the real object and controls
// access to it — here, a "virtual proxy" that delays creating the
// expensive real object until it's actually needed.
interface Image
{
    public function display(): void;
}

class RealImage implements Image // expensive to create — simulates loading from disk
{
    public function __construct(private string $filename)
    {
        $this->loadFromDisk();
    }

    private function loadFromDisk(): void
    {
        echo "Loading {$this->filename} from disk...\n";
    }

    public function display(): void
    {
        echo "Displaying {$this->filename}\n";
    }
}

// The proxy: same interface as RealImage, but only creates the real
// object the first time display() is actually called.
class ImageProxy implements Image
{
    private ?RealImage $realImage = null;

    public function __construct(private string $filename) {}

    public function display(): void
    {
        if ($this->realImage === null) {
            $this->realImage = new RealImage($this->filename); // created lazily, on first use
        }
        $this->realImage->display();
    }
}

// --- demo ---
$image = new ImageProxy("photo.png");

echo "Image proxy created, nothing loaded yet\n";
$image->display(); // loads from disk here
$image->display(); // reuses the already-loaded RealImage
