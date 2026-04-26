# Record Summary

Aplicativo Android para gravação, transcrição e resumo automático de ligações telefônicas e chamadas WhatsApp.

## Funcionalidades

- Gravação automática de chamadas GSM e chamadas de voz/vídeo do WhatsApp
- Captura de ambos os lados da conversa (requer root)
- Transcrição via Whisper API com diarização por speaker
- Resumo estruturado via LLM (GPT-4o) com extração de tópicos, tarefas, datas e negociações
- Armazenamento local (SQLite)

## Requisitos

- Android 9+ (API 28)
- Device com root (Magisk)
- Permission `CAPTURE_AUDIO_OUTPUT` concedida via Magisk
- `ffmpeg` instalado no device
- API key OpenAI

## Configuração do device (root)

```bash
adb shell pm grant com.lrittes.record_summary android.permission.CAPTURE_AUDIO_OUTPUT
adb shell pm grant com.lrittes.record_summary android.permission.CAPTURE_AUDIO_HOTWORD
```

## Stack

| Camada | Tecnologia |
|---|---|
| UI | Flutter |
| Banco de dados | Drift (SQLite) |
| Gravação de áudio | AudioRecord (VOICE_UPLINK + VOICE_DOWNLINK) |
| Mux estéreo | MediaCodec + MediaMuxer |
| Detecção WhatsApp | AccessibilityService |
| Detecção GSM | TelephonyManager + PhoneStateListener |
| Transcrição | OpenAI Whisper API |
| Resumo | OpenAI GPT-4o |
| Flutter ↔ Native | MethodChannel + EventChannel |

## Arquitetura

```
lib/
├── domain/
│   ├── entities/        # Call, TranscriptionSegment, CallSummary
│   ├── enums/           # CallType, RecordingStatus
│   ├── exceptions/      # TranscriptionException, SummaryException
│   ├── repositories/    # Interfaces CallRepository, TranscriptionRepository, SummaryRepository
│   └── services/        # Interfaces + CallOrchestrator
└── data/
    ├── database/        # AppDatabase (Drift), DAOs
    └── services/        # WhisperTranscriptionService, LlmSummaryService

android/app/src/main/kotlin/com/lrittes/record_summary/
├── MainActivity.kt
├── accessibility/       # CallAccessibilityService
├── boot/                # BootReceiver
├── channel/             # CallStateChannel, CallEventBus
└── recording/           # AudioRecorder, Muxer, RecordingService
```

## Etapas de desenvolvimento

- [x] Etapa 1 — Domain entities, enums, repository interfaces, banco (Drift)
- [x] Etapa 2 — TranscriptionService (Whisper)
- [x] Etapa 3 — SummaryService (GPT-4o)
- [x] Etapa 4 — CallOrchestrator
- [x] Etapa 5 — Native layer (Kotlin)
- [ ] Etapa 6 — Integração Flutter ↔ Native
- [ ] Etapa 7 — UI

## Executar testes

```bash
flutter test --reporter expanded
```

## Build

```bash
flutter build apk --debug
```

## Limitações conhecidas

- Sem root, apenas o microfone local é capturado (sem áudio remoto)
- WhatsApp pode mudar nomes de Activity — `CallAccessibilityService` pode precisar de atualização
