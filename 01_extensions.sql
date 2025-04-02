-- Activer les extensions nécessaires pour le fonctionnement de la base de données

-- Extension pour la génération d'UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Extension pour les fonctionnalités géographiques
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Extension pour la recherche full-text (pour les recherches de designs)
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Extension pour les opérations cryptographiques (utile pour hachage de mots de passe si nécessaire)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";