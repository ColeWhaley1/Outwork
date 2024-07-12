import { Request, Response } from 'express';
import { getUsersService } from '../services/getUsersService';

export const getUsersController = async (
    req: Request, res: Response
) => {
    try {
        const users = await getUsersService();
        
        res.status(200).json(users);
    } catch(error) {
        res.status(500).send(error);
    }
}