# AGENTS.md

## 项目用途

本仓库维护元书输入法皮肤。当前主皮肤：

`skins/Hamster中文26键-元书/`

## 唯一事实源

- 皮肤源码：`skins/Hamster中文26键-元书/jsonnet/`
- 生成 YAML：`skins/Hamster中文26键-元书/light/`、`dark/`
- 元书运行目录：`/var/minis/mounts/yuanshu/Skins/Hamster中文26键-元书/`
- 禁止只修改元书运行目录后不回写 Git。
- 禁止把 `.keyboard` 缓存当源码提交。

## 强制同步流程

每次修改必须按顺序执行：

1. 只修改 Git 工作树中的 Jsonnet 源码。
2. 在仓库皮肤目录中分别生成四份配置：
   - `light/pinyin_26_portrait.yaml`
   - `light/pinyin_26_landscape.yaml`
   - `dark/pinyin_26_portrait.yaml`
   - `dark/pinyin_26_landscape.yaml`
3. 校验关键字段、布局、Action、通知和生成结果。
4. 将完整皮肤目录同步到元书运行目录，至少包括：
   - `config.yaml`
   - `README.md`
   - `jsonnet/`
   - `light/`
   - `dark/`
   - `demo.png`
   - `resources/`
5. 删除元书运行目录下旧的隐藏 `.keyboard` 缓存。
6. 检查元书运行目录与 Git 生成结果一致。
7. `git status` 后提交。
8. 推送 `origin main`。
9. 告知用户在元书中重新选择皮肤；若 Jsonnet 源码发生变化，长按运行 `main.jsonnet`。

## 当前功能约定

- “双拼”工具栏按钮使用 Rime Switcher：`shortcut: '#RimeSwitcher'`。
- 按钮图标使用 SF Symbol `switch.2`，不要使用文字“韵母”或“键码展示”。
- 小鹤提示由 Rime Option `show_flypy_yunmu` 控制。
- 提示只显示韵母；U/I 特殊显示 `sh/ch`；L 的 `uang` 使用较小字号并居中。
- 不在皮肤中强制绑定具体 Rime 方案。
- 修改 Rime schema 后必须重新部署 Rime，不能只生成皮肤 YAML。

## 提交前最低检查

```sh
cd /root/ys-skins
find skins/Hamster中文26键-元书 -type f -name '.?*.keyboard' -delete
# 生成四份 pinyin YAML
# 校验 toolbar action/icon、show_flypy_yunmu、U/I/L 提示
# 同步元书目录
# git status && git diff --check
```

## 回滚

任何批量同步前，先备份元书运行目录到：

`/var/minis/mounts/yuanshu/Backup/`
