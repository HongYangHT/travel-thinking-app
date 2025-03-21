# 执行顺序

```markdown
  UI->>BLoC: 发送事件(LoginButtonPressed)
  BLoC->>UseCase: 执行登录操作
  UseCase->>Repository: 调用数据源
  Repository->>DataSource: 发起网络请求
  DataSource-->>Repository: 返回原始数据
  Repository-->>UseCase: 返回领域对象
  UseCase-->>BLoC: 返回业务结果
  BLoC->>UI: 发射新状态

```
