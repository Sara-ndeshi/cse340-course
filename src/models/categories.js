import db from './db.js';

/**
 * Fetches all categories alphabetically from the database.
 */
export const getAllCategories = async () => {
    const sql = `
        SELECT category_id, category_name 
        FROM category 
        ORDER BY category_name ASC;
    `;
    try {
        const result = await db.query(sql);
        return result.rows;
    } catch (error) {
        console.error('Error fetching all categories:', error.message);
        throw error;
    }
};
