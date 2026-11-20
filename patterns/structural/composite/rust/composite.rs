// Composite: files (leaves) and folders (containers) implement the same
// trait, so the client can call size() on either one without asking
// "is this a leaf or a folder?" first.
trait FileSystemItem {
    fn size(&self) -> u32;
    fn print(&self, indent: &str);
}

struct FileItem {
    name: String,
    size: u32,
}

impl FileSystemItem for FileItem {
    fn size(&self) -> u32 {
        self.size
    }

    fn print(&self, indent: &str) {
        println!("{indent}{} ({}KB)", self.name, self.size);
    }
}

struct Folder {
    name: String,
    children: Vec<Box<dyn FileSystemItem>>,
}

impl Folder {
    fn new(name: &str) -> Self {
        Folder { name: name.to_string(), children: Vec::new() }
    }

    fn add(&mut self, item: Box<dyn FileSystemItem>) {
        self.children.push(item);
    }
}

impl FileSystemItem for Folder {
    // Delegates to each child and sums the results — doesn't matter if a
    // child is a FileItem or another Folder, the recursion just happens.
    fn size(&self) -> u32 {
        self.children.iter().map(|child| child.size()).sum()
    }

    fn print(&self, indent: &str) {
        println!("{indent}{}/ ({}KB)", self.name, self.size());
        let child_indent = format!("{indent}  ");
        for child in &self.children {
            child.print(&child_indent);
        }
    }
}

fn main() {
    let mut root = Folder::new("project");
    root.add(Box::new(FileItem { name: "README.md".to_string(), size: 2 }));

    let mut src = Folder::new("src");
    src.add(Box::new(FileItem { name: "main.rs".to_string(), size: 5 }));
    src.add(Box::new(FileItem { name: "utils.rs".to_string(), size: 3 }));
    root.add(Box::new(src));

    root.print(""); // the client only ever calls print()/size(), leaf or folder
}
