<?php
// Factory Method: the creator declares a method that subclasses override
// to decide which concrete product to instantiate.
interface Document
{
    public function render(): string;
}

class PdfDocument implements Document
{
    public function render(): string
    {
        return "PDF document rendered";
    }
}

class WordDocument implements Document
{
    public function render(): string
    {
        return "Word document rendered";
    }
}

// The "Creator": declares the factory method as abstract and uses it
// internally without knowing which concrete Document it will get.
abstract class DocumentCreator
{
    abstract public function createDocument(): Document; // the factory method

    public function open(): string
    {
        $document = $this->createDocument();
        return $document->render();
    }
}

class PdfCreator extends DocumentCreator
{
    public function createDocument(): Document
    {
        return new PdfDocument();
    }
}

class WordCreator extends DocumentCreator
{
    public function createDocument(): Document
    {
        return new WordDocument();
    }
}

// --- demo ---
$creator = new PdfCreator();
echo $creator->open() . "\n";

$creator = new WordCreator();
echo $creator->open() . "\n";
