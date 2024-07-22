import { Request, Response } from 'express';
import { getUserByIdService } from '../../services/user/getUserByIdService';

type Request_params = {
    id: string;
};

export const getUserByIdController = async (
    req: Request,
    res: Response
) => {

    try {
        const query_params = req.params as unknown as Request_params;
        const id = query_params.id;
    
        const user = await getUserByIdService(id);

        res.status(200).json(user);
    } catch (error) {
        res.status(500).json({});
    }

};