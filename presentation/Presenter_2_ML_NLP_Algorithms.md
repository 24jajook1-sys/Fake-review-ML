# PRESENTER 2: NLP PREPROCESSING, MATHEMATICAL MODELING & CLASSIFIERS
**Presenter Name:** [Insert Member 2 Name]  
**Assigned Slides:** Slide 5, Slide 6, Slide 7, Slide 8  
**Speaking Duration:** ~4 Minutes  
**Key Responsibilities:** Explain the technical heart of the project — text cleaning, TF-IDF mathematical formulas, machine learning benchmarks, why Logistic Regression was selected, and probability calibration.

---

## 🎤 Detailed Slide-by-Slide Script & Delivery Notes

### SLIDE 5: NLP Text Cleaning & Preprocessing Pipeline
* **Slide Elements:**
  - Preprocessing flow: Raw Text $\rightarrow$ Lowercasing $\rightarrow$ HTML Strip $\rightarrow$ URL Removal $\rightarrow$ Non-Alphanumeric Filtering $\rightarrow$ Whitespace Normalization.
  - Python code snippet of `clean_text(text)`.
  - Explanation of why test-time cleaning MUST match training-time cleaning.
* **Exact Script to Speak:**
  > *"Thank you, **[Presenter 1's Name]**. Good morning professors and colleagues. I will now explain the Natural Language Processing and algorithmic core of ReviewGuard.*
  >
  > *Raw consumer reviews are notoriously messy: they contain embedded HTML tags, promotional hyperlinks, irregular capitalization, emojis, and arbitrary punctuation.*
  >
  > *To ensure our model evaluates genuine linguistic content rather than superficial web artifacts, we designed a deterministic cleaning function called `clean_text`. As shown on Slide 5, this function executes five sequential operations:*
  > 1. *It casts all text to lowercase, ensuring 'EXCELLENT' and 'excellent' map to identical vector tokens.*
  > 2. *It removes HTML tags using regular expression parsing.*
  > 3. *It strips web URLs (`http` and `www` links) frequently embedded in spam reviews.*
  > 4. *It eliminates non-alphanumeric characters, retaining only letters, digits, and spaces.*
  > 5. *It collapses redundant multi-whitespace sequences.*
  >
  > *Crucially, this exact function is maintained across both our training pipeline in Jupyter and our live Flask production backend. Any drift or divergence between training and runtime preprocessing would invalidate the vocabulary matrix and corrupt our predictions."*

---

### SLIDE 6: Feature Extraction — TF-IDF Vectorization & Mathematics
* **Slide Elements:**
  - Formula for Term Frequency: $\text{TF}(t, d) = \frac{f_{t,d}}{\sum f}$
  - Formula for Inverse Document Frequency: $\text{IDF}(t) = \ln\left(\frac{1+N}{1+\text{DF}(t)}\right) + 1$
  - Final $\text{TF-IDF} = \text{TF} \times \text{IDF}$ with $L_2$ Euclidean normalization.
  - Vocabulary dimension and sparsity advantages.
* **Exact Script to Speak:**
  > *"Machine learning classifiers cannot process raw strings; they require numerical vectors. To represent each review in high-dimensional space, we utilize **TF-IDF** — Term Frequency-Inverse Document Frequency.*
  >
  > *Slide 6 presents the mathematical formulation:*
  > - *First, **Term Frequency** measures how often a word occurs within a specific review. Frequent mentions indicate relevance to that text.*
  > - *Second, **Inverse Document Frequency** penalizes common ubiquitous words across the entire corpus of 40,000 reviews — such as 'the', 'is', 'product', or 'item'. The logarithm scales down these uninformative terms, elevating distinctive words that carry discriminative signal.*
  > - *Finally, each document vector undergoes **$L_2$ Euclidean normalization**, ensuring that long reviews do not artificially dominate short reviews purely based on word count.*
  >
  > *This creates a highly informative, sparse feature matrix that captures nuanced vocabulary distributions without the immense parameter overhead of deep neural networks."*

---

### SLIDE 7: Model Benchmarking & Selection Rationale
* **Slide Elements:**
  - Comparative Table:
    - **Logistic Regression (Selected)**: Fast inference, calibrated probabilities, interpretable weights, highly resistant to overfitting.
    - **Multinomial Naive Bayes**: Good baseline, but strong independence assumption hinders complex phrase context.
    - **Linear SVC**: Strong margin classification, but lacks native posterior probability calibration.
    - **Random Forest**: Computationally heavy, slower inference time, larger memory footprint on disk.
* **Exact Script to Speak:**
  > *"During model exploration, we benchmarked four distinct supervised classifiers in our notebook:*
  > 1. *Multinomial Naive Bayes*
  > 2. *Linear Support Vector Classifier (LinearSVC)*
  > 3. *Random Forest with GridSearchCV*
  > 4. *Logistic Regression*
  >
  > *While Naive Bayes provided a solid baseline, its conditional independence assumption failed to model word co-occurrence dynamics. LinearSVC achieved a competitive decision boundary, but it computes uncalibrated geometric margins rather than true posterior probabilities.*
  >
  > *We selected **Logistic Regression** for our production engine for three decisive engineering reasons:*
  > - *First, **Mathematical Interpretability**: In Logistic Regression, each parameter weight $w_j$ represents the log-odds impact of that term. This makes our model auditable and transparent.*
  > - *Second, **Native Probability Calibration**: It naturally outputs continuous log-odds that map into smooth confidence curves via the Sigmoid function.*
  > - *Third, **Extreme Efficiency**: With a serialized footprint of under 500 Kilobytes and sub-20ms inference time on standard CPUs, it is ideal for scalable cloud microservices."*

---

### SLIDE 8: Decision Boundary & Three-Tier Confidence Calibration
* **Slide Elements:**
  - Sigmoid activation curve: $P(Y=1|\mathbf{x}) = \frac{1}{1 + e^{-z}}$
  - Clamping function to prevent exponential overflow ($\pm 35$).
  - Diagram of the 3-Tier Threshold:
    - $[0.00, 0.45) \rightarrow$ **GENUINE** (Green)
    - $[0.45, 0.55] \rightarrow$ **MEDIUM / UNCERTAIN** (Amber)
    - $(0.55, 1.00] \rightarrow$ **FAKE / SUSPICIOUS** (Red)
* **Exact Script to Speak:**
  > *"Standard academic ML demos often make a critical mistake: they apply a rigid 50% binary cutoff. A review with 50.1% fake probability is declared fake, while 49.9% is declared genuine. In real-world applications, this creates false confidence on borderline texts.*
  >
  > *As shown on Slide 8, ReviewGuard implements a **three-tier calibrated threshold** backed by the Sigmoid function:*
  > - *If the model computes a synthetic probability greater than **55%**, it classifies the review as **FAKE / SUSPICIOUS**.*
  > - *If the probability falls below **45%**, it classifies it as **GENUINE**.*
  > - *Crucially, if the probability falls between **45% and 55%**, the review enters an **UNCERTAIN / MEDIUM** buffer zone. This flags the review for manual administrative review or secondary verification rather than making a high-stakes false accusation.*
  >
  > *Furthermore, we implemented numerical boundary clamping at $\pm 35$ in our logit score to guarantee arithmetic stability against exponential overflow.*
  >
  > *Now that we have explored the algorithmic and mathematical foundation, I will hand over to **[Presenter 3's Name]**, who will showcase our full-stack web deployment, conduct a live system demo, discuss system limitations, and present our future roadmap."*

---

## 🎯 Presenter 2: Viva & Professor Q&A Cheat Sheet

| Likely Professor Question | Your Direct, Confident Answer |
|---|---|
| **"Why did you use TF-IDF instead of modern Word2Vec or GloVe embeddings?"** | *"Word2Vec and GloVe provide dense semantic representations, but for document-level classification with linear models, average word vector pooling dilutes distinctive keywords. TF-IDF explicitly amplifies rare, discriminative tokens (like repetitive promotional superlatives) that are characteristic of computer-generated spam."* |
| **"How does Logistic Regression avoid overfitting on high-dimensional TF-IDF vectors?"** | *"We utilize $L_2$ Ridge regularization within the loss function ($J(\mathbf{w}) = \text{Loss} + \frac{1}{2C}\|\mathbf{w}\|_2^2$). This adds a penalty on the squared magnitude of coefficients, shrinking unimportant weights towards zero and ensuring the model does not memorize rare noise words."* |
| **"What loss function is used to train your Logistic Regression model?"** | *"The model is trained by minimizing the Regularized Binary Cross-Entropy (Log-Loss) function using stochastic or quasi-Newton optimization (L-BFGS), iteratively adjusting weights to maximize log-likelihood over the 40,000 training examples."* |
| **"What happens if a user submits a review in French or Spanish?"** | *"Because our training corpus and TF-IDF vocabulary are English-based, non-English words will map to zero feature weights (Out of Vocabulary). The model's logit score would gravitate toward the prior bias, likely triggering our 0.45–0.55 'Medium / Uncertain' safety buffer."* |
