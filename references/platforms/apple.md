# Apple App Store 内购 / 订阅

```yaml
platform: Apple App Store
site: apple.com
category: 应用商店（代收方）
pricing:
  - 订阅（连续包月/包年）
  - App 内购
  - 一次性购买
refund_policy: 有条件
entry:
  web: "https://reportaproblem.apple.com → 登录 Apple ID → 「我需要」→「请求退款」→ 选原因 → 选项目 → 提交"
  app: null
  cs: "无人工客服通道，只有报告问题页面"
  hidden: "平台 App 内没有任何退款入口，因为钱不在平台手里"
ratio_refund: unknown
timeline: 24–48 小时给最新信息；到账时间视支付方式
rejection_lines:
  - "所有交易一旦达成，概不换退"
  - "不符合退款条件"
proof_points:
  - Apple 收据（邮件里的 Receipt）
  - 订单号（以 MSN 开头）
  - 购买时间
  - 是否已使用该 App/服务
ios_rule: "唯一入口 reportaproblem.apple.com；平台无权退"
notes: "条款 B：所有交易一旦达成，概不换退；技术未交付或交付不合理延迟，Apple 可酌情换内容或退款；承诺结算周期的订阅，仅针对已付费但尚未提供访问权限的周期退款；存在欺诈/滥用可拒退。"
status: 公开资料
last_verified: 2026-11-02
sources:
  - https://www.apple.com.cn/legal/internet-services/itunes/cn/terms.html
  - https://support.apple.com/zh-cn/118223
  - https://support.apple.com/zh-cn/118224
```

## 最重要的一句

**钱在 Apple 账上，平台开发者无权退。**

用户找平台客服要 App Store 的钱，得到的回答永远是"请联系 Apple"。这不是踢皮球，是事实。**先确认收款方是不是 Apple**（收据上写着，或支付账单显示 Apple），是就直接去 reportaproblem，别浪费三天。

## 三个真实可用的口子

1. **技术未交付 / 交付不合理延迟**（条款自己写的）——买了打不开、闪退、内容加载不出来。
2. **订阅的"未提供访问权限的周期"**——比如你取消了订阅但还被扣了下期，这期没给服务。
3. **未经授权的购买**（孩子误点、账号被盗）——这条通过率最高，但要求如实。

## 选原因的讲究

页面会让你选退款原因。"不符合预期"通过率最低；"未授权购买""未收到项目"通过率高但**必须真实**。

**不要为了过审编原因。** Apple 有滥用记录，一旦判定欺诈，后续所有退款都会被拒，甚至影响 Apple ID。

## 关键提醒：退款 ≠ 取消订阅

Apple 退款成功后，**订阅可能还在**，下期照扣。

必须单独做一步：`设置 → Apple ID → 订阅 → 选中该订阅 → 取消订阅`。

很多人退了款、以为完事了，三个月后发现又被扣了一次。

## 被拒之后

Apple 拒绝后，中国用户仍可向 12315 投诉（投诉对象是 Apple 的中国主体），但成功率不高——Apple 的条款给了它很大的裁量空间。

**现实建议**：金额小的，接受结果；金额大的（年费上千），走 12315 + 黑猫，同时把"未提供访问权限"的证据备齐。
