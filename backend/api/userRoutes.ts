import { getUsersController } from '../controllers/getUsersController';
import express from 'express';

const router = express.Router();

router.get('/users', getUsersController);

export default router;