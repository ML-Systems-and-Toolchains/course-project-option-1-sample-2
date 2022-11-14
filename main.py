import psycopg

from consts import *


# Test PG adapter
def test():
    with psycopg.connect("dbname=postgres user=postgres") as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT 
                * 
                FROM 
                    pg_catalog.pg_namespace
                ORDER BY 
                    nspname;
            """
            )

            for record in cur.fetchall():
                print(record)


def schema():
    with psycopg.connect("dbname=postgres user=postgres") as conn:

        # Open a cursor to perform database operations
        with conn.cursor() as cur:

            # Execute a command: this creates a new table
            cur.execute(SCHEMA_STR)
            cur.execute(TABLE_STR)
