# NailsMi - Structure Supabase

Ce dépôt contient tous les scripts SQL nécessaires pour configurer la base de données Supabase pour l'application NailsMi.

## Comment utiliser ces scripts

1. Connectez-vous à votre tableau de bord Supabase (https://app.supabase.io)
2. Sélectionnez votre projet
3. Cliquez sur "SQL Editor" dans le menu de gauche
4. Créez une nouvelle requête en cliquant sur le bouton "+" en haut
5. Copiez-collez le contenu des scripts SQL dans l'ordre suivant:

### Ordre d'exécution des scripts

1. `01_extensions.sql` - Active les extensions nécessaires
2. `02_users_tables.sql` - Crée les tables relatives aux utilisateurs
3. `03_designs_tables.sql` - Crée les tables relatives aux designs
4. `04_interactions_tables.sql` - Crée les tables pour les interactions sociales
5. `05_recommendations_tables.sql` - Crée les tables pour le système de recommandation
6. `06_messaging_tables.sql` - Crée les tables pour la messagerie
7. `07_bookings_tables.sql` - Crée les tables pour les réservations
8. `08_triggers_functions.sql` - Ajoute les triggers et fonctions
9. `09_security_policies.sql` - Configure les politiques de sécurité RLS

### Recommandation

Exécutez les scripts un par un, dans l'ordre indiqué, pour éviter les problèmes de dépendances entre les tables.

## Structure de la base de données

Cette base de données est conçue pour:

1. **Performance** - Des index sur les colonnes fréquemment recherchées
2. **Évolutivité** - Une séparation claire des préoccupations dans différentes tables
3. **Algorithme de recommandation** - Un système complet pour suivre les interactions, analyser les préférences et générer des recommandations
4. **Sécurité** - Des politiques RLS pour contrôler l'accès aux données
5. **Fonctionnalités sociales** - Abonnements, messages, réservations
6. **Géolocalisation** - Support pour rechercher des designs à proximité