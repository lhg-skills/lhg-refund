# 自动化执行层

> 三个平台的执行手册：扣子（全自动）、Apple（半自动）、WPS（半自动）。
> **这里只写"怎么点"；该不该退、该说什么，回到 `SKILL.md` 和 `templates/`。**

## 三种模式

| 模式 | 平台 | 谁点 |
|---|---|---|
| **全自动** | 扣子 | agent 点到底，只在"最终确认"停 |
| **半自动** | Apple、WPS | agent 导航 + 填表，**登录和提交交给用户** |
| **指导** | 其余平台 | agent 只给步骤和话术，用户自己点 |

判断标准只有一条：**登录能不能由 agent 完成。** 不能 → 最多半自动。

## 四条铁律（三个平台通用）

1. **登录必须交还用户。** `await task.handOff()`，然后结束本轮。
2. **最终提交必须等用户明确说"确认"。** 复述金额、去向、后果三件事。
3. **不并发、不重试。** 同一账号 1 小时最多 1 次；失败 2 次即停。
4. **页面报错就停，把页面截图留下。** 不换招硬闯。

## 通用骨架

每次执行都是同一套结构，只是步骤不同：

```js
// ① 开空间，从首页进（不要直达深链）
const task = await taskSpace("refund <platform>");
const page = task.page("p1");
await page.goto("https://www.example.com/");
console.log({ spaceId: task.spaceId, page: page.label });
console.log(await page.snapshot());   // 先看，再决定点哪里
```

```js
// ② 需要用户登录 → 交出控制权，结束本轮
await task.handOff();
// 告诉用户：请在浏览器窗口里完成登录，好了告诉我
```

```js
// ③ 用户确认后，恢复同一个空间（不要新建）
const task = await takeOverTaskSpace(12);   // 上一轮打印的 spaceId
const page = task.userPage();               // 用户操作过的那个页面
console.log(await page.snapshot());
```

```js
// ④ 收尾（只在成功时；用户控制或报错时不要调用）
await task.finish({ keep: [] });
```

## 现场确认协议（重要）

**页面会改版，本手册里的文字描述不能当选择器用。**

每一步的动作顺序：

```
snapshot() → 在输出里找目标节点 → 用 ref 或 loc= 定位 → 动作 → 再 snapshot 确认
```

- 找不到目标 → 先 `snapshot({ scope: "full_page" })`，通常在折叠线以下
- 出现验证码/滑块 → **停**，转人工路径（`references/channels.md`），不要尝试过验证
- 页面报错 → 截图，记录原文，停止

## 反检测对照

自动化跑之前，先过一遍 `references/human-ops.md` 的七条自检。这里只强调三条最容易犯的：

| 别做 | 为什么 |
|---|---|
| `goto("https://xxx.com/subscription/manage")` 直达 | 真人不会直达四层页面 |
| `page.fill()` 一次填完 | 没有按键事件 |
| `waitForTimeout(2000)` 固定延时 | 恒定间隔本身就是指纹 |

## 验收标准

一次执行算成功，要同时满足：

- [ ] 出现"申请已提交""退款处理中"之类的**可见状态变化**
- [ ] 订单状态从"可申请"变成"处理中"
- [ ] 记录了订单号、金额、去向、预计到账时间
- [ ] 有截图或页面文本作为证据

只有"点完了"不算成功。**没有状态变化，就是没提交上。**

## 三个平台手册

| 平台 | 模式 | 手册 | 状态 |
|---|---|---|---|
| 扣子 Coze | 全自动 | [coze.md](coze.md) | 路径已实测（v1），本版改为 ego-lite |
| Apple reportaproblem | 半自动 | [apple.md](apple.md) | 路径来自 Apple 官方文档，**待真机验证** |
| WPS | 半自动 | [wps.md](wps.md) | 入口来自官方 FAQ，**待真机验证** |
