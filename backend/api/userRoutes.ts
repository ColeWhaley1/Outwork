import { getUsersController } from '../controllers/user/getUsersController';
import { getUserByIdController } from '../controllers/user/getUserByIdController'; 
import express from 'express';
import { createExerciseController } from '../controllers/exercise/createExerciseController';

const router = express.Router();

router.get('/users', getUsersController);
router.get('/user/:id', getUserByIdController);
router.post('/exercise', createExerciseController);

export default router;