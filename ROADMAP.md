# Roadmap — Pixel Roguelite

Obiettivo: un **roguelite 2D pixel art, single player**. Non un Hades. Una run corta, morte, un po’ di progressione permanente.

Regola d’oro: **un vertical slice giocabile prima di qualsiasi sistema “da gioco vero”**. Se il movimento e un colpo non sono divertenti, le 40 armi non salvano il progetto.

## Stack (fissato)

| Cosa | Scelta | Perché |
| --- | --- | --- |
| Engine | **Godot 4** | 2D nativo, gratuito, scene = stanze, TileMap, pixel-perfect |
| Linguaggio | **GDScript** | Iterazione veloce; sei un programmatore, lo impari in un pomeriggio |
| Editor | Godot (Standard, non .NET) | Un solo tool per scene, input, collisioni, export |
| Pixel art | **Aseprite** (o **LibreSprite** / **Pixelorama** gratis) | Sprite 16×16, palette corta, onion skin per animazioni |
| Palette | Una sola, 16–32 colori (es. da [Lospec](https://lospec.com/palette-list)) | Coerenza visiva senza skill da illustratore |
| Audio (dopo) | SFX corti (jsfxr / ChipTone) + 1 loop | Non bloccare il gameplay per la musica |
| Livello di ambizione v0 | **Prototype room** | Muovi, colpisci, muori, restart |

Non usare Unity/Unreal per questo gioco: overhead enorme per 2D pixel. Non usare Pygame/raw canvas: ricostruirai un engine.

## Cosa *non* fare all’inizio

- Open world, multiplayer, crafting, skill tree da 80 nodi
- Procgen “alla Binding of Isaac” completa
- Pixel art originale per ogni nemico prima che il combat esista
- Shader, lighting 2D, particle system come priorità
- Lore / dialoghi / cutscene

## Architettura target (quando cresce)

```
Run (seed)
  └─ Floor
       └─ Rooms (grafo: start → combat → reward → boss)
            └─ Entities: Player, Enemy, Pickup, Projectile
Meta-save (sblocchi fra una run e l’altra)
```

File che già esistono:

- `scripts/game.gd` — sarà il **RunManager** (seed, floor, restart)
- `scripts/player.gd` — input + movimento; poi HP, attacco
- `scenes/main.tscn` — prima stanza; poi TileMap + door
- `scenes/player.tscn` — prefab del player

## Fasi

### Fase 0 — Foundation (fatto)

- [x] Progetto Godot, viewport 320×180, scale integer, nearest filter
- [x] Player 16×16, muri, restart con Enter
- [x] Cartelle `scenes/`, `scripts/`, `assets/` (da riempire)

### Fase 1 — Feel (1–2 settimane)

- [ ] Attacco melee (hitbox a tempo, 1 frame di “slash”)
- [ ] 1 nemico che insegue e fa danno
- [ ] HP player, morte → `reload_current_scene`
- [ ] I-frames corti dopo il colpo
- [ ] Camera ferma sulla stanza (non follow smooth)

**Criterio di done:** 30 secondi di “è già un giochino”.

### Fase 2 — Run loop (2–3 settimane)

- [ ] 3 tipi di stanza: start, combat, reward
- [ ] Porte che si aprono quando la stanza è pulita
- [ ] Seed della run (`RandomNumberGenerator`)
- [ ] 5–8 stanze in sequenza, poi boss placeholder
- [ ] Schermata “You died” + restart

**Criterio di done:** una run da 3–5 minuti, sempre diversa nel layout *minimo*.

### Fase 3 — Loot e build (2 settimane)

- [ ] 3 armi o 3 “modificatori” (danno, velocità, area)
- [ ] Chest a fine stanza
- [ ] Un negozio o un’offerta a 3 scelte (roguelite classico)

### Fase 4 — Meta (1–2 settimane)

- [ ] Valuta della run (soul/gold) che sopravvive alla morte
- [ ] 4–6 upgrade permanenti (HP, danno, sblocca arma)
- [ ] Save su `user://` (`ConfigFile` o JSON)

### Fase 5 — Pixel art vera

- [ ] Tileset 16×16 (pavimento + muri + porta)
- [ ] Player: idle + walk 4 dir (o 2 dir + flip) + attack
- [ ] 2 nemici distinti
- [ ] HUD (cuori, arma)

Fino a qui gli sprite restano **rettangoli colorati**. L’art si innesta sopra scene già giocabili.

### Fase 6 — Polish (quando il gioco esiste)

- [ ] Screen shake, freeze-frame sul hit
- [ ] SFX
- [ ] Un bioma, un boss con 2 pattern
- [ ] Export Windows

## Grafica — regole pratiche

1. **Risoluzione interna 320×180** (già impostata). Sprite **16×16** (player/enemy), tile **16×16**.
2. **Niente filtro bilinear.** In `project.godot` c’è già nearest + integer scale.
3. **Una palette.** Non mescolare “cyberpunk neon” e “fantasy sporco”.
4. **Silhouette prima del dettaglio.** Un player giallo 16×16 deve leggersi su pavimento scuro.
5. Tool: Aseprite se puoi (32 € una tantum, vale). Altrimenti Pixelorama (gratis, fatto in Godot) o LibreSprite.
6. Non animare 12 frame se 2 (idle/walk) bastano.

## Consigli di programmazione (Godot)

- Ogni entità = **scena** (`player.tscn`, poi `enemy.tscn`, `slash.tscn`).
- Segnali per eventi (`died`, `room_cleared`), non singleton infiniti.
- Un `Autoload` solo per: RNG della run, meta-save, audio bus.
- TileMapLayer (Godot 4.3+) per i dungeon, non muri fatti a mano come ora.
- Tieni il combat **frame-based** (timer in secondi ok, ma gli hitbox durano 0.08–0.15s).

## Prossima mossa concreta

1. Installa Godot 4.3+ e apri questa cartella.
2. Cambia `SPEED` in `scripts/player.gd` e senti il movimento.
3. Poi Fase 1: attacco + 1 nemico. Quello è il vero inizio del roguelite.
