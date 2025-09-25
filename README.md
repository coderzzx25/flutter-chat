# Flutter Chat App

一个简单的聊天应用，使用Flutter框架开发。

后端仓库 [https://github.com/coderzzx25/node-chat](https://github.com/coderzzx25/node-chat)

## 功能

- 用户注册和登录
- 发送和接收消息
- 查看聊天记录
- 通过Email添加好友

## 效果图
![login](/images/login.png)
![register](/images/register.png)
![conversations](/images/conversations.png)
![chat](/images/chat.png)
![contacts](/images/contacts.png)
![add_contact](/images/add_contact.png)

## 备忘录

- 对话页面未打开 → 使用 flutter_local_notifications 在系统通知栏推送提醒
- 后台消息提醒
  - Socket 在后台可能会被系统杀掉，这时要用 FCM（Firebase Cloud Messaging） 做兜底。
  - 服务端在 sendMessage 时除了 socket 广播，也可以调用 FCM 推送接口。
  - Flutter 端接收 FCM 后显示通知