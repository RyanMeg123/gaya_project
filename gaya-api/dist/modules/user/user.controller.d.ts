import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { LoginUserDto } from './dto/login-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
export declare class UserController {
    private readonly userService;
    constructor(userService: UserService);
    register(createUserDto: CreateUserDto): Promise<import("./entities/user.entity").User>;
    login(loginUserDto: LoginUserDto): Promise<{
        message: string;
        user: import("./entities/user.entity").User;
    }>;
    getProfile(email: string): Promise<{
        id: number;
        email: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    updateProfile(id: number, updateUserDto: UpdateUserDto): Promise<import("./entities/user.entity").User>;
    changePassword(req: any, changePasswordDto: ChangePasswordDto): Promise<{
        message: string;
    }>;
}
