

    SELECT COALESCE(COUNT(*),0) AS records
    FROM "mdsbox"."main"."post_season_schedule"
    HAVING COUNT(*) = 0

