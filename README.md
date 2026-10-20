# EmpireTool

A fork of [BetterSteamTools](https://github.com/madoiscool/BetterSteamTools) / [OpenSteamTool](https://github.com/OpenSteam001/OpenSteamTool) with updated pattern sources and minor configuration changes.

> **This project is provided for research and educational purposes only.**
> You are responsible for complying with local laws, platform terms of service, and software licenses.

---

## Changes from upstream

- Pattern files fetched from [hazre/steam-monitor](https://github.com/hazre/steam-monitor) which tracks Steam updates more frequently
- Default Lua directory changed from `config\stplug-in` to `config\lua`
- Config file renamed to `empiretool.toml`

## Usage

1. Copy `EmpireTool.dll` and `xinput1_4.dll` to your Steam installation folder (e.g. `C:\Program Files (x86)\Steam\`)
2. Create a Lua directory: `C:\Program Files (x86)\Steam\config\lua\`
3. Place `.lua` files in that directory — they are hot-reloaded automatically, no Steam restart needed

### Lua example

```lua
addappid(1234560)                                        -- unlock a game
addappid(1234561, 0, "depotKeyHex")                     -- unlock with depot key
setManifestid(1234561, "manifestGID")                   -- pin a specific manifest
setAppTicket(1234560, "hexTicket")                      -- set app ticket (Denuvo)
setETicket(1234560, "hexTicket")                        -- set encrypted ticket (Denuvo)
```

All function names are case-insensitive.

## Build

**Requirements**
- Windows 10/11
- CMake 3.20+
- Visual Studio 2022 or newer with MSVC x64 toolchain

**Steps**
```
build.bat
```

Output:
- `build\Release\EmpireTool.dll`
- `build\Release\xinput1_4.dll`

## Steam version compatibility

On first launch after a Steam update, EmpireTool downloads a small pattern file (~10 KB) from [hazre/steam-monitor](https://github.com/hazre/steam-monitor) that matches the new Steam build. This happens on a background thread and never blocks startup. The file is cached locally after download.

If the pattern file does not exist yet for your Steam build, hooks that depend on it are disabled until the upstream tracker publishes one — Steam continues to run normally.

## License

GPL v3 — see [LICENSE](LICENSE).

## Credits

- [OpenSteam001/OpenSteamTool](https://github.com/OpenSteam001/OpenSteamTool) — original project
- [madoiscool/BetterSteamTools](https://github.com/madoiscool/BetterSteamTools) — fork this is based on
- [hazre/steam-monitor](https://github.com/hazre/steam-monitor) — Steam pattern tracker
