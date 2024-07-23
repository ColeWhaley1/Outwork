import db from "../../../db";
import { User } from "../../interfaces/userInterfaces";


export const getUserByIdService = async (
    id: string
): Promise<User> => {
    try {

        const user_snapshot = await db.collection('user').doc(id).get();

        if (!user_snapshot) {
            throw new Error(`snapshot does not exist for user with id: ${id}`);
        }

        const user = user_snapshot.data() as User;

        return user;

    } catch (error) {
        console.log(error);
        return {};
    }
};