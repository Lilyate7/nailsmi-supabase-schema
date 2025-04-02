-- Création des tables liées aux utilisateurs

-- Table des utilisateurs
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE,
    username TEXT UNIQUE NOT NULL,
    avatar_url TEXT,
    full_name TEXT,
    bio TEXT,
    is_artist BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_login TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    preferences JSONB DEFAULT '{}',
    is_verified BOOLEAN DEFAULT FALSE,
    auth_provider TEXT DEFAULT 'email',
    device_tokens TEXT[] DEFAULT ARRAY[]::TEXT[]
);

-- Créer des index pour améliorer les performances des recherches
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_is_artist ON users(is_artist);

-- Table des profils d'artistes (pour les utilisateurs qui sont des artistes)
CREATE TABLE IF NOT EXISTS artist_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    salon_name TEXT,
    salon_address TEXT,
    salon_location GEOGRAPHY(POINT),
    salon_phone TEXT,
    salon_website TEXT,
    business_hours JSONB DEFAULT '{}',
    specialties TEXT[],
    price_range NUMERIC[] DEFAULT ARRAY[0, 0]::NUMERIC[],
    rating NUMERIC DEFAULT 0,
    reviews_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_verified BOOLEAN DEFAULT FALSE,
    CONSTRAINT unique_user_artist_profile UNIQUE (user_id)
);

-- Créer des index pour améliorer les performances
CREATE INDEX IF NOT EXISTS idx_artist_profiles_user_id ON artist_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_artist_profiles_location ON artist_profiles USING GIST (salon_location);
CREATE INDEX IF NOT EXISTS idx_artist_profiles_rating ON artist_profiles(rating);

-- Trigger pour mettre à jour le champ updated_at lorsqu'un profil est modifié
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_artist_profiles_updated_at
BEFORE UPDATE ON artist_profiles
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();