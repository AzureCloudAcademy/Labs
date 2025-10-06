# 🛒 Redish

**Redis-powered grocery e-commerce with intelligent shopping assistance.**

Redish is an AI-powered grocery shopping platform that combines Redis's speed with LangGraph's intelligent workflow orchestration. Get personalized recipe recommendations, smart product suggestions, and lightning-fast responses through semantic caching.

## App screenshots

![App home page](./screenshots/home-screen.png)

---

## Product Features

- **Smart Grocery Shopping**: AI-powered assistant helps you find ingredients, discover recipes, and manage your cart
- **Product Search**: Both text and vector-based search across grocery products with embeddings
- **Recipe Intelligence**: Get ingredient lists with suggested products for any recipe
- **Cart Management**: Add, view, and manage shopping cart items

---

## Tech Stack

- **Node.js** + **Express** (Backend API)
- **Redis** (Product store, conversational history, and semantic caching with LangCache)
- **LangGraph** (AI workflow orchestration)
- **OpenAI API** (GPT-4 for intelligent responses)
- **HTML + CSS + Vanilla JS** (Frontend)

---

## Getting Started

### Prerequisites

- **OpenAI API Key**: [Create an API key](https://platform.openai.com/account/api-keys)
- **Redis LangCache API**: [Get LangCache credentials](https://redis.io/langcache/)

### Clone this repository

```bash
git clone https://github.com/redis-developer/Redish.git
cd Redish
```

### Configure environment variables

Create a `.env` file at the root:

```bash
APP_NAME="Redish"
SERVER_PORT=3000

OPENAI_API_KEY=your_openai_api_key

REDIS_URL=your_redis_connection_string

LANGCACHE_API_KEY="your_langcache_api_key"
LANGCACHE_API_BASE_URL="your_langcache_api_base_url"
LANGCACHE_CACHE_ID="your_langcache_cache_id"

MODEL_NAME="gpt-4o-mini"

# For tracing with Langsmith
LANGSMITH_TRACING="true"
LANGSMITH_ENDPOINT="your_langsmith_endpoint"
LANGSMITH_API_KEY="your_langsmith_api_key"
LANGSMITH_PROJECT="your_langsmith_project"

```

📝 Make sure to replace these placeholders with your real values before running the app.

### Option 1: Manual installation

#### ✅ Prerequisites

- **Node.js (v18 or higher)**: [Download & Install Node.js](https://nodejs.org/)
- **Redis**: You can either:
  - Install Redis locally: [Redis installation guide](https://redis.io/docs/getting-started/installation/)
  - Use Docker: `docker run --name redish-redis -p 6379:6379 redis:8.0`
  - Use [Redis Cloud](https://redis.io) (no installation required)

#### ✅ Setup

1. Install dependencies:
   ```bash
   npm install
   ```

2. Load sample grocery data:
   ```bash
   npm run load-products
   ```

3. Start the server:
   ```bash
   npm start
   ```

### Option 2: 🐳 Run with Docker Compose

Skip manual setup and run everything using Docker:

```bash
docker compose up
```

To stop the containers:

```bash
docker compose down -v
```

### Access the app

Visit http://localhost:3000 in your browser (or use the port specified in `.env`).

---

## AI Features

- **Recipe Ingredients**: Ask for ingredients for any recipe and get suggested products
- **Product Search**: Find products by name, category, or description
- **Smart Recommendations**: AI suggests alternatives and complementary items
- **Cart Management**: Add, remove, and view cart items through natural conversation

## Technical features

- **Semantic Cache**: Similar queries return instantly using Redis LangCache
- **Vector Search**: Find products using AI-powered similarity search
- **Redis as memory layer**: for fast data retrieval
- **LangGraph Workflows**:  AI agent routing, tool selection
- **Multi-tool Agent**: Recipe tools, search tools, cart tools, and knowledge tools

---

## Architecture

The grocery agent uses a LangGraph-powered AI agent that routes requests through specialized tools.

1. **Cache Check**: First checks Redis semantic cache for similar queries
2. **AI Agent**: Routes to appropriate tools based on request type
3. **Specialized Tools**: Recipe ingredients, product search, cart operations, direct answers
4. **Services Layer**: Product, cart, and chat services
5. **Redis Storage**: Vector embeddings, semantic cache, and session data

![Technical architecture](./technical-diagrams/architecture-overview.png)

![Technical architecture - expanded](./technical-diagrams/mermaid-flowchart.svg)

### Project architecture

```
services/
  ├── products/                # Product Business Component
  │   ├── api/                    # REST API endpoints
  │   ├── domain/                 # Business logic
  │   └── data/                   # Data access layer
  ├── cart/                    # Cart Business Component
  │   ├── api/
  │   ├── domain/
  │   └── data/
  ├──chat/                     # Chat/Cache Business Component
  │   ├── api/
  │   ├── domain/
  │   └── data/
  ├── ai/grocery-ai-agent/     # AI Agent
  │   ├── tools.js                # API/Interface Layer
  │   ├── nodes.js                # Agent Logic
  │   ├── index.js                # Orchestration
  │   └── state/                  # Data Access
```
---

## API Endpoints

- `POST /api/chat` - Main chat interface for AI shopping assistant
- `GET /api/products/search` - Search products with text/vector similarity
- `POST /api/cart/add` - Add items to shopping cart
- `GET /api/cart` - View cart contents
- `DELETE /api/cart` - Clear cart

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🐞 Reporting Issues

If you find a bug or have a feature request, [open an issue](https://github.com/redis-developer/Redish/issues).