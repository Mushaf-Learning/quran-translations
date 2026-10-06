# Quran Translations

An index and download scripts for 140+ Quran translations in 50+ languages, in multiple formats.

> **Licensing notice — read before using any translation text.** The scripts in
> this repository are MIT-licensed. The translation texts are **not**: each one
> belongs to its translator or publisher and is shared on Tanzil.net for
> **non-commercial use only**. See [Licence](#licence) below.

## Available Languages

### English (9 translations)
| Translator | Identifier |
|-----------|-----------|
| Sahih International | `en.sahih` |
| Abdullah Yusuf Ali | `en.yusufali` |
| Mohammed Marmaduke Pickthall | `en.pickthall` |
| Talal Itani | `en.itani` |
| Abdul Majid Daryabadi | `en.daryabadi` |
| al-Hilali & Khan | `en.hilali` |
| Abul Ala Maududi | `en.maududi` |
| Ali Quli Qarai | `en.qarai` |
| English Transliteration | `en.transliteration` |

### Urdu (8 translations)
| Translator | Identifier |
|-----------|-----------|
| Fateh Muhammad Jalandhri | `ur.jalandhry` |
| Ahmed Raza Khan (Kanz ul Iman) | `ur.kanzuliman` |
| Abul Ala Maududi | `ur.maududi` |
| Muhammad Junagarhi | `ur.junagarhi` |
| Ahmed Ali | `ur.ahmedali` |
| Tahir ul Qadri | `ur.qadri` |
| Syed Zeeshan Haider Jawadi | `ur.jawadi` |
| Muhammad Hussain Najafi | `ur.najafi` |

### Arabic Tafsir
| Source | Identifier |
|--------|-----------|
| Jalalayn | `ar.jalalayn` |
| King Fahad Complex (Muyassar) | `ar.muyassar` |

### French
| Translator | Identifier |
|-----------|-----------|
| Muhammad Hamidullah | `fr.hamidullah` |

### Turkish (10 translations)
| Translator | Identifier |
|-----------|-----------|
| Diyanet Isleri | `tr.diyanet` |
| Diyanet Vakfi | `tr.vakfi` |
| Elmalili Hamdi Yazir | `tr.yazir` |
| Suat Yildirim | `tr.yildirim` |
| Suleyman Ates | `tr.ates` |
| Ali Bulac | `tr.bulac` |
| Yasar Nuri Ozturk | `tr.ozturk` |
| Edip Yuksel | `tr.yuksel` |
| Abdulbaki Golpinarli | `tr.golpinarli` |
| Transliteration | `tr.transliteration` |

### German (4), Spanish (3), Italian (1), Portuguese (1)
### Russian (8), Persian (12), Indonesian (3), Malay (1)
### Bengali (2), Hindi (2), Tamil (1), Malayalam (2)
### Bosnian (2), Albanian (3), Dutch (3), Swedish (1), Norwegian (1)
### Chinese (2), Japanese (1), Korean (1), Thai (1)
### Azerbaijani (2), Uzbek (1), Tajik (1), Tatar (1), Uyghur (1)
### Hausa (1), Swahili (1), Somali (1), Amharic (1)
### Kurdish (1), Pashto (1), Sindhi (1), Divehi (1)
### Czech (2), Polish (1), Romanian (1), Bulgarian (1)
### Amazigh (1)

**Total: 140+ translations across 50+ languages**

## Directory Structure

```
by-language/      # Translations organized by language code
  en/             # English translations
  ur/             # Urdu translations
  fr/             # French translations
  tr/             # Turkish translations
  ...
by-translator/    # Individual translator files
formats/          # Same data in multiple formats
  json/           # JSON format
  xml/            # XML format
  txt/            # Plain text format
```

## File Format

Each translation file contains all 6,236 ayahs:

```json
{
  "identifier": "en.sahih",
  "language": "en",
  "translator": "Sahih International",
  "ayahs": [
    { "surah": 1, "ayah": 1, "text": "In the name of Allah, the Entirely Merciful, the Especially Merciful." },
    { "surah": 1, "ayah": 2, "text": "All praise is due to Allah, Lord of the worlds." }
  ]
}
```

## Data Source & Attribution

All translations sourced from [Tanzil.net](https://tanzil.net/trans/) — the standard verified source used by most Quran apps worldwide.

> "No translation of the Quran can be a hundred percent accurate, nor can it be used as a replacement of the Quran text."

Attribution to Tanzil.net is required per their terms.

## Licence

**Code** (everything under `scripts/` and the repository structure): MIT, see
[LICENSE](LICENSE).

**Translation texts** (`by-language/`, `by-translator/`, `formats/`): not
covered by the MIT licence. Earlier versions of this README said the
translations were "MIT — free for personal and commercial use"; that was wrong.
Each translation remains the property of its translator or publisher (many are
in copyright, e.g. Sahih International, Maududi, Hilali-Khan, Qarai, Diyanet).
Tanzil.net, where these files come from, states
(https://tanzil.net/trans/, retrieved 2026-10-05):

> The translations provided at this page are for non-commercial purposes only.
> If used otherwise, you need to obtain necessary permission from the
> translator or the publisher. If you are using more than three of the
> following translations in a website or application, we require you to put a
> link back to this page to make sure that subsequent users have access to the
> latest updates. Redistributing the following list in another website is not
> allowed, unless direct permission is granted by the Tanzil Project.

Per source:

- **Public domain as works:** Pickthall (1930) and Yusuf Ali (1934); Project
  Gutenberg #16955 lists them as "Public domain in the USA". Tanzil's terms
  above still apply to Tanzil's copies.
- **Openly licensed elsewhere:** The Clear Quran (Talal Itani) is published by
  ClearQuran.com under CC BY-ND 4.0, commercial use allowed: use the
  ClearQuran.com files (https://blog.clearquran.com/download), credit
  "Translation by Talal Itani, ClearQuran.com." and change no words. Many
  translations (Saheeh International, Junagarhi, Indonesian Ministry of
  Religious Affairs, Basmeih, Isa Garcia, Abu Bakr Zakaria, ...) are
  republished by QuranEnc.com on its terms: unmodified, credit the publisher
  and QuranEnc.com with the version number, keep up to date
  (https://quranenc.com/en/home/api/).
- **Everything else:** non-commercial use only, per Tanzil; any other use
  needs permission from the translator or publisher.

Tanzil does not allow redistributing its translation list without
permission, so do not treat the files here as a redistribution source; fetch
them from Tanzil (see `scripts/`) or from the publisher.
