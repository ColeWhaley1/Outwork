import { getUsersController } from '../controllers/user/getUsersController';
import { getUserByIdController } from '../controllers/user/getUserByIdController'; 
import express from 'express';

const router = express.Router();

router.get('/users', getUsersController);
router.get('/user/:id', getUserByIdController);

export default router;