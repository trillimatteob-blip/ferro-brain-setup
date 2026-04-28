# ferro-brain-setup

Setup pubblico per i soci di **Salute Di Ferro** che accedono al vault Obsidian aziendale `Ferro-Brain-Team`.

---

## 🚀 Quick start

### macOS — comando one-shot

```bash
curl -fsSL https://raw.githubusercontent.com/trillimatteob-blip/ferro-brain-setup/main/install.sh | bash
```

Apri il **Terminale** (Cmd+Spazio → "Terminale" → Invio), incolla, premi Invio.
Tempo: **~10 minuti**.

### Windows / Linux — usando Claude Code

Vedi la guida dettagliata: **[ONBOARDING-WINDOWS-LINUX.md](./ONBOARDING-WINDOWS-LINUX.md)**

In sintesi:
1. Installa **Claude Code** da [claude.com/download](https://claude.com/download)
2. Login: `claude login` (con account `@salutediferro.com`)
3. Apri sessione: `claude`
4. Incolla il prompt che trovi nella guida → Claude esegue il setup nativo

Tempo: **~15 minuti**.

---

## 📚 Guide complete

- **[ONBOARDING-SOCI.md](./ONBOARDING-SOCI.md)** — Guida principale onboarding (Mac-first, ma applicabile a tutti)
- **[ONBOARDING-WINDOWS-LINUX.md](./ONBOARDING-WINDOWS-LINUX.md)** — Specifica Windows/Linux con prompt one-paste

---

## 🔧 Cosa installa lo script

| Componente | Mac | Windows | Linux |
|---|---|---|---|
| Homebrew (package manager) | ✅ | — | — |
| Node.js 20+ | ✅ | ✅ (winget) | ✅ (apt/dnf) |
| Git | ✅ | ✅ | ✅ |
| Claude Code CLI | ✅ | ✅ | ✅ |
| Obsidian | ✅ | ✅ | ✅ |
| Cartella vault `~/Documents/Ferro-Brain-Team` | ✅ | ✅ | ✅ |
| Template `.env.example` | ✅ | ✅ | ✅ |

## 🔧 Cosa NON fa lo script (3 step manuali post-install)

1. **Login Obsidian Sync** con account aziendale → credenziali da Matteo via 1Password
2. **Inserire Encryption Passphrase** del Remote Vault → da Matteo 1-on-1
3. **`claude login`** sul tuo account `@salutediferro.com` (Anthropic Team workspace)

---

## 🔐 Sicurezza

- ✅ Lo script è open source — nessuna credenziale è incorporata
- ✅ Tutte le credenziali (API key, passphrase, password) restano in **1Password Teams** del workspace SDF
- ✅ Lo script richiede privilegi admin **solo** per installare i pacchetti (Homebrew, Node, Obsidian)
- ❌ Non installa software a pagamento
- ❌ Non scarica file da fonti non ufficiali
- ❌ Non invia dati a server esterni

Puoi leggere il codice prima di eseguirlo: [install.sh](./install.sh)

---

## 🆘 Supporto

| Problema | Chi |
|---|---|
| Setup tecnico, install fallisce | Matteo |
| Account aziendali (Obsidian, Anthropic, 1Password) | Matteo |
| Strategia / business / clienti | Simone |
| Operations / lab / contatti | Antonio |
| Content / social | Giuseppe |
| Altro | Slack `#ferro-brain` |

---

## 📦 Repo correlati

- **[trillimatteob-blip/ferro-brain-team](https://github.com/trillimatteob-blip/ferro-brain-team)** — vault Obsidian aziendale (privato)
- **[trillimatteob-blip/ferro-brain-setup](https://github.com/trillimatteob-blip/ferro-brain-setup)** — questo repo (pubblico)

---

© 2026 Salute Di Ferro · Powered by [Claude Code](https://claude.com/claude-code) + [Obsidian](https://obsidian.md)
