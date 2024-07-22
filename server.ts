import dotenv from 'dotenv';
dotenv.config({ path: '../.env' });

import express from 'express';

// Route imports
import userRoutes from './backend/api/userRoutes';

const app = express();

app.use(express.json());

// Routes
app.use('/api', userRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Listening on port ${PORT}`);
});