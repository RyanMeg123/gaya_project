import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
export declare class UsersService {
    private readonly userRepository;
    constructor(userRepository: Repository<User>);
    getUserProfile(id: string): Promise<{
        id: any;
        name: any;
        email: any;
        phone: any;
        address: any;
        avatar: any;
    }>;
}
