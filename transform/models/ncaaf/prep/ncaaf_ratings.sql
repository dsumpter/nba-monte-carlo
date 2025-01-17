SELECT
    orig.team,
    orig.conf,
    orig.division,
    orig.team_short,
    CASE
        WHEN latest.latest_ratings = true AND latest.elo_rating IS NOT NULL THEN latest.elo_rating
        ELSE orig.elo_rating
    END AS elo_rating,
    orig.elo_rating AS original_rating,
    orig.win_total
FROM {{ ref( 'ncaaf_raw_team_ratings' ) }} orig
LEFT JOIN {{ ref( 'ncaaf_latest_elo' ) }} latest ON latest.team = orig.team
GROUP BY ALL
