import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UserService {
    private readonly userRepository;
    constructor(userRepository: Repository<User>);
    findByEmail(email: string): Promise<User | null>;
    create(email: string, password: string): Promise<User>;
    login(email: string, password: string): Promise<User>;
    findById(id: number): Promise<User | undefined>;
    updateProfile(id: number, updateUserDto: UpdateUserDto): Promise<User>;
    changePassword(id: number, oldPassword: string, newPassword: string): Promise<void>;
}
