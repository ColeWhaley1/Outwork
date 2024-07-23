import { User } from "../../interfaces/userInterfaces";
import db from "../../../db";

export const getUsersService = async (): Promise<User[]> => {

    const users_snapshot = await db.collection('user').get();
    const users: User[] = users_snapshot.docs.map((doc) => ({
        id: doc.id,
        ...(doc.data() as Omit<User, 'id'>)
    }));

    return users;
}