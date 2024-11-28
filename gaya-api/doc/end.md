# Nest.js 后端开发规范

## 目录
1. [文件夹结构](#1-文件夹结构)
2. [编码规范](#2-编码规范)
3. [路由与模块设计](#3-路由与模块设计)
4. [控制器与服务分层](#4-控制器与服务分层)
5. [数据传输与校验](#5-数据传输与校验)
6. [数据库与实体管理](#6-数据库与实体管理)
7. [分页与数据加载](#7-分页与数据加载)
8. [日志与异常处理](#8-日志与异常处理)
9. [测试规范](#9-测试规范)
10. [注释与文档](#10-注释与文档)

---

## 1. 文件夹结构

每个功能模块应单独划分，遵循以下结构：

├── src/ │ ├── modules/ │ │ ├── user/ │ │ │ ├── user.module.ts # 模块文件 │ │ │ ├── user.controller.ts # 控制器 │ │ │ ├── user.service.ts # 服务层 │ │ │ ├── dto/ # 数据传输对象 │ │ │ ├── entities/ # 数据实体 │ │ │ ├── interfaces/ # 接口定义 │ │ │ └── utils/ # 工具类 │ ├── common/ # 全局模块、拦截器、管道等 │ ├── config/ # 配置文件 │ ├── main.ts # 项目入口文件 │ └── app.module.ts # 根模块

---

## 2. 编码规范

- **缩进**：使用 **2 个空格** 作为缩进。
- **命名规则**：
  - 文件名统一为 **小写加中划线**，如：`user-controller.ts`。
  - 类、接口和装饰器使用 **PascalCase** 命名，如：`UserService`。
  - 变量和函数使用 **camelCase** 命名，如：`findUserById`。
- **注释**：
  - 必要的模块、方法、逻辑和接口均需添加注释。
  - 使用 `JSDoc` 风格的注释，例如：
    ```typescript
    /**
     * 根据 ID 查找用户
     * @param id 用户 ID
     * @returns 用户信息
     */
    findUserById(id: string): Promise<User> {
      // ...
    }
    ```

---

## 3. 路由与模块设计

- **RESTful 风格**：
  - 路由应使用 RESTful 风格，如：
    - 获取资源：`GET /users`
    - 创建资源：`POST /users`
    - 更新资源：`PUT /users/:id`
    - 删除资源：`DELETE /users/:id`
- **模块化设计**：
  - 每个功能独立为一个模块，并在 `app.module.ts` 中注册。
  - 示例：
    ```typescript
    @Module({
      imports: [TypeOrmModule.forFeature([UserEntity])],
      controllers: [UserController],
      providers: [UserService],
    })
    export class UserModule {}
    ```

---

## 4. 控制器与服务分层

- **控制器**：负责接收请求和返回响应，不包含业务逻辑。
- **服务层**：集中处理业务逻辑并与数据库交互。
- 示例：
  ```typescript
  @Controller('users')
  export class UserController {
    constructor(private readonly userService: UserService) {}

    @Get()
    async findAll(): Promise<User[]> {
      return this.userService.findAll();
    }
  }
