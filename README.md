# 🛡️ ReviewGuard — AI-Powered Fake Product Review Detection System

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.11-3776AB?logo=python&logoColor=white" alt="Python 3.11" />
  <img src="https://img.shields.io/badge/Flask-3.1-000000?logo=flask&logoColor=white" alt="Flask 3.1" />
  <img src="https://img.shields.io/badge/scikit--learn-1.7-F7931E?logo=scikit-learn&logoColor=white" alt="scikit-learn" />
  <img src="https://img.shields.io/badge/NLP-TF--IDF-blue" alt="NLP TF-IDF" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License: MIT" />
</p>

---

**ReviewGuard** is a full-stack Machine Learning and Natural Language Processing (NLP) web application that detects fraudulent, computer-generated, and synthetic product reviews in real time. Built upon an empirical corpus of **40,432 labeled multi-category reviews**, ReviewGuard analyzes linguistic and syntactic markers to deliver accurate classifications, probability distributions, and confidence scoring in under 30 milliseconds.

---

## 📑 Table of Contents

- [Key Features](#-key-features)
- [System Architecture](#-system-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Machine Learning Pipeline](#-machine-learning-pipeline)
- [Quick Start: Run Locally](#-quick-start-run-locally)
- [REST API Reference](#-rest-api-reference)
- [Documentation & Presentation](#-documentation--presentation)
- [Global Deployment](#-global-deployment)
- [Engineering Limitations](#-engineering-limitations)
- [Roadmap](#-roadmap)
- [License](#-license)

---

## ✨ Key Features

| Feature | Description |
|---|---|
| **Real-Time Classification** | Sub-30ms inference via trained TF-IDF vectorizer and Logistic Regression classifier |
| **Probability Telemetry** | Returns explicit genuine vs. fake probability breakdowns (0–100%) |
| **Three-Tier Uncertainty Guard** | Distinguishes between **Genuine** ($<45\%$), **Uncertain** ($45\text{--}55\%$), and **Fake** ($>55\%$) |
| **Full-Stack Web Interface** | Modern glassmorphism UI with live character count, animated confidence bar, and statistics |
| **Dark / Light Theme** | User preference toggle persisted across sessions via browser `localStorage` |
| **Decoupled REST API** | Clean JSON endpoints (`/api/predict`, `/api/health`) for e-commerce pipeline integration |
| **Production Ready** | Pre-configured with `Procfile`, `runtime.txt`, and Gunicorn for 1-click cloud deployment |

---

## 🏗 System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Client Layer                           │
│  Browser UI (HTML5 / CSS3 / ES6 JS)  •  Mobile-Responsive  │
└──────────────────────────────┬──────────────────────────────┘
                               │  POST /api/predict (JSON)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                  Flask Web Application                      │
│                                                             │
│  1. Ingest review payload & validate (≤ 10,000 characters) │
│  2. Normalize text: Lowercase, HTML strip, URL filter       │
│  3. Vectorize: TF-IDF feature space projection              │
│  4. Inference: Logistic Regression log-odds scoring         │
│  5. Calibration: Sigmoid probability calculation            │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                     Response Payload                        │
│  { "prediction": "GENUINE", "confidence": 96.1,             │
│    "fake_probability": 3.9, "genuine_probability": 96.1 }   │
└─────────────────────────────────────────────────────────────┘
```

---

## 🧰 Tech Stack

* **Backend Framework:** Python 3.11.9, Flask 3.1.2, Flask-CORS 6.0.1, Gunicorn 23.0.0
* **Machine Learning & NLP:** scikit-learn 1.7.2, joblib 1.5.2, NumPy 2.2.6, SciPy 1.16.2
* **Frontend:** Semantic HTML5, Vanilla CSS3 (Custom Design System, Inter typography), Modern ES6 JavaScript
* **DevOps / Deployment:** Git, Render, Railway, Heroku, Docker-ready

---

## 📁 Project Structure

```text
Review_Guard/
├── backend/
│   └── app.py                                   # Flask web server, API routes, inference engine
├── frontend/
│   ├── templates/
│   │   └── index.html                           # Single-page web application UI
│   └── static/
│       ├── css/
│       │   └── style.css                        # Design system, dark/light themes, responsiveness
│       └── js/
│           └── app.js                           # Asynchronous fetch, DOM rendering, theme controller
├── model/
│   ├── logistic_regression_model.joblib         # Serialized classifier (~480 KB)
│   └── tfidf_vectorizer.joblib                 # Fitted TF-IDF feature transformer (~2.3 MB)
├── fake_reviews_dataset/
│   └── fake reviews dataset.csv                # Benchmark training dataset (40,432 entries)
├── docs/
│   └── SRS_Report.md                            # Comprehensive IEEE-adapted Software Requirements Spec
├── presentation/
│   ├── Presentation_Master_Deck.md              # 14-slide master coordination outline for 3 presenters
│   ├── Presenter_1_Problem_Data_Architecture.md # Script & viva defense cheat sheet for Speaker 1
│   ├── Presenter_2_ML_NLP_Algorithms.md         # Script & viva defense cheat sheet for Speaker 2
│   └── Presenter_3_Implementation_Demo_FutureScope.md # Script & viva defense cheat sheet for Speaker 3
├── Fake_Review_Detection.ipynb                 # End-to-end data science research & training notebook
├── requirements.txt                             # Locked production dependencies
├── Procfile                                     # Cloud WSGI startup specification
├── runtime.txt                                  # Python 3.11.9 environment specification
├── run_locally.bat                              # One-click Windows launch script
└── README.md                                    # Project documentation
```

---

## 🧠 Machine Learning Pipeline

### 1. Dataset Breakdown
* **Total Reviews:** 40,432 (40,420 post-deduplication)
* **Class Distribution:** Balanced 50/50 split
  * `OR` (Original / Human-Authored): 20,215 reviews (50.01%)
  * `CG` (Computer-Generated / Synthetic): 20,205 reviews (49.99%)
* **Domain Diversity:** 10 distinct product categories (Kindle Store, Books, Pet Supplies, Home & Kitchen, Electronics, Sports, Tools, Clothing, Toys, Movies & TV).

### 2. Text Normalization Pipeline (`clean_text`)
```python
def clean_text(text):
    text = str(text).lower()
    text = re.sub(r"<.*?>", " ", text)        # Strip HTML tags
    text = re.sub(r"http\S+|www\S+", " ", text) # Strip hyperlinks
    text = re.sub(r"[^a-z0-9\s]", " ", text)  # Keep alphanumeric & whitespace
    text = re.sub(r"\s+", " ", text).strip()  # Normalize whitespace
    return text
```

### 3. Feature Extraction (TF-IDF) & Mathematical Formulation
Each document $d$ is projected into high-dimensional vector space using Term Frequency-Inverse Document Frequency followed by $L_2$ Euclidean normalization:
$$\text{TF-IDF}(t, d) = \text{TF}(t, d) \times \left( \ln\left( \frac{1 + N}{1 + \text{DF}(t)} \right) + 1 \right)$$

### 4. Classification & Three-Tier Calibration
Posterior probability is computed via the Sigmoid function with arithmetic bounding:
$$P(Y=1|\mathbf{x}) = \frac{1}{1 + e^{-(\mathbf{w}^T \mathbf{x} + b)}}$$

Instead of a naive binary cutoff at 0.50, ReviewGuard introduces an uncertainty margin:
* **$P(\text{Fake}) > 0.55$** $\rightarrow$ **FAKE / SUSPICIOUS** (Red badge)
* **$0.45 \le P(\text{Fake}) \le 0.55$** $\rightarrow$ **MEDIUM / UNCERTAIN** (Amber badge)
* **$P(\text{Fake}) < 0.45$** $\rightarrow$ **GENUINE** (Green badge)

---

## 🚀 Quick Start: Run Locally

### Option A: One-Click Windows Launcher
Double-click [`run_locally.bat`](run_locally.bat). It will initialize the environment, start the Flask server, and automatically launch your browser.

### Option B: Terminal Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/24jajook1-sys/Fake-review-ML.git
   cd Fake-review-ML
   ```

2. **Create and activate virtual environment:**
   ```bash
   # Windows (PowerShell)
   python -m venv venv
   .\venv\Scripts\activate

   # Linux / macOS
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Launch the web application:**
   ```bash
   python -m backend.app
   ```

5. **Open your browser:**
   Navigate to `http://127.0.0.1:5000`

---

## 📡 REST API Reference

### 1. Health Liveness Check
* **Endpoint:** `GET /api/health`
* **Response (`200 OK`):**
  ```json
  {
    "status": "ok",
    "model_loaded": true,
    "vectorizer_loaded": true
  }
  ```

### 2. Predict Review Authenticity
* **Endpoint:** `POST /api/predict`
* **Headers:** `Content-Type: application/json`
* **Body:**
  ```json
  {
    "review": "The product arrived on time and was well packaged. Fits nicely in our cabinet."
  }
  ```
* **Response (`200 OK`):**
  ```json
  {
    "class": "genuine",
    "prediction": "GENUINE",
    "confidence": 96.07,
    "genuine_probability": 96.07,
    "fake_probability": 3.93,
    "review_length": 81,
    "word_count": 16
  }
  ```

---

## 📚 Academic Documentation & Presentation

This repository includes comprehensive documentation prepared for academic defense and institutional evaluation:

* **[Software Requirements Specification (SRS Report)](docs/SRS_Report.md):** Formal IEEE-standard technical specification detailing mathematical proofs, functional/non-functional requirements, failure modes, and professor viva examination defenses.
* **[Master Presentation Deck](presentation/Presentation_Master_Deck.md):** 14-slide master coordination guide for a 3-person team presentation.
* **[Presenter 1 Guide](presentation/Presenter_1_Problem_Data_Architecture.md):** Problem statement, astroturfing impact, dataset EDA, and architecture.
* **[Presenter 2 Guide](presentation/Presenter_2_ML_NLP_Algorithms.md):** NLP sanitization, TF-IDF mathematics, classifier benchmarking, and probability calibration.
* **[Presenter 3 Guide](presentation/Presenter_3_Implementation_Demo_FutureScope.md):** Full-stack web engineering, live demo script, shortcomings, and future roadmap.

---

## 🌐 Global Deployment

The project is pre-configured for instant cloud deployment:

### Deploy to Render (Recommended)
1. Fork or push this repository to your GitHub account.
2. In [Render](https://render.com), select **New + $\rightarrow$ Web Service**.
3. Connect your repository. Render will automatically detect:
   * **Runtime:** Python (`runtime.txt` $\rightarrow$ 3.11.9)
   * **Build Command:** `pip install -r requirements.txt`
   * **Start Command:** `gunicorn backend.app:app` (from `Procfile`)
4. Click **Deploy Web Service**.

---

## ⚠️ Engineering Limitations

1. **Reviewer Metadata Absence:** The system evaluates review text in isolation without account longevity, verified purchase badges, or posting frequency.
2. **Context & Sarcasm:** Frequency-based n-gram representations struggle to model complex irony or inverted sentiment.
3. **Frontier LLM Phrasing:** Advanced generative models (e.g., GPT-4, Claude 3.5) instructed to include casual human typos can reduce n-gram detection confidence.

---

## 🗺️ Roadmap

- [ ] **Transformer Migration:** Benchmark and integrate fine-tuned lightweight DeBERTa-v3 / RoBERTa models.
- [ ] **Graph Neural Networks (GNNs):** Model reviewer-product bipartite graphs to detect coordinated bot syndicates.
- [ ] **Explainable AI (XAI):** Integrate SHAP and LIME to highlight suspicious tokens directly in the UI.
- [ ] **Browser Extension:** Manifest V3 Chrome extension for automated real-time Amazon and Flipkart overlays.

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.