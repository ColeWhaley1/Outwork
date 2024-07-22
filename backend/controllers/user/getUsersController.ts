import { Request, Response } from 'express';
import { getUsersService } from '../../services/user/getUsersService';

export const getUsersController = async (
    req: Request, 
    res: Response
): Promise<void> => {
    try {
        const users = await getUsersService();
        
        res.status(200).json(users);
    } catch(error) {
        res.status(500).send(error);
    }
}