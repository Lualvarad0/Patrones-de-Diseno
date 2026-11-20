// Factory Method: the creator declares a method that subclasses override
// to decide which concrete product to instantiate.
class PdfDocument {
  render() {
    return "PDF document rendered";
  }
}

class WordDocument {
  render() {
    return "Word document rendered";
  }
}

// The "Creator": defines the factory method and uses it internally
// without knowing which concrete document it will get.
class DocumentCreator {
  createDocument() {
    throw new Error("Subclasses must implement createDocument()");
  }

  open() {
    const document = this.createDocument();
    return document.render();
  }
}

class PdfCreator extends DocumentCreator {
  createDocument() {
    return new PdfDocument();
  }
}

class WordCreator extends DocumentCreator {
  createDocument() {
    return new WordDocument();
  }
}

// --- demo ---
let creator = new PdfCreator();
console.log(creator.open());

creator = new WordCreator();
console.log(creator.open());
