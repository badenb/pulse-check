# Migration Workflow

Follow these steps whenever you add or modify a migration:

1. **Register your migration**  
   - In `configure.swift`, import and add your new migration:  
     ```swift
     app.migrations.add(CreateYourNewMigration())
     ```
   - Remove or replace any old migrations you no longer need.

2. **Rebuild your Docker images**  
   Whenever you change code (including migration registration), rebuild so the containers pick up your changes:  
   ```bash
   docker compose build app
   docker compose build migrate
   ```

3. **Start the database container**  
   Ensure Postgres is up and using the right credentials/DB name:  
   ```bash
   docker compose up -d db
   ```

4. **Apply migrations inside Docker**  
   Run the migrate service to apply all pending migrations:  
   ```bash
   docker compose run migrate
   ```
   You should see logs for each migration being applied (e.g. “Created reports table”).

5. **Verify the new schema**  
   Open a `psql` shell in the `db` container:  
   ```bash
   docker compose exec db psql -U vapor_username -d vapor_database
   ```
   Then at the `psql` prompt:
   ```sql
   \dt             -- List tables; look for your new table
   \d your_table   -- Describe your new table’s columns
   ```

6. **Connect from your host or IDE**  
   - **Host psql**  
     ```bash
     psql postgresql://vapor_username:vapor_password@localhost:5432/vapor_database
   ```
   - **DBeaver / GUI**  
     - **JDBC URL:** `jdbc:postgresql://localhost:5432/vapor_database`  
     - **User:** `vapor_username`  
     - **Password:** `vapor_password`

7. **(Optional) Handle port conflicts**  
   If you have a local Postgres on 5432, remap Docker’s port in `docker-compose.yml`:
   ```yaml
   services:
     db:
       ports:
         - "5433:5432"
   ```
   - Then restart and connect on port **5433** instead.

> **Tip:** If you ever see `PSQLError – role "vapor_username" does not exist`, it means your app is pointing at a Postgres that wasn’t created by Docker. Either run the Docker-based migration or manually create the role/database to match your Vapor config.
