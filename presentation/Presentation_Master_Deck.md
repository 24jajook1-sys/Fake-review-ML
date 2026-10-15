# REVIEWGUARD: MASTER PRESENTATION SLIDE DECK & TEAM SYNC
## Collaborative Defense & Presentation Guide for 3-Member Team
**Total Duration:** 15 Minutes (10–12 Mins Speaking + 3–5 Mins Viva Q&A)  
**Distribution:** 4–5 Minutes per Presenter  

---

## 👥 Presenter Roles & Division of Work

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       PRESENTER 1: PROBLEM & FOUNDATION                     │
│  • Project Overview & Real-World Motivation                                │
│  • The Crisis of Review Fraud in E-Commerce                                │
│  • Dataset Analysis (40,432 Amazon Reviews, 10 Categories)                  │
│  • System Architecture & High-Level Data Flow                               │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Smooth Hand-off)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                   PRESENTER 2: NLP & MACHINE LEARNING CORE                  │
│  • Text Sanitization & Preprocessing Logic (clean_text)                     │
│  • Feature Extraction: TF-IDF Vectorization & Mathematics                   │
│  • Machine Learning Models Benchmark (LR, Naive Bayes, LinearSVC, RF)       │
│  • Probability Calibration & The 3-Tier Classification Threshold            │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Smooth Hand-off)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                 PRESENTER 3: IMPLEMENTATION, DEMO & ROADMAP                 │
│  • Full-Stack Architecture (Flask, REST API, Vanilla UI)                    │
│  • Live Demonstration Walkthrough (Genuine, Fake, Uncertain Reviews)        │
│  • Critical Shortcomings & Engineering Trade-offs                           │
│  • Future Scope (Transformers, GNNs, Browser Extension) & Conclusion        │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 📊 Complete Slide Outline (14 Slides)

| Slide # | Slide Title | Speaker | Allocated Time | Key Focus |
|---|---|---|---|---|
| **Slide 1** | Title & Team Introduction | Presenter 1 | 0:30 | Project Name, Team Members, Faculty Guide |
| **Slide 2** | Problem Statement & Industry Motivation | Presenter 1 | 1:15 | Astroturfing, financial loss, consumer trust |
| **Slide 3** | Dataset Ingestion & Exploratory Analysis | Presenter 1 | 1:30 | 40,432 reviews, 10 categories, 50/50 balance |
| **Slide 4** | High-Level System Architecture | Presenter 1 | 1:15 | Client $\rightarrow$ Flask $\rightarrow$ TF-IDF $\rightarrow$ ML Model |
| **Slide 5** | NLP Preprocessing Pipeline | Presenter 2 | 1:00 | RegEx, HTML stripping, noise removal |
| **Slide 6** | Feature Extraction: TF-IDF Mathematics | Presenter 2 | 1:15 | Term Frequency, Inverse Doc Frequency, Sparsity |
| **Slide 7** | Model Comparison & Classifier Selection | Presenter 2 | 1:15 | Why Logistic Regression won over Naive Bayes/SVM |
| **Slide 8** | Decision Boundaries & Probability Calibration | Presenter 2 | 1:00 | Sigmoid function, 0.45-0.55 uncertainty buffer |
| **Slide 9** | Full-Stack Engineering & API Design | Presenter 3 | 1:00 | Flask microservice, `/api/predict`, CORS, Gunicorn |
| **Slide 10** | Live System Demonstration | Presenter 3 | 1:30 | Real-time review evaluation on localhost |
| **Slide 11** | Engineering Shortcomings & Failure Modes | Presenter 3 | 1:15 | Metadata absence, modern LLM evasion, sarcasm |
| **Slide 12** | Future Scope & Industrial Roadmap | Presenter 3 | 1:00 | DeBERTa transformers, GNNs for bot rings |
| **Slide 13** | Conclusion & Key Takeaways | Presenter 3 | 0:30 | Summary of accomplishments |
| **Slide 14** | Acknowledgements & Viva Q&A | All Team | 3:00+ | Questions from Professor and Jury |

---

## 🔄 Verbal Transition Cues Between Presenters

### Hand-off 1 (Presenter 1 ➔ Presenter 2):
> *"Now that we have established the operational challenge, our empirical dataset, and the system architecture, I will hand over to **[Presenter 2's Name]**, who will walk you through the natural language processing pipeline, the mathematical vectorization, and our machine learning classifier evaluation."*

### Hand-off 2 (Presenter 2 ➔ Presenter 3):
> *"With our statistical decision boundary calibrated and our model serialized, we needed a robust software deployment to bring this intelligence to everyday users. I will now invite **[Presenter 3's Name]** to demonstrate our full-stack web application, present the live software demo, discuss current system shortcomings, and outline our future roadmap."*

---

## ⚡ Golden Rules for the Presentation
1. **Never read slides verbatim:** Slides should contain concise bullet points, charts, and diagrams; speak to the rationale and implications.
2. **Support your teammates during Q&A:** If a professor directs a question to the group, the member whose topic it belongs to should step up first, but teammates can briefly supplement.
3. **Acknowledge limitations proactively:** Professors respect students who openly state shortcomings (e.g., lack of reviewer metadata) before being probed.
