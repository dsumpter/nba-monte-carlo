SELECT
    S.id AS game_id,
    S.date as date,
    'reg_season' AS type,
    0 as series_id,
    V.conf AS visiting_conf,
    V.team AS visiting_team,
    COALESCE(R.visiting_team_elo_rating,V.elo_rating::int) AS visiting_team_elo_rating,
    H.conf AS home_conf,
    H.team AS home_team,
    COALESCE(R.home_team_elo_rating,H.elo_rating::int) AS home_team_elo_rating
FROM {{ ref( 'nba_raw_schedule' ) }} AS S
LEFT JOIN {{ ref( 'nba_ratings' ) }} V ON V.team_long = S.VisTm
LEFT JOIN {{ ref( 'nba_ratings' ) }} H ON H.team_long = S.HomeTm
LEFT JOIN {{ ref( 'nba_elo_rollforward' ) }} R ON R.game_id = S.id
WHERE S.type = 'reg_season'
GROUP BY ALL