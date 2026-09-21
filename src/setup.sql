-- ========================================
-- 1. Create Organization Table
-- ========================================
CREATE TABLE IF NOT EXISTS organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- 2. Insert Sample Data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
(
    'BrightFuture Builders', 
    'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 
    'info@brightfuturebuilders.org', 
    'brightfuture-logo.png'
),
(
    'GreenHarvest Growers', 
    'An urban farming collective promoting food sustainability and education in local neighborhoods.', 
    'contact@greenharvest.org', 
    'greenharvest-logo.png'
),
(
    'UnityServe Volunteers', 
    'A volunteer coordination group supporting local charities and service initiatives.', 
    'hello@unityserve.org', 
    'unityserve-logo.png'
);

-- ========================================
-- 1. Create Projects Table
-- ========================================
CREATE TABLE IF NOT EXISTS project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    project_date DATE NOT NULL,
    -- Establishes the relationship and ensures data integrity
    CONSTRAINT fk_organization 
        FOREIGN KEY (organization_id) 
        REFERENCES organization (organization_id)
        ON DELETE CASCADE
);

-- ========================================
-- 2. Insert 15 Sample Projects (5 per Org)
-- ========================================
INSERT INTO project (organization_id, title, description, location, project_date)
VALUES
-- BrightFuture Builders (Org 1)
(1, 'Community Center Roofing', 'Repairing the storm-damaged roof of the local youth center.', 'Downtown Youth Hub', '2026-10-12'),
(1, 'Eco-Park Bench Assembly', 'Building and installing benches made from recycled plastics.', 'Greenways Park', '2026-10-19'),
(1, 'Sidewalk Accessibility Ramp', 'Pouring concrete ramps to improve wheelchair access.', '4th Street Crossing', '2026-11-02'),
(1, 'Library Painting Drive', 'Refreshing the interior walls of the children''s reading room.', 'Public Library Branch B', '2026-11-15'),
(1, 'Community Garden Shed', 'Constructing a tool storage facility for local growers.', 'East Side Plot', '2026-12-01'),

-- GreenHarvest Growers (Org 2)
(2, 'Fall Soil Preparation', 'Tilling and adding organic compost to prepare beds for winter.', 'Urban Farm Lot A', '2026-10-05'),
(2, 'Hydroponic Tower Setup', 'Assembling indoor vertical growing units for winter greens.', 'Community Greenhouse', '2026-10-26'),
(2, 'Harvest Festival Distribution', 'Sorting and packing fresh produce boxes for families.', 'Main Street Market', '2026-11-09'),
(2, 'Fruit Tree Pruning Workshop', 'Learning and executing proper maintenance on community orchards.', 'South Orchard', '2026-11-23'),
(2, 'Seed Saving Seminar Setup', 'Organizing workspaces and packets for an heirloom seed swap.', 'Growers Headquarters', '2026-12-10'),

-- UnityServe Volunteers (Org 3)
(3, 'Senior Center Companion Day', 'Hosting an afternoon of board games and storytelling.', 'Silver Linings Home', '2026-10-15'),
(3, 'Food Pantry Sorting', 'Checking expiration dates and organizing incoming canned goods.', 'Central Food Bank', '2026-10-22'),
(3, 'River Clean-Up Initiative', 'Clearing plastic waste and debris from the riverbank trail.', 'Waterford River Park', '2026-11-05'),
(3, 'Warm Coats Sorting Drive', 'Inspecting, sizing, and packing winter coat donations.', 'Unity Hall Gym', '2026-11-19'),
(3, 'Holiday Toy Wrap Event', 'Wrapping and labeling gift donations for local families.', 'Civic Center Hall Room 4', '2026-12-05');

-- ========================================
-- 1. Create Categories Table
-- ========================================
CREATE TABLE IF NOT EXISTS category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- ========================================
-- 2. Create Project-Category Junction Table (M:N)
-- ========================================
CREATE TABLE IF NOT EXISTS project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE CASCADE
);

-- ========================================
-- 3. Insert 3 Sample Categories
-- ========================================
INSERT INTO category (category_name)
VALUES 
('Environmental & Sustainability'),
('Community Infrastructure'),
('Education & Social Support')
ON CONFLICT (category_name) DO NOTHING;

-- ========================================
-- 4. Associate Existing Projects with Categories
-- ========================================
-- This maps your 15 existing projects to at least one category mapping
INSERT INTO project_category (project_id, category_id)
VALUES
-- BrightFuture Builders Projects (IDs 1-5) -> Infrastructure & Environment
(1, 2), (2, 1), (3, 2), (4, 2), (5, 2),
-- GreenHarvest Growers Projects (IDs 6-10) -> Environmental & Sustainability
(6, 1), (7, 1), (8, 1), (9, 1), (10, 1),
-- UnityServe Volunteers Projects (IDs 11-15) -> Education & Social Support
(11, 3), (12, 3), (13, 1), (14, 3), (15, 3)
ON CONFLICT DO NOTHING;
