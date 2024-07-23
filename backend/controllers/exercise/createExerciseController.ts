import { Request, Response } from 'express';

type Request_params = {
    id: string;
};

export const createExerciseController = async (
    req: Request,
    res: Response
) => {
    try {

        // store exercise video if exists, return link

        // use video link to create exercise object, pass to createExerciseService

        res.status(200).json();
    } catch (error) {
        res.status(500).json();
    }

};