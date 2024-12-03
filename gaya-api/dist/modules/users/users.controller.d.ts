export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    getUserProfile(id: string): Promise<any>;
    getUser(id: string): Promise<any>;
}
