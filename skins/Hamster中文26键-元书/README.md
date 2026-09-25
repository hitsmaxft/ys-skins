# Hamster 中文26键（元书迁移版）

基于元书「仿仓默认」皮肤，迁移自 Hamster 内置中文 26 键配置。

## 动态小鹤键码

开启 Rime Switcher 中的「键码展示」后：

- 等待音节首码时，只显示小鹤声母提示：`V=zh`、`U=sh`、`I=ch`。
- 输入首码后，只显示韵母映射，例如 `Q=iu`、`W=ei`、`V=ui`、`L=uang`。
- 每完成两码自动回到首码提示；支持连续输入多个字。
- 关闭「键码展示」后隐藏全部双拼键码。

## 安装动态键码脚本

皮肤包内的 `rime-files/` 包含：

```text
rime-files/
├── double_pinyin_flypy.custom.yaml
└── lua/
    └── flypy_keycode_state.lua
```

复制到当前小鹤方案目录：

```text
flypy_keycode_state.lua
  → <Rime方案目录>/lua/flypy_keycode_state.lua

double_pinyin_flypy.custom.yaml
  → <Rime方案目录>/double_pinyin_flypy.custom.yaml
```

若已有同名 `double_pinyin_flypy.custom.yaml`，不要直接覆盖；将下面补丁合并进去：

```yaml
patch:
  "engine/processors/@before 0": lua_processor@flypy_keycode_state
```

然后在元书中执行「重新部署」。构建后的 `build/double_pinyin_flypy.schema.yaml` 应包含：

```yaml
engine:
  processors:
    - lua_processor@flypy_keycode_state
```

## 皮肤生成与部署

本仓库只维护 Jsonnet 源码。修改后由维护脚本生成 `light/`、`dark/` YAML，并同步到元书；日常使用无需手动运行 `main.jsonnet`。
