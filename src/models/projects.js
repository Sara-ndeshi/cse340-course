import db from './db.js';

/**
 * Fetches all service projects along with their sponsoring organization's name.
 */
export const getAllProjects = async () => {
    const sql = `
        SELECT p.project_id, p.title, p.description, p.location, p.project_date, o.name AS organization_name
        FROM project p
        INNER JOIN organization o ON p.organization_id = o.organization_id
        ORDER BY p.project_date ASC;
    `;
    try {
        const result = await db.query(sql);
        return result.rows;
    } catch (error) {
        console.error('Error fetching all projects:', error.message);
        throw error;
    }
};
