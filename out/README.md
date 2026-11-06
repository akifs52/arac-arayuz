# AutoPilot Pro

Native Qt Quick UI generated with screenshot-to-qml. Profile: `desktop`.

## Run

### PySide6

```bash
pip install -r requirements.txt
python main.py
```

Headless check: `python <skill>/scripts/check.py . --source input.png --spec design-spec.json`

## Structure

- `qml/App/Style` — Theme (all tokens) and Icons
- `qml/App/Controls` — the control kit (QtQuick.Templates, Theme roles only); delete unused ones
- `qml/App` — screens and screen-specific components
- `assets/fonts` — bundled fonts, loaded by the host from the folder
- `i18n` — translations: `pyside6-lupdate qml/App/*.qml qml/App/Controls/*.qml -ts i18n/app_en.ts`,
  translate, `pyside6-lrelease i18n/app_en.ts -qm i18n/app_en.qm`; `APP_LANG=en` picks the language
- `main.py` — PySide6 host

## Fidelity report

<!-- filled in by the agent: measured metrics, assumed values, approximations -->
