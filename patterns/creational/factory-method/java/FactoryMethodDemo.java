// Factory Method: the creator declares a method that subclasses override
// to decide which concrete product to instantiate.
interface Document {
    String render();
}

class PdfDocument implements Document {
    public String render() { return "PDF document rendered"; }
}

class WordDocument implements Document {
    public String render() { return "Word document rendered"; }
}

// The "Creator": defines the factory method as abstract and uses it
// internally without knowing which concrete Document it will get.
abstract class DocumentCreator {
    abstract Document createDocument(); // the factory method

    String open() {
        Document document = createDocument();
        return document.render();
    }
}

class PdfCreator extends DocumentCreator {
    Document createDocument() { return new PdfDocument(); }
}

class WordCreator extends DocumentCreator {
    Document createDocument() { return new WordDocument(); }
}

public class FactoryMethodDemo {
    public static void main(String[] args) {
        DocumentCreator creator = new PdfCreator();
        System.out.println(creator.open());

        creator = new WordCreator();
        System.out.println(creator.open());
    }
}
