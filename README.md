# Clydiscope AMA

**A Ruby on Rails document question-answering prototype combining PDF text extraction, local language models, and Bloom's Taxonomy-based question analysis.**

Clydiscope AMA is part of Clydiscope AI Studio, a collection of independent software projects exploring local artificial intelligence, application integration, and efficient AI workflows.

AMA investigates how documents can become interactive sources of information through a modular Ruby application.

## Features

- PDF text extraction using `pdf-reader`
- Document-based question answering
- Integration with a locally hosted Qwen language model
- HTTP and JSON communication using Ruby's standard libraries
- Question complexity scoring based on Bloom's Taxonomy
- Modular service classes separating extraction, analysis, and model communication

## Technology Stack

| Component | Technology |
|---|---|
| Application framework | Ruby on Rails 8.1 |
| Language | Ruby |
| Database | SQLite |
| PDF processing | pdf-reader |
| AI inference | LM Studio / Qwen3 1.7B |
| API communication | Net::HTTP, JSON |
| Question analysis | YAML, regular expressions |
| Frontend foundation | Hotwire, Turbo, Stimulus |

## Architecture

AMA separates its document-processing and AI operations into four service classes.

### 1. PdfExtractor

Reads a PDF document and extracts text from each page using `PDF::Reader`.

### 2. PdfAsker

Coordinates the question-answering workflow.

It extracts document text, checks for empty content, and constructs a prompt containing the document and the user's question.

### 3. AmaResponder

Communicates with a locally hosted Qwen language model through LM Studio.

The service sends an HTTP POST request containing the prompt and parses the model's JSON response.

### 4. ComplexityScorer

Analyzes a question using a configurable Bloom's Taxonomy vocabulary.

The scorer searches for matching verbs and phrases, assigns scores to matched categories, and returns the highest matching score.

This component provides a foundation for future complexity-aware model routing.

## Document Question-Answering Pipeline

```text
PDF Document
     |
     v
PdfExtractor
     |
     v
Extracted Text
     |
     v
PdfAsker + User Question
     |
     v
AmaResponder
     |
     v
Local Qwen Model
     |
     v
Generated Answer
```

The current implementation sends extracted document text directly to the model. Chunking, vector embeddings, semantic retrieval, and source citations are potential future enhancements.

## Question Complexity Analysis

AMA includes an experimental classification system inspired by Bloom's Taxonomy.

The vocabulary is configured in:

`config/bloom_taxonomy.yml`

The `ComplexityScorer` compares question wording against configured verbs and phrases to produce a complexity score.

This explores an important AI engineering question:

**Can a system estimate the difficulty of a request before deciding how much computational power it needs?**

Future development could connect these scores to different language models or processing strategies.

## Local Development

### Requirements

- Ruby matching `.ruby-version`
- Bundler
- SQLite
- LM Studio
- A locally available `qwen/qwen3-1.7b` model

Install dependencies:

```bash
bundle install
```

Prepare the database:

```bash
bin/rails db:prepare
```

Start the Rails development server:

```bash
bin/rails server
```

The current responder expects an LM Studio API endpoint at:

`http://127.0.0.1:1234/api/v1/chat`

The model identifier and endpoint are currently configured directly in `app/services/ama_responder.rb`.

## Testing and Development

The repository includes the standard Rails test infrastructure.

Run the test suite with:

```bash
bin/rails test
```

The current public code includes the service-layer implementation. A complete document upload interface, question-answering controller, and public Q&A routes remain areas for further development.

## Future Development

- Document upload and management
- Chunking and semantic retrieval
- Source-grounded answers and citations
- Persistent document and question histories
- Model routing based on question complexity
- Expanded automated service tests
- Configurable model endpoints and error handling
- Evaluation of response accuracy and inference efficiency

## Project Context

Clydiscope AMA is part of the Clydiscope AI Studio portfolio:

- **Clydiscope Console:** Conversational AI application built with Ruby on Rails
- **Clydiscope AMA:** Document question answering and complexity analysis
- **Clydiscope Fabricator:** Python and Blender-based 3D fabrication API

Together, these projects explore how independent applications, language models, and external services can be combined into practical software systems.

**Developed by Clydiscope AI Studio**

[GitHub Profile](https://github.com/clydiscope)
