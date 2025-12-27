# Fix RTL for Claude Code Extension

## مشکل
متن فارسی در پنل Claude Code به صورت گسسته و LTR نمایش داده می‌شد.

## راه‌حل
اضافه کردن CSS سفارشی به فایل `index.css` در extension Claude Code:

```css
*{font-family:"Vazirmatn","SF Mono",Monaco,"Courier New",monospace!important}
body,html{direction:rtl;text-align:right}
p,div,span,li,ul,ol{direction:rtl;text-align:right;unicode-bidi:embed}
pre,code{direction:ltr;text-align:left;unicode-bidi:embed}
```

## فایل‌های تغییر یافته
- `~/.windsurf/extensions/anthropic.claude-code-*/webview/index.css`
- `~/.windsurf-next/extensions/anthropic.claude-code-*/webview/index.css`

## نحوه استفاده بعد از آپدیت Extension
```bash
~/1-MY-WORK/136th-day-fix-rtl-claude/fix-rtl-claude.sh
```

## تنظیمات Windsurf (settings.json)
```json
{
    "editor.unicodeBidi": "auto",
    "editor.renderControlCharacters": true,
    "editor.unicodeHighlight.invisibleCharacters": false,
    "terminal.integrated.unicodeVersion": "11",
    "terminal.integrated.gpuAcceleration": "on",
    "editor.fontFamily": "'Vazirmatn', 'SF Mono', Monaco, 'Courier New', monospace"
}
```

## مشکل CPU بالا (Bug شناخته شده)
این مشکل ربطی به تغییرات CSS ندارد. یک bug سراسری در Claude Code است:
- [Issue #11615](https://github.com/anthropics/claude-code/issues/11615)
- [Issue #11473](https://github.com/anthropics/claude-code/issues/11473)

### دستور kill کردن پروسس‌های zombie:
```bash
ps aux | grep "claude-code.*native-binary/claude" | grep -v grep | awk '{print $2}' | xargs kill -9
```

## تاریخ
2025-12-15
