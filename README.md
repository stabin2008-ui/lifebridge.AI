# LifeBridge AI

> *"From human intent to real-world action."*

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![Tests](https://img.shields.io/badge/tests-15%2F15%20passed-success)]()
[![License](https://img.shields.io/badge/license-MIT-blue)]()
[![AI Engine](https://img.shields.io/badge/Gemini-gemini--3.6--flash-orange)]()

**LifeBridge AI** bridges the critical gap between chaotic, unstructured real-world human input and organized, life-critical decision support. When urgent, high-stakes, or confusing situations occur, people express themselves in messy ways—frantic voice notes, blurred camera photos, fragmented text messages, or multi-page documents. LifeBridge AI ingests multimodal inputs, extracts facts, separates user observations from AI inferences, evaluates risks, cross-verifies external grounding, and produces prioritized, real-world action steps.

---

## ⚠️ Important Safety & Ethical Disclaimers

> [!CAUTION]
> **Not a Medical Diagnosis or Treatment Device**: LifeBridge AI is an intelligent information-organizing and decision-support tool. It does **NOT** provide medical diagnosis, clinical treatment plans, or prescription recommendations. Always discuss medical observations with a qualified healthcare professional.

> [!WARNING]
> **No Automated Emergency Dispatch**: LifeBridge AI does **NOT** automatically notify, contact, or dispatch local 911/emergency services. In life-threatening emergencies, users and dispatchers are instructed to call their designated local emergency services telephone number immediately.

---

## 🎯 The Problem

In high-stress situations—such as sudden medical flare-ups, traffic accidents, localized flash flooding, or circulating community panic—real-world input is notoriously messy:
- **High cognitive load**: Eyewitnesses or patients panic, providing rambling or disjointed narratives.
- **Mixed modalities**: Critical clues are scattered across voice notes, smartphone snapshots, medical discharge PDFs, and GPS coordinates.
- **Hallucination risk**: Traditional generative AI often blends assumptions with verified facts, introducing dangerous confabulations into urgent decisions.
- **Action paralysis**: People freeze or take counterproductive steps (such as improperly moving an injured motorcyclist or self-administering contraindicated medications).

## 💡 The Solution

LifeBridge AI transforms chaotic inputs into structured situational intelligence and deterministic action steps:
1. **Multimodal Intake**: Accepts freeform narrative text, voice transcriptions, camera images, uploaded documents/PDFs, and device location context.
2. **Provenance & Fact Separation**: Strictly isolates **User-Reported Facts** (ground truth from the observer) from **AI Inferences** (deductive context), **Verified Grounding** (external facts confirmed via Google Search Grounding), and **Unknown Information** (critical missing pieces).
3. **Risk Stratification**: Classifies risks into `CRITICAL`, `HIGH`, `MEDIUM`, and `LOW` tiers with clear explanations of *why each risk matters*.
4. **Action Engine**: Generates prioritized, sequential instructions with immediate safety measures highlighted first.
5. **Calibrated Confidence**: Computes an algorithmic context completeness score ($0-100\%$) indicating information sufficiency without overstating real-world certainty.

---

## 🌟 Key Features

- 🎙️ **Multimodal Intake Engine**: Live microphone recording with speech-to-text, drag-and-drop image uploads, and document/PDF parsing.
- 🛡️ **Provenance & Epistemic Separation**: 4-column audit trail distinguishing user observations from machine deductions.
- ⚡ **Dual Operational Modes**:
  - **Demo Mode**: 4 pre-calibrated, zero-key deterministic scenarios (Road Accident, Local Inundation, Multi-Visit Medical Records, Public Alert Rumor).
  - **Live Mode**: Real-time multimodal reasoning powered by Google's Gemini models (`gemini-3.6-flash`).
- 🔍 **Real-Time Verification Center**: Direct integration with Google Search Grounding to verify breaking public claims, weather alerts, or official announcements.
- 🚨 **Action Engine**: Numbered, step-by-step guidance separating immediate life-safety actions from follow-up logistics.
- 📊 **Situational Pipeline**: Visual 4-stage pipeline tracker (Intake → Provenance → Risk Assessment → Action Plan).
- 💾 **Local Case History**: Client-side encrypted persistent case storage allowing users and operators to review past assessments offline.
- ♿ **Inclusive & Accessible Design**: Screen-reader-friendly ARIA landmarks, high-contrast dark palette, keyboard-navigable controls, and responsive layouts.

---

## 🏗️ System Architecture

```
                               ┌────────────────────────────────────────┐
                               │             USER / DISPATCHER          │
                               └───────────────────┬────────────────────┘
                                                   │
                        Multimodal Intake (Voice, Text, Image, Document, GPS)
                                                   │
                                                   ▼
┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 FRONTEND (React 18 + Vite SPA)                                    │
│  - Modern Glassmorphic Dark UI (#070B14)                                                          │
│  - Dashboard, Case Results, Verification Center, Action Engine, Situational Pipeline, Case History │
│  - Zero API Key Exposure (Client never sees GEMINI_API_KEY)                                       │
└──────────────────────────────────────────┬────────────────────────────────────────────────────────┘
                                           │
                        Secure HTTPS / REST API (/api/*)
                        (Configurable via VITE_API_URL)
                                           │
                                           ▼
┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 BACKEND (Node.js + Express API)                                   │
│  - Helmet Security Headers (CSP, Frameguard, XSS Protection)                                      │
│  - Configurable Dynamic CORS (Allowing verified domains & local dev)                             │
│  - Express Rate Limiting (60 requests/15 min on /api/analyze)                                     │
│  - 25MB Multimodal Payload Handlers (Base64 Image & Document attachments)                         │
└──────────────────┬───────────────────────────────────────────────┬────────────────────────────────┘
                   │                                               │
                   ▼                                               ▼
┌────────────────────────────────────────┐     ┌────────────────────────────────────────────────────┐
│          DEMO SCENARIO ENGINE          │     │             GEMINI SERVICE ENGINE                  │
│  - 4 Pre-Calibrated Scenarios          │     │  - Model: gemini-3.6-flash                         │
│  - Zero network overhead               │     │  - Strict JSON Schema Validation (Zod)             │
│  - Instant deterministic baseline      │     │  - Google Search Grounding for Public Claims       │
│  - 100% functional without API keys    │     │  - Server-side GEMINI_API_KEY encryption & secrecy │
└────────────────────────────────────────┘     └────────────────────────────────────────────────────┘
```

---

## 🤖 Gemini Model & Safety Integration

- **Model Selection**: Standardized on Google's state-of-the-art **`gemini-3.6-flash`**, delivering low latency, high throughput, and multimodal reasoning capabilities.
- **Strict Structured Outputs**: Uses enforced JSON schemas with Zod runtime validation to guarantee type safety and prevent malformed outputs.
- **Zero API Key Leakage**: The Google Gemini API key is maintained exclusively in server-side environment variables (`GEMINI_API_KEY`). It is **never** bundled into frontend code, browser storage, network responses, or client-side environment configurations.
- **Hallucination Prevention**: The system instruction explicitly commands the model to:
  - Leave `verifiedInformation` strictly empty unless grounded by an active Google Search tool chunk.
  - Distinguish user assertions from inferences.
  - Reject generating fictional medical diagnoses or unverified emergency dispatches.

---

## 🧰 Tech Stack

| Layer | Technologies |
|---|---|
| **Frontend** | React 18, TypeScript, Vite, Tailwind CSS, Lucide Icons, React Router DOM |
| **Backend** | Node.js, Express, TypeScript, `@google/generative-ai` SDK, `@google/genai` |
| **Security** | Helmet (CSP), CORS, `express-rate-limit`, Zod schema validation |
| **Deployment** | Firebase Hosting (Frontend), Render / Google Cloud Run / Docker (Backend) |
| **Testing** | Node.js native test runner (`node:test`, `node:assert`) |

---

## 📁 Project Structure

```
wars/
├── client/                     # Frontend Application
│   ├── index.html              # HTML5 template with SEO metadata & accessibility
│   ├── src/
│   │   ├── components/         # ActionEngine, RiskCard, VerificationCenter, VoiceInput, etc.
│   │   ├── pages/              # LandingPage, DashboardPage, ResultPage, PipelinePage, HistoryPage
│   │   ├── services/           # api.ts (configurable VITE_API_URL), storage.ts
│   │   ├── App.tsx             # Root routing and navigation state
│   │   └── index.css           # Custom styling and theme definitions
│   ├── tailwind.config.js      # Dark slate/cyan clinical theme tokens
│   └── vite.config.ts          # Vite configuration with local /api proxy
├── server/                     # Backend Application
│   ├── src/
│   │   ├── demoScenarios.ts    # 4 deterministic demo scenarios
│   │   ├── geminiService.ts    # Gemini API client & prompt pipeline
│   │   ├── index.ts            # Express server, security headers, CORS & static file serving
│   │   └── types.ts            # TypeScript schemas and interfaces
│   ├── test/
│   │   └── audit-verification.test.js  # 15-point automated audit test suite
│   └── .env.example            # Safe template for server environment variables
├── .firebaserc                 # Firebase project configuration
├── firebase.json               # Firebase Hosting configuration for static SPA
├── render.yaml                 # Render Blueprint for automated fullstack deployment
├── Dockerfile                  # Multi-stage production container definition
├── package.json                # Root orchestration scripts
└── README.md                   # Project documentation
```

---

## 💻 Local Development Setup

### Prerequisites
- Node.js (v18 or higher recommended)
- npm (v9 or higher)
- *(Optional)* Google Gemini API key from [Google AI Studio](https://aistudio.google.com/) for Live Mode.

### 1. Clone & Install Dependencies
```bash
git clone https://github.com/stabin2008-ui/lifebridge.AI.git
cd lifebridge.AI

# Install dependencies for both root, client, and server
npm run install:all
```

### 2. Configure Backend Environment
Create a `.env` file inside the `server/` directory:
```bash
cp server/.env.example server/.env
```

Edit `server/.env`:
```env
PORT=3001
GEMINI_API_KEY=your_real_gemini_api_key_here
CLIENT_URL=http://localhost:5173
```
*(If no API key is provided, the platform seamlessly defaults to Demo Mode).*

### 3. Run Locally in Development Mode
Start both services in parallel:

**Start Express Server (Terminal 1):**
```bash
npm run dev:server
# Running at http://localhost:3001
```

**Start Vite Frontend (Terminal 2):**
```bash
npm run dev:client
# Running at http://localhost:5173 (proxies /api requests to localhost:3001)
```

Visit `http://localhost:5173` to experience LifeBridge AI.

---

## 🧪 Testing & Quality Audit

The repository contains an automated 15-point audit verification suite that validates critical security, error resilience, and epistemic boundaries:

```bash
# Build the server and run the test suite
cd server
npm test
```

### Verified Audit Matrix (15 / 15 Passing):
1. ✅ `/api/health` returns HTTP 200 with zero secret leakage.
2. ✅ Demo endpoint returns deterministic data across all 4 scenarios.
3. ✅ Demo mode never invokes the Gemini API.
4. ✅ Live mode maintains strict provenance and schema adherence.
5. ✅ Gemini output conforms to Zod validation schema.
6. ✅ Malformed Gemini responses safely fall back without throwing errors.
7. ✅ Missing `GEMINI_API_KEY` returns a graceful HTTP 503 rather than crashing.
8. ✅ `GEMINI_API_KEY` is NEVER exposed in headers, body, or error messages.
9. ✅ Output never falsely claims emergency dispatch or hardcodes numbers.
10. ✅ Output never delivers medical diagnoses or prescription changes.
11. ✅ `verifiedInformation` remains empty unless verified via external grounding.
12. ✅ Calibrated confidence score is strictly bounded ($0-100$).
13. ✅ Empty input payloads are rejected with HTTP 400.
14. ✅ Oversized input payloads (>50,000 characters) are rejected with HTTP 400.
15. ✅ Rate-limiting headers are strictly enforced on `/api/analyze`.

---

## 🚀 Production Deployment

### Frontend (Firebase Hosting)
The compiled static React application can be deployed directly to Google Firebase Hosting:
```bash
# 1. Build the production frontend bundle
cd client && npm run build

# 2. Deploy to Firebase
cd ..
firebase deploy --only hosting
```
Public URL: `https://lifebridge-ai-stabin-202-81bd3.web.app`

### Backend Options (Express + Gemini)
The Node.js backend requires a server environment to keep the `GEMINI_API_KEY` secure:

#### Option A: Render (One-Click Blueprint)
The repository includes a ready-to-use [`render.yaml`](./render.yaml).
1. Connect your repository on [Render](https://render.com).
2. Render detects `render.yaml` and builds the service automatically.
3. Enter your secret `GEMINI_API_KEY` in the Render Environment dashboard.

#### Option B: Google Cloud Run (Containerized)
Using the included multi-stage [`Dockerfile`](./Dockerfile):
```bash
gcloud run deploy lifebridge-ai \
  --source . \
  --platform managed \
  --set-env-vars "NODE_ENV=production" \
  --set-secrets "GEMINI_API_KEY=GEMINI_API_KEY:latest" \
  --allow-unauthenticated
```

#### Option C: Unified Fullstack Server
When the server starts with co-located `client/dist`, Express serves both the static React frontend and the `/api/*` endpoints under one port. Simply run:
```bash
npm run build
npm start
```

---

## 🔒 Security & Privacy Architecture

- **Zero Client-Side Secrets**: No API keys are embedded in frontend source code, Vite bundles, or client environment variables.
- **Content Security Policy**: Hardened Helmet headers with restricted script, connect, and style directives.
- **Strict Origin Validation**: Dynamic CORS filtering allowing only explicitly verified origins.
- **DoS Protection**: IP-based rate limiting on intensive AI analysis endpoints.
- **Safe Error Handling**: Error interceptors sanitize all internal exceptions and stack traces before responding to clients.

---

## ♿ Accessibility (A11y)

- High-contrast visual indicators (WCAG AA compliant color contrast).
- Accessible form labels and ARIA descriptive attributes on interactive tabs.
- Full keyboard navigability across input tabs, scenario selectors, and action items.
- Motion-reduced transitions for comfortable reading during stressful situations.

---

## 🏆 Hackathon Alignment & Impact

LifeBridge AI was engineered to showcase practical, safety-first generative AI:
- **Societal Value**: Provides immediate clarity and reduces panic during confusing situations.
- **Responsible AI**: Adheres to rigorous epistemic honesty—refusing to present inferences as confirmed facts.
- **Technical Polish**: Production-ready architecture featuring complete test coverage, Dockerization, security headers, and zero secret leakage.

---

## 📄 License

This project is licensed under the MIT License — see the LICENSE file for details.
