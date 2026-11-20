// Factory Method: in Rust, "subclasses override a factory method" becomes
// "different creator structs implement the same trait, each returning a
// different concrete type behind the same trait object".
trait Document {
    fn render(&self) -> String;
}

struct PdfDocument;
impl Document for PdfDocument {
    fn render(&self) -> String {
        "PDF document rendered".to_string()
    }
}

struct WordDocument;
impl Document for WordDocument {
    fn render(&self) -> String {
        "Word document rendered".to_string()
    }
}

// The "Creator" trait: declares the factory method; `open()` uses it
// without knowing which concrete Document it will get.
trait DocumentCreator {
    fn create_document(&self) -> Box<dyn Document>; // the factory method

    fn open(&self) -> String {
        self.create_document().render()
    }
}

struct PdfCreator;
impl DocumentCreator for PdfCreator {
    fn create_document(&self) -> Box<dyn Document> {
        Box::new(PdfDocument)
    }
}

struct WordCreator;
impl DocumentCreator for WordCreator {
    fn create_document(&self) -> Box<dyn Document> {
        Box::new(WordDocument)
    }
}

fn main() {
    let creator: Box<dyn DocumentCreator> = Box::new(PdfCreator);
    println!("{}", creator.open());

    let creator: Box<dyn DocumentCreator> = Box::new(WordCreator);
    println!("{}", creator.open());
}
