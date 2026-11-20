import java.util.ArrayList;
import java.util.List;

// Composite: files (leaves) and folders (containers) implement the same
// interface, so the client can call getSize() on either one without
// asking "is this a leaf or a folder?" first.
interface FileSystemItem {
    int getSize();
    void print(String indent);
}

class FileItem implements FileSystemItem {
    private final String name;
    private final int size;

    FileItem(String name, int size) {
        this.name = name;
        this.size = size;
    }

    public int getSize() { return size; }
    public void print(String indent) { System.out.println(indent + name + " (" + size + "KB)"); }
}

class Folder implements FileSystemItem {
    private final String name;
    private final List<FileSystemItem> children = new ArrayList<>();

    Folder(String name) { this.name = name; }

    void add(FileSystemItem item) { children.add(item); }

    // Delegates to each child and sums the results — doesn't matter if a
    // child is a FileItem or another Folder, the recursion just happens.
    public int getSize() {
        int total = 0;
        for (FileSystemItem child : children) total += child.getSize();
        return total;
    }

    public void print(String indent) {
        System.out.println(indent + name + "/ (" + getSize() + "KB)");
        for (FileSystemItem child : children) child.print(indent + "  ");
    }
}

public class CompositeDemo {
    public static void main(String[] args) {
        Folder root = new Folder("project");
        root.add(new FileItem("README.md", 2));

        Folder src = new Folder("src");
        src.add(new FileItem("Main.java", 5));
        src.add(new FileItem("Utils.java", 3));
        root.add(src);

        root.print(""); // the client only ever calls print()/getSize() on FileSystemItem
    }
}
