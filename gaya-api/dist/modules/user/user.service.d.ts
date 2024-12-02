import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
export declare class UserService {
    private readonly userRepository;
    constructor(userRepository: Repository<User>);
    findByEmail(email: string): Promise<User | undefined>;
    create(email: string, password: string): Promise<User>;
    login(email: string, password: string): Promise<User>;
    findById(id: number): Promise<User | undefined>;
    updateProfile(id: number, updateData: Partial<User>): Promise<User>;
    changePassword(id: number, oldPassword: string, newPassword: string): Promise<void>;
}
